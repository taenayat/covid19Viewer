library(dplyr)

get_covid_data <- function() {

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

  use_data(covid_data)
  return(covid_data)
}
