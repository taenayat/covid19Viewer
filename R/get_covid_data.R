#' @title Get Covid-19 Data
#'
#' @description Gets data of confirmed cases, deaths, and recovered cases of
#' covid-19 around the globe. columns contain type ( c("confirmed","deaths","recovered") ),
#' country, lat, long, and days (start from 2020-01-22 until now)
#'
#' @return a data.frame of updated covid19 data
#' @export
#' @importFrom  dplyr %>%
#' @importFrom  dplyr mutate
#' @importFrom  dplyr select
#' @importFrom  dplyr bind_rows
#' @importFrom  dplyr arrange
#' @importFrom  utils read.csv
#'
#' @references \url{https://github.com/CSSEGISandData/COVID-19}
#'
#' @examples
#' \dontrun{
#' get_covid_date()
#' }

get_covid_data <- function() {
  library(dplyr)
  confirmed <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_confirmed_global.csv")
  confirmed <- confirmed %>%
    mutate(type = "confirmed") %>%
    select(type, everything())

  deaths <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_deaths_global.csv")
  deaths <- deaths %>%
    mutate(type = "deaths") %>%
    select(type, everything())

  recovered <- read.csv("https://raw.githubusercontent.com/CSSEGISandData/COVID-19/master/csse_covid_19_data/csse_covid_19_time_series/time_series_covid19_recovered_global.csv")
  recovered <- recovered %>%
    mutate(type = "recovered") %>%
    select(type, everything())


  covid_data <- bind_rows(confirmed, deaths, recovered)
  covid_data <- covid_data %>% arrange(Country.Region)

  use_data(covid_data, overwrite = TRUE)
  return(covid_data)
}
