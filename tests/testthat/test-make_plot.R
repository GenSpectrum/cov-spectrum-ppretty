library("tidyverse")

test_that("estimated cases lineplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_01.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))
})

test_that("estimated cases lineplot 02 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_02.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))
})

test_that("estimated cases lineplot 03 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_03.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))
})

test_that("estimated cases barplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_01_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_condition(show(p))
})

test_that("estimated cases barplot 02 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_02_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_error(show(p))
})

test_that("estimated cases barplot 03 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_03_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_condition(show(p))
})

test_that("sequences over time lineplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_01.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))
})

test_that("sequences over time lineplot 02 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_02.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))
})

test_that("sequences over time lineplot 03 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_03.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))
})

test_that("sequences over time barplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_01_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_condition(show(p))
})

test_that("sequences over time barplot 02 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_02_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_condition(show(p))
})

test_that("sequences over time barplot 03 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_03_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_condition(show(p))
})

test_that("sequences over time collection lineplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_collection_01.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))
})

test_that("sequences over time collection barplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_collection_01_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_condition(show(p))
})

test_that("sequences over time country comparison lineplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_country-comparison_01.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_error(show(p))  # warning about missing values expected
})

test_that("sequences over time country comparison lineplot 02 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_country-comparison_02.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_error(show(p))  # warning about missing values expected
})

test_that("sequences over time country comparison lineplot 03 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_country-comparison_03.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_error(show(p))  # warning about missing values expected
})

test_that("sequences over time stratified by division lineplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_stratified-by-division_01.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))  # warning about missing values expected
})

test_that("sequences over time stratified by division barplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_stratified-by-division_01_bar.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomCol")
  expect_no_condition(show(p))  # warning about missing values expected
})

test_that("sequences over time variant comparison lineplot 01 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_variant-comparison_01.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))  # warning about missing values expected
})

test_that("sequences over time variant comparison lineplot 02 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_variant-comparison_02.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))  # warning about missing values expected
})

test_that("sequences over time variant comparison lineplot 03 works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/sequences-over-time_variant-comparison_03.json")))
  p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
  expect_identical(class(p$layers[[1]]$geom)[[1]], "GeomLine")
  expect_no_condition(show(p))  # warning about missing values expected
})
