test_that("saving the plots doesn't error", {
  test_files <- list.files(path = test_path("example_data/requests/"))
  for (file in test_files) {
    request <- jsonlite::fromJSON(txt = file(test_path(paste0("example_data/requests/", file))))
    p <- make_plot(config = request$config, data = transformData(request$data), metadata = request$metadata)
    expect_no_error(save_plot(plot = p, filename = gsub(x = file, pattern = ".json", replacement = "")))
  }
})
