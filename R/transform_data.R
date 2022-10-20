#' Transform and clean data
#' @param data The input data
#' @return A cleaned and transformed tibble.
transformData <- function(data) {
  # Use a tibble
  d <- tibble(data)

  # If there is a date column, change the column type
  if ("date" %in% names(d)) {
    d <- d %>% mutate(date = as.Date(date))
  }

  return(d)
}
