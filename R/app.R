library(plumber)

pr("R/endpoints.R") %>%
  pr_run(
    host = "0.0.0.0",
    port = 7090
  )
