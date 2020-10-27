covid_time_series <- function(country = "Iran", interval_start = "20-05-22", interval_end = Sys.Date()){
  library(lubridate)
  # library(tidyr)
  # library(ggthemes)
  # maybe data isn't updated for today
  if (interval_end == Sys.Date()){
    day(interval_end) <- day(interval_end) - 1
  }

  days <- seq(as_date(interval_start), as_date(interval_end), "day")
  form_conv <- function(date){
    paste("X", paste(month(date),day(date),substr(year(date),1,2), sep = '.'), sep = '')
  }
  days_new <- purrr::map_chr(days,form_conv)

  data("covid_data")
  # time_series <- covid_data %>%
  #   filter(Country.Region == country) %>%
  #   # select(days_new) %>%
  #   mutate(total = rowSums(.[days_new])) %>%
  #   select(type, Country.Region, total) %>% view
  time_series <- covid_data %>%
    filter(Country.Region == country) %>%
    select(type,days_new) %>%
    group_by(type) %>%
    summarise_all(sum) %>%
    column_to_rownames("type") %>%
    t %>%
    data.frame %>%
    rownames_to_column("date_temp") %>%
    tidyr::separate(date_temp, into = c("month", "day", "year")) %>%
    mutate(month = substr(month, 2,nchar(month))) %>%
    mutate(date = as_date(paste(year,month,day, sep = '-'))) %>%
    select(-day, -month, -year) %>%
    select(date, everything()) %>%
    rename(confirmed_cum = confirmed, deaths_cum = deaths, recovered_cum = recovered) %>%
    mutate(confirmed = confirmed_cum - lag(confirmed_cum)) %>%
    mutate(deaths = deaths_cum - lag(deaths_cum)) %>%
    mutate(recovered = recovered_cum - lag(recovered_cum)) %>%
    slice(2:nrow(.))


  # ggplot(time_series %>% filter(type == "confirmed"), aes(total)) +
  ggplot() +
    geom_bar(time_series, mapping = aes(x = date, y = confirmed, fill = "confirmed"), stat = "identity") +
    geom_bar(time_series, mapping = aes(x = date, y = recovered, fill = "recovered"), stat = "identity") +
    geom_bar(time_series, mapping = aes(x = date, y = deaths, fill = "deaths"), stat = "identity") +
    scale_fill_manual(values = c("confirmed"="blue", "recovered"="green", "deaths"="red")) +
    labs(x = element_blank(), y = "Number of Cases") +
    ggthemes::theme_hc()
}
