library(plumber)
library(ppretty)  # assumes package built from github in Dockerfile

run_app <- function() {
  pr("plumber/endpoints.R") %>%
    pr_run(
      host = "0.0.0.0",
      port = 7090
    )
}