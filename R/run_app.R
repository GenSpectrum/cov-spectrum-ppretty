library(plumber)

run_app <- function() {
  pr("inst/plumber/endpoints.R") %>%
    pr_run(
      host = "0.0.0.0",
      port = 7090
    )
}
