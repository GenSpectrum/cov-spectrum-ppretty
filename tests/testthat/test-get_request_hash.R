test_that("hashing the request works", {
  request <- jsonlite::fromJSON(txt = file(test_path("example_data/requests/estimated-cases_01.json")))
  hash <- get_request_hash(config = request$config, data = request$data)
  expect_identical(hash, "02152736da00a9b8f8a5303d8aa90db65d6a649f32f8dfe57c2d9bc4fe1041d9")
})
