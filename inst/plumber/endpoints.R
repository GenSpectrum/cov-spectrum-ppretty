# ----- Requirements -----

library(tidyverse)


# ----- Example request data -----

config_ex <- jsonlite::fromJSON('{
    "plotName": "sequences-over-time",
    "plotType": "line"
}')

plot_data_ex <- jsonlite::fromJSON('[
    {"date": "2022-09-22", "proportion": 0.0177, "proportionCILow": 0.0031, "proportionCIHigh": 0.0938},
    {"date": "2022-09-23", "proportion": 0.0142, "proportionCILow": 0.0023, "proportionCIHigh": 0.0844},
    {"date": "2022-09-24", "proportion": 0.0216, "proportionCILow": 0.0045, "proportionCIHigh": 0.0968},
    {"date": "2022-09-25", "proportion": 0.019, "proportionCILow": 0.0037, "proportionCIHigh": 0.0923}
]')


# ----- Plumber endpoint definitions -----

#* Introduce the API
#* @get /
#* @serializer unboxedJSON
function() {
  response <- list(message = "This is ppretty.")
  return(response)
}

#* Draw a plot
#* @post /plot
#* @param config:object
#* @param data:object
#* @serializer png
function(config = config_ex, data = plot_data_ex) {
  print(config)

  data_transformed <- transformData(data)
  print(data_transformed)

  p <- make_plot(config = config, data = data_transformed)
  return(print(p))
}

#* Save a plot to a file
#* @post /save
#* @param config:object
#* @param data:object
#* @serializer json
function(config = config_ex, data = plot_data_ex) {

  data_transformed <- transformData(data)

  p <- make_plot(config = config, data = data_transformed)
  request_hash <- get_request_hash(config = config, data = data)
  path <- save_plot(plot = p, filename = request_hash)
  return(path)
}
