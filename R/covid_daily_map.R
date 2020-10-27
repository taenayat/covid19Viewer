library(dplyr)
library(ggplot2)
library(ggmap)

covid_daily_map <- function(date = "20-10-23", type = "deaths"){
  library(dplyr)
  library(ggplot2)
  library(ggmap)

  #convert date from "yy-mm-dd" to "mm.dd.yy"
  date_ <- paste(lubridate::month(date),lubridate::day(date),lubridate::year(date), sep = '.')
  date_ <- paste("X", date_, sep = '')
  #local variables
  type_ <- type

  # covid_data <- get_covid_data() #load data if this function has been run, otherwise run it.
  # load(file.path(getwd(), "data", "covid_data.rda")) #covid_data

  covid_data_path <- file.path(getwd(), "data", "covid_data.rda")
  if (file.exists(covid_data_path)){
    # data exists
    # print("data exists")
    covid_data_date <- file.info(covid_data_path)$mtime %>% lubridate::as_datetime() %>% lubridate::date()
    if (Sys.Date() == covid_data_date){
      #file is up-to-date
      # print("file is up-to-date")
      # print(covid_data_date)
      # load(file.path(getwd(), "data", "covid_data.rda")) #covid_data
      data("covid_data")
    } else{covid_data <- get_covid_data()}
  } else {covid_data <- get_covid_data()}

  type_filtered <- covid_data %>%
    filter(type == type_)

  #maybe some error handling here

  date_filtered <- type_filtered %>%
    select( Lat, Long, date_) %>%
    rename(cases = date_)
  #maybe some error handling here

  plot_data <- date_filtered %>%
    # mutate(cases = as.integer(cases / 1000))
    mutate(cases = cases / 1000)

  # map <- get_stamenmap(bbox = c(left=-155, bottom=-55, right=180, top=70), zoom = 4)
  # load(file.path(getwd(), "data", "map.rda")) #map
  data("map")
  ggmap(map) +
    geom_point(plot_data, mapping = aes(x = Long, y = Lat, size = cases, color = -cases))+
    theme_void()+
    theme(legend.position = "none")
}
