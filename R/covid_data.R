#' covid19 data for countries
#'
#' The corona dataset provides a tidy format dataset of the COVID-19 epidemic
#'
#' @docType data
#' @usage data(corona)
#' @format An object of class \code{"data.frame"}
#' \describe{
#' \item{Date}{The date of the summary}
#' \item{Country}{The country or region name}
#' \item{type}{the type of case (i.e., confirmed, death)}
#' \item{value}{the number of daily cases (corresponding to the case type)}
#' }
#' @references The raw data pulled and arranged by the Johns Hopkins University
#' @keywords datasets
#' @examples
#' \dontrun{
#' data(corona)
#' head(corona)
#' }
