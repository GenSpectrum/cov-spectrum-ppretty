library(tidyverse)
source("plots/example_plot.R")


# ----- Example request data -----

config_ex <- jsonlite::fromJSON('{
    "aspectRatio": 1.5,
    "backgroundTransparent": true
}')

plot_data_ex <- jsonlite::fromJSON('[
    {"date": "2021-01-01", "count": 3},
    {"date": "2021-01-02", "count": 5},
    {"date": "2021-01-03", "count": 7},
    {"date": "2021-01-04", "count": 11}
]')


# ----- Plumber endpoint definitions -----

#* Introduce the API
#* @get /
#* @serializer unboxedJSON
function() {
  response <- list(message = "This is ppretty.")
  return(response)
}

#* Draw a bar plot
#* @post /plot
#* @param config:object
#* @param data:object
#* @serializer png
function(config = config_ex, data = plot_data_ex) {
  print(config)

  data_transformed <- transformData(data)
  print(data_transformed)

  p <- plot_example(data_transformed)
  return(print(p))
}


# ----- Helper functions to clean and transform the input data -----

transformData <- function(data) {
  # Use a tibble
  d <- tibble(data)

  # If there is a date column, change the column type
  if ("date" %in% names(d)) {
    d <- d %>% mutate(date = as.Date(date))
  }

  return(d)
}
