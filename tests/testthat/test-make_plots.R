# This sourcing messiness is here because the code is not structured as an R package yet we use testthat
source(test_path("../../R/make_plots.R"))
source(test_path("../../R/plot_shared_elements.R"))
source(test_path("../../R/plot_helper_functions.R"))

library("tidyverse")

test_that("sequences over time lineplot is a ggplot", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_01.json")))
  p <- make_plot(config = request$config, data = request$data)
  expect_is(p,"ggplot")
})

test_that("sequences over time lineplot is a lineplot", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_01.json")))
  p <- make_plot(config = request$config, data = request$data)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
})
