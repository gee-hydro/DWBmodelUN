#' @title Sogamoso River Basin data
#'
#' @format  The list contains
#' \itemize{
#'   \item{basins:}{Shapefile featuring subbasins across the Sogamoso Basin.}
#'   \item{cells:}{Data frame (3 columns by 677 rows), cells coordinates and its ID number.}
#'   \item{dwb_results:}{List, it contains the DWB model's outputs in matrix format, q_total- total runoff,
#'         aet- actual evapotranspiration, r- recharge, qd- Surface runoff, qd- baseflow,
#'         s- soil storage, g- groundwater storage.}
#'   \item{GRU:}{Raster, it represents the ten (10) Grouped Response Units across the Sogamoso River Basin.}
#'   \item{In_ground:}{Raster, initial conditions in the groundwater storage.}
#'   \item{In_storage:}{Raster, initial conditions in the soil storage.}
#'   \item{P_sogamoso:}{Data frame, it should represent the cells in each row, and the precipitation
#'         info. by month in each column. The cell rank should match the cell ID in the cells data frame. The
#'         first two columns are the coordinates of the cells}
#'   \item{param:}{Data frame, it should represent a GRU in each row, and parameter values in each
#'         column. GRU rank should match the GRU number used in the GRU raster.}
#'   \item{PET_sogamoso:}{Data frame, it contains evapotranspiration data, representing the cells in each row, 
#'                  and the evapotranspiration info. by month in each column. 
#'                  The cell rank should match the cell ID in the cells data frame.The
#'                  first two columns are the coordinates of the cells}
#'   \item{r.cells:}{Raster, data frame Cells converted to raster format.}
#'   \item{setup_data:}{Data frame, it contains the set-up and printing options to run the DWBmodelUN.
#'    It consists of 11 parameters: the first seven are configurations of orders whose values can be 
#'    'yes' or 'no', indicating 1) If the model must be calibrated, 
#'    2) If the variables must be saved in raster format and which variables 3) R - Total runoff , 
#'    4) S - Soil moisture storage, 5) AET - Actual evapotranspiration, 6) Qd - Surface runoff , 
#'    and 7) Qb - Base flow.  The last four variables are dates and refer to the times of the 
#'    input series, and the start and end times of the simulation and calibration of the model.}
#'    \item{EscSogObs:}{Data frame, it contains runoff time series measured at 32 stations within the basin.
#'    These gauges belong to the IDEAM monitoring network.}
#'    \item{simDWB.sogamoso:}{Data frame, it contains simulated runoff time series at the same 32 
#'    stations within the basin.}
#' }
#' 
"sogamoso"

#' basins
#' 
#' The polygons of the 23 subbasins across the Sogamoso Basin
#' 
#' @format SpatialPolygonsDataFrame (S4)
#' \describe{
#'   \item{basins}{Shapefile featuring subbasins across the Sogamoso Basin.}
#' }
#'
#' @references
#' Duque-Gardeazabal, N. (2018). Estimation of rainfall fields in data scarce colombian watersheds,
#' by blending remote sensed and rain gauge data, using kernel functions. Master thesis.
#' Universidad Nacional de Colombia, Bogotá, Colombia. 
#'
"basins"

#' cells
#' 
#' Coordinates (Latitude and Longitude) and ID number of cells in Sogamoso River Basin
#' 
#' @format data.frame
#' \describe{
#'   \item{cells}{Data frame (3 columns by 677 rows), cells coordinates and its ID number.}
#' }
#'
#' @references
#' Duque-Gardeazabal, N. (2018). "Estimation of rainfall fields in data scarce colombian watersheds,
#' by blending remote sensed and rain gauge data, using kernel functions". Master thesis.
#' Universidad Nacional de Colombia, Bogotá, Colombia.
#'
"cells"

#' GRU
#' 
#' Raster data of Group Response Units in Sogamoso River Basin
#' 
#' @format RasterLayer
#' \describe{
#'   \item{GRU}{Raster, it represents the ten (10) Group Response Units across the Sogamoso River Basin.}
#' }
"GRU"

#' In_ground
#' 
#' Initial conditions in the soil storage in DWB model of Sogamoso River Basin
#' 
#' @format RasterLayer
#' \describe{
#'   \item{In_ground}{Raster, initial conditions in the soil storage.}
#' }
"In_ground"

#' In_storage
#' 
#' Initial conditions in the groundwater storage in DWB model of Sogamoso River Basin
#' 
#' @format RasterLayer 
#' \describe{
#'   \item{In_storage}{Raster, initial conditions in the groundwater storage.}
#' }
"In_storage"

#' P_sogamoso
#' 
#' Distributed monthly precipitation in Sogamoso River Basin from January 2012 to December 2016
#' 
#' @format data.frame
#' \describe{
#'   \item{P_sogamoso}{Data frame, it should represent the cells in each row, and the precipitation
#'         info. by month in each column. The cell rank should match the cell ID in the cells data frame.}
#' }
#'
#' @references
#' Duque-Gardeazabal, N. (2018). "Estimation of rainfall fields in data scarce colombian watersheds,
#' by blending remote sensed and rain gauge data, using kernel functions". Master thesis.
#' Universidad Nacional de Colombia, Bogotá, Colombia. 
#'
"P_sogamoso"

#' param
#' 
#' Values to four parameters (\eqn{\alpha-1}, \eqn{\alpha-2}, \emph{\code{d}}, \emph{\code{S_max}}) of DWB model in each GRU 
#' 
#' @format data.frame
#' \describe{
#'   \item{param}{Data frame, it should represent a GRU in each row, and parameter values in each
#'         column. GRU rank should match the GRU number used in the GRU raster.}
#' }
"param"

#' PET_sogamoso
#' 
#' Distributed monthly potential evapotranspiration in Sogamoso River Basin from January 2012 to December 2016
#' 
#' @format data.frame
#' \describe{
#'   \item{PET_sogamoso}{Data frame, it contains evapotranspiration data, representing the cells in each row, 
#'                  and the evapotranspiration info. by month in each column. 
#'                  The cell rank should match the cell ID in the cells data frame.}
#' }
#'
#' @references
#' Duque-Gardeazabal, N. (2018). "Estimation of rainfall fields in data scarce colombian watersheds,
#' by blending remote sensed and rain gauge data, using kernel functions". Master thesis.
#' Universidad Nacional de Colombia, Bogotá, Colombia.
#'
"PET_sogamoso"

#' r.cells
#' 
#' Sogamoso basin raster, which lists the number of total cells
#' 
#' @format RasterLayer
#' \describe{
#'   \item{r.cells}{Raster, data frame Cells converted to raster format.}
#' }
"r.cells"

#' setup_data
#' 
#' Data.frame with the initial configuration of the model run
#' 
#' @format data.frame
#' \describe{
#'    \item{setup_data}{Data frame, contains the set-up and print options to run the DWBmodelUN.
#'    It consists of 11 parameters: the first seven are configurations of orders whose values can be 
#'    'yes' or 'no', indicating 1) If the model must be calibrated, 
#'    2) If the variables must be saved in raster format and which variables 3) R - Total runoff , 
#'    4) S - Soil moisture storage, 5) AET - Actual evapotranspiration, 6) Qd - Surface runoff , 
#'    and 7) Qb - Base flow.  The last four variables are dates and refer to the times of the 
#'    input series, and the start and end times of the simulation and calibration of the model.}
#' }
"setup_data"

#' EscSogObs
#' 
#' Flow rates observed in Sogamoso River Basin at 32 gauges from January 2012 to December 2016
#' 
#' @format data.frame
#' \describe{
#'    \item{EscSogObs}{Data frame, it contains runoff time series measured at 32 stations within the basin.
#'    These gauges belong to the IDEAM monitoring network.}
#' }
#' 
#' @references
#' Duque-Gardeazabal, N. (2018). "Estimation of rainfall fields in data scarce colombian watersheds,
#' by blending remote sensed and rain gauge data, using kernel functions". Master thesis.
#' Universidad Nacional de Colombia, Bogotá, Colombia. 
#'
"EscSogObs"

#' simDWB.sogamoso
#' 
#' Simulated runoff by the DWBmodelUN in the same stations where there were observed data from the Sogamoso basin
#' 
#' @format data.frame
#' \describe{
#'    \item{simDWB.sogamoso}{Data frame, it contains simulated runoff time series at the same 32 
#'    stations within the basin.}
#' }
#' 
#' @references
#' Duque-Gardeazabal, N. (2018). "Estimation of rainfall fields in data scarce colombian watersheds,
#' by blending remote sensed and rain gauge data, using kernel functions". Master thesis.
#' Universidad Nacional de Colombia, Bogotá, Colombia. 
#' 
"simDWB.sogamoso"

#' gru_maps
#' 
#' Spatial distribution of DWB model parameters in Sogamoso River basin
#' 
#' @format list and raster
#' \describe{
#'    \item{alpha1}{a vector with alpha1 values for each GRU}
#'    \item{alpha2}{a vector with alpha2 values for each GRU}
#'    \item{smax}{a vector with Smax values for each GRU}
#'    \item{d}{a vector with d values for each GRU}
#'    \item{alpha1R}{a raster with alpha1 values for each GRU}
#'    \item{alpha2R}{a raster with alpha2 values for each GRU}
#'    \item{smaxR}{a raster with Smax values for each GRU}
#'    \item{dR}{a raster with d values for each GRU}
#' }
#' 
"gru_maps" 