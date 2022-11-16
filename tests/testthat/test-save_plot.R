test_that("saving the plot doesn't error", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_collection_01_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_no_error(save_plot(plot = p, filename = "test"))
})
