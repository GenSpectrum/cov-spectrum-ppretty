# ----- Requirements -----

library(tidyverse)


# ----- Example request data -----

config_ex <- jsonlite::fromJSON('{
    "plotName": "sequences-over-time",
    "plotType": "line"
}')

metadata_ex <- jsonlite::fromJSON('{
    "location": "Switzerland",
    "variant": "BA.2.75* (Nextclade)"
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
function(config = config_ex, data = plot_data_ex, metadata = metadata_ex) {
  print(config)

  data_transformed <- transformData(data)
  print(data_transformed)

  p <- make_plot(config = config, data = data_transformed, metadata = metadata_ex)
  return(print(p))
}

#* Save a plot to a file
#* @post /save
#* @param config:object
#* @param data:object
#* @serializer unboxedJSON
function(req, config = config_ex, data = plot_data_ex, metadata = metadata_ex) {

  data_transformed <- transformData(data)

  p <- make_plot(config = config, data = data_transformed, metadata = metadata)
  request_hash <- get_hash(req$postBody)

  # We don't store all plots in the same directory create subdirectories to limit the number of files per directory.
  # The names of the subdirectories consist of the first characters of the request hash.
  subdirpath <- paste(substring(request_hash, 1, 2), substring(request_hash, 3, 4), sep = "/")
  dirpath <- paste0("plots/", subdirpath)
  save_plot(plot = p, filename = request_hash, dirpath = dirpath)

  return(list(path = paste0(subdirpath, "/", request_hash)))
}
