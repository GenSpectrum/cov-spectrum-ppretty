test_that("saving the plot doesn't error", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_01.json")))
  p <- make_plot(config = request$config, data = request$data)
  expect_no_error(save_plot(plot = p, filename = "test"))
})
