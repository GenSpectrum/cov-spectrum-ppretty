library(plumber)
library(ppretty)  # assumes package is installed (i.e., in Dockerfile)

run_app <- function() {
  pr("inst/plumber/endpoints.R") %>%
    pr_run(
      host = "0.0.0.0",
      port = 7090
    )
}

run_app()
