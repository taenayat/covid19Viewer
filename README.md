
# covid19Viewer

<!-- badges: start -->
<!-- badges: end -->

The goal of covid19Viewer is to get updated data and plot useful figures

## Installation

You can install the released version of covid19Viewer from [github](https://github.com/taenayat/covid19Viewer) with:

``` r
library(devtools)
install_github("taenayat/covid19Viewer")
```

## Example

This is a basic example which shows you how to create figures:

``` r
library(covid19Viewer)
covid_daily_map(date = "20-10-23", type = "deaths")
covid_time_series(country = "Iran", interval_start = "20-05-22") #end of interval is today
#get_covid_data() #to see and work with covid19 data
```

