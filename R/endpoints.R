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
function(config = config_ex, data = plot_data_ex) {
  print(config)
  print(data)
  response <- list(message = "TODO: This should be a plot")
  return(response)
}
