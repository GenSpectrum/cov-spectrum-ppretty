test_that("hashing something works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_01.json")))
  hash <- get_hash(s = request$config$plotName)
  expect_identical(hash, "6c0c4b828aa55febb5821aa2c87426e1467bc095d85704a84251c6c3f66e7f17")
})
