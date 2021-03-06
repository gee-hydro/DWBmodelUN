#' @name 
#' DWBCalculator
#' 
#' @title
#' DWB model function
#'
#' @description The function performs the distributed DWB hydrological model calculations in the defined domain and
#' time period. It is a model based on the postulates of Budyko, which stated that not only does the actual
#' evapotranspiration depend on potential evapotranspiration, but it is also constrained by water availability
#' \cite{(Budyko, 1974)}. The monthly Dynamic Water Balance is underpinned in the demand and supply limits demonstrated
#' by \code{\link{funFU}}, postulate that is applied to three variables in order to acquire the values
#' of the fluxes and state variables on a monthly time step. The named variables affected by \code{\link{funFU}} 
#' are: the available storage capacity (\emph{\code{X}}), the evapotranspiration opportunity (\emph{\code{Y}})
#' and the actual evapotranspiration (\emph{\code{ET}}). The model is controlled by four parameters: retention
#' efficiency (\eqn{\alpha-1}), evapotranspiration efficiency (\eqn{\alpha-2}),
#' soil water storage capacity (\emph{\code{S_max}}), and a recession parameter in the groundwater
#' storage that controls the baseflow (\emph{\code{d}}). 
#'
#' @param p_v matrix comprised by the precipitation records, that has as rows the number of cells that will be simulated and as columns the number of time steps to be simulated.
#' @param pet_v matrix comprised by the potential evapotranspiration records, that has as rows the number of cells that will be simulated and as columns the number of time steps to be simulated.
#' @param g_v vector comprised of the initial values of the groundwater storage, it must have as many values as cells defined to simulate.
#' @param s_v vector comprised of the initial values of the soil water storage, it must have as many values as cells defined to simulate.
#' @param alpha1_v vector comprised of the values of the retention efficiency that must be between 0 and 1, it must have as many values as cells defined to simulate.
#' @param alpha2_v vector comprised of the values of the evapotranspiration efficiency that must be between 0 and 1, it must have as many values as cells defined to simulate.
#' @param smax_v vector comprised of the values of the soil water storage capacity that must be above 0, it must have as many values as cells defined to simulate.
#' @param d_v vector comprised of the values of the recession constant that must be between 0 and 1, it must have as many values as cells defined to simulate.
#' @param calibration boolean variable which sets the printing of the waitbar that indicates the progress of the calculation of the time series results. The default 
#' value is FALSE, indicating that just one run of the model is going to be performed and there is no other waitbar such as the one used by a calibration algorithm.
#'
#' @return a list comprised by the time series of the hydrological fluxes calculated by the model. 
#' The time series have the same length as the forcings that were employed to run the model. The fluxes are:
#' 
#'  \itemize{
#'     \item \code{q_total} a numeric matrix of the total runoff - units (mm/month).
#'     \item \code{aet} a numeric matrix of actual evapotranspiration - units (mm/month).
#'     \item \code{r} a numeric matrix of groundwater recharge - units (mm/month).
#'     \item \code{qd} a numeric matrix of surface runoff - units  (mm/month).
#'     \item \code{qb} a numeric matrix of baseflow - units  (mm/month).
#'     \item \code{s} a numeric matrix of soil water storage - units  (mm).
#'     \item \code{g} a numeric matrix of groundwater storage - units (mm).
#'  }
#'  
#' @details \code{DWBCalculator} only performs one simulation of the distributed hydrological model. The decision to perform
#' other kinds of procedure, such as calibration or assimilation, is entirely on modelers' requirements and necessities.
#' A complementary function is available in the package to calibrate the model using the (\code{\link{dds}}) algorithm, which has proved to
#' be effective in calibrating models with several GRUs.
#' 
#' To start the model one should set the model features using the \code{\link{readSetup}} function, load the precipitation
#' and evapotranspiration forcings with the \code{\link{upForcing}} function, build the GRU and parameter maps with the
#' \code{\link{buildGRUmaps}} function, compare the coordinates of the uploaded datasets with the \code{\link{Coord_comparison}} (i.e. the forcings and GRU cells),
#' set the initial conditions of the soil moisture and the groundwater storage, and run the model with \code{DWBCalculator} function.
#' 
#' @author Nicolas Duque Gardeazabal <nduqueg@unal.edu.co> \cr
#' Pedro Felipe Arboleda Obando <pfarboledao@unal.edu.co> \cr
#' David Zamora <dazamoraa@unal.edu.co> \cr
#' Carolina Vega Viviescas <cvegav@unal.edu.co> \cr
#' 
#' Water Resources Engineering Research Group - GIREH
#' Universidad Nacional de Colombia - sede Bogota
#' 
#' @references 
#' Budyko. (1974). "Climate and life". New York: Academic Press, INC.
#' 
#' Zhang, L., Potter, N., Hickel, K., Zhang, Y., & Shao, Q. (2008). 
#' "Water balance modeling over variable time scales based on the 
#' Budyko framework – Model development and testing". Journal of Hydrology, 
#' 360(1-4), 117–131.
#' 
#' @import stats utils
#' 
#' @export
#'
#' @examples
#' 
#' # Load P and PET databases
#' data(P_sogamoso, PET_sogamoso)
#'  
#' # Verify that the coordinates of the databases match
#' Coord_comparison(P_sogamoso, PET_sogamoso)
#' # Load geographic info of GRU and parameters per cell
#' data(GRU, param)
#' # Construction of parameter maps from values by GRU
#' GRU.maps <- buildGRUmaps(GRU, param)
#' alpha1_v <- GRU.maps$alpha1
#' alpha2_v <- GRU.maps$alpha2
#' smax_v <- GRU.maps$smax
#' d_v <- GRU.maps$d
#' 
#' # Establish the initial modeling conditions
#' init <- init_state(GRU.maps$smaxR)
#' g_v <- init$In_ground
#' s_v <- init$In_storage
#' rm(init)
#' 
#' # Load general characteristics of modeling
#' setup_data <- readSetup(Read = TRUE)
#' Dates <- seq(as.Date( gsub('[^0-9.]','',colnames(P_sogamoso)[3]), 
#' format = "%Y.%m.%d"), 
#'              as.Date(gsub('[^0-9.]','',tail(colnames(P_sogamoso),1)) , 
#'              format = "%Y.%m.%d"), by = "month")
#' Start.sim <- which(Dates == setup_data[8,1]); End.sim <- which(Dates == setup_data[10,1])
#' # Sim.Period: the 1st two columns of the P and PET are the coordinates of the cells
#' Sim.Period <- c(Start.sim:End.sim)+2  
#' 
#' # Run DWB model
#' DWB.sogamoso <- DWBCalculator(P_sogamoso[ ,Sim.Period], 
#'                     PET_sogamoso[ ,Sim.Period],
#'                     g_v, s_v, alpha1_v, alpha2_v, smax_v, d_v)
#'                     
DWBCalculator <- function(p_v, pet_v, g_v, s_v, alpha1_v, alpha2_v, smax_v, d_v, calibration = FALSE){
  
  if (!calibration){
    # total number of cells and time steps to be simulated
    ncells <- NROW(p_v)
    nmonths <- NCOL(p_v)
    
    # ---- Set the object variables with NA values ----
    M.result <- matrix(nrow = ncells, ncol = nmonths) 
    xo <- M.result  # demand limit of rainfall retention
    x  <- M.result  # rainfall retention
    qd <- M.result  # surface runoff
    w  <- M.result  # water availability
    yo <- M.result  # demand limit of evapotranspiration opportunity
    y  <- M.result  # evapotranspiration opportunity
    r  <- M.result  # Groundwater recharge
    aet <- M.result # actual evapotranspiration
    s  <- M.result  # soil moisture storage
    qb <- M.result  # base flow
    g  <- M.result  # groundwater storage
    q_total <- M.result  # total runoff
    
    # Calculation of the variables and fluxes for the first time step
    dummy   <- smax_v - s_v
    xo[, 1] <- dummy + pet_v[, 1]
    x[, 1]  <- p_v[, 1] * funFU(PET = xo[, 1], P = p_v[, 1], alpha = alpha1_v)
    qd[, 1] <- p_v[, 1] - x[, 1]
    w[, 1]  <- x[, 1] + s_v
    yo[, 1] <- pet_v[, 1] + smax_v
    y[, 1]  <- w[, 1] * funFU(PET = yo[, 1], P = w[, 1], alpha = alpha2_v)
    r[, 1]  <- w[, 1] - y[, 1]
    aet[, 1] <- w[, 1] * funFU(PET = pet_v[, 1], P = w[, 1], alpha = alpha2_v)
    s[, 1]  <- y[, 1] - aet[, 1]
    qb[, 1] <- d_v * g_v
    g[, 1]  <- (1 - d_v) * g_v + r[, 1]
    q_total[, 1] <- qb[, 1] + qd[, 1]
    
    # Loop defined to calculate the variables and fluxes in the following timesteps
    pb <- txtProgressBar(min = 0, max = nmonths, style = 3)
    for(i in 2:nmonths){
      
      dummy   <- smax_v - s[, (i-1)]
      xo[, i] <- dummy + pet_v[, i]
      x[, i]  <- p_v[, i] * funFU(PET = xo[, i], P = p_v[, i], alpha = alpha1_v)
      qd[, i] <- p_v[, i] - x[, i]
      w[, i]  <- x[, i] + s[, (i-1)]
      yo[, i] <- pet_v[, i] + smax_v
      y[, i]  <- w[, i] * funFU(PET = yo[, i], P = w[, i], alpha = alpha2_v)
      r[, i]  <- w[, i] - y[, i]
      aet[, i] <- w[, i] * funFU(PET = pet_v[, i], P = w[, i], alpha = alpha2_v)
      s[, i]  <- y[, i] - aet[, i]
      qb[, i] <- d_v * g[, (i-1)]
      g[, i] <- (1-d_v) * g_v + r[, i]
      q_total[, i] <- qb[, i] + qd[, i]
      
      setTxtProgressBar(pb, i)
    }
    close(pb) 
  }else if(calibration){
    # total number of cells and time steps to be simulated
    ncells <- NROW(p_v)
    nmonths <- NCOL(p_v)
    
    # ---- Set the object variables with NA values ----
    M.result <- matrix(nrow = ncells, ncol = nmonths) 
    xo <- M.result  # demand limit of rainfall retention
    x  <- M.result  # rainfall retention
    qd <- M.result  # surface runoff
    w  <- M.result  # water availability
    yo <- M.result  # demand limit of evapotranspiration opportunity
    y  <- M.result  # evapotranspiration opportunity
    r  <- M.result  # Groundwater recharge
    aet <- M.result # actual evapotranspiration
    s  <- M.result  # soil moisture storage
    qb <- M.result  # base flow
    g  <- M.result  # groundwater storage
    q_total <- M.result  # total runoff
    
    # Calculation of the variables and fluxes for the first time step
    dummy   <- smax_v - s_v
    xo[, 1] <- dummy + pet_v[, 1]
    x[, 1]  <- p_v[, 1] * funFU(PET = xo[, 1], P = p_v[, 1], alpha = alpha1_v)
    qd[, 1] <- p_v[, 1] - x[, 1]
    w[, 1]  <- x[, 1] + s_v
    yo[, 1] <- pet_v[, 1] + smax_v
    y[, 1]  <- w[, 1] * funFU(PET = yo[, 1], P = w[, 1], alpha = alpha2_v)
    r[, 1]  <- w[, 1] - y[, 1]
    aet[, 1] <- w[, 1] * funFU(PET = pet_v[, 1], P = w[, 1], alpha = alpha2_v)
    s[, 1]  <- y[, 1] - aet[, 1]
    qb[, 1] <- d_v * g_v
    g[, 1]  <- (1 - d_v) * g_v + r[, 1]
    q_total[, 1] <- qb[, 1] + qd[, 1]
    
    # Loop defined to calculate the variables and fluxes in the following timesteps
    for(i in 2:nmonths){
      
      dummy   <- smax_v - s[, (i-1)]
      xo[, i] <- dummy + pet_v[, i]
      x[, i]  <- p_v[, i] * funFU(PET = xo[, i], P = p_v[, i], alpha = alpha1_v)
      qd[, i] <- p_v[, i] - x[, i]
      w[, i]  <- x[, i] + s[, (i-1)]
      yo[, i] <- pet_v[, i] + smax_v
      y[, i]  <- w[, i] * funFU(PET = yo[, i], P = w[, i], alpha = alpha2_v)
      r[, i]  <- w[, i] - y[, i]
      aet[, i] <- w[, i] * funFU(PET = pet_v[, i], P = w[, i], alpha = alpha2_v)
      s[, i]  <- y[, i] - aet[, i]
      qb[, i] <- d_v * g[, (i-1)]
      g[, i] <- (1-d_v) * g_v + r[, i]
      q_total[, i] <- qb[, i] + qd[, i]
    }
  }
  
  #---- return ----
  dwb_aux <- list(q_total = q_total, aet = aet, r = r, qd = qd, qb = qb, s = s, g = g)
  return(dwb_aux)
}