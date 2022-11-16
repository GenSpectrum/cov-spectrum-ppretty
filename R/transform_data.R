#' Transform and clean data
#' @param data The input data
#' @return A cleaned and transformed tibble.
#' @export
transformData <- function(data) {
  # Use a tibble
  d <- tibble(data)

  # Standardize the date column to be called "date" with appropriate column type
  if ("date" %in% names(d)) {
    d <- d %>% mutate(date = as.Date(date))
  } else if ("firstDayInWeek" %in% names(d)) {
    d <- d %>% mutate(date = as.Date(firstDayInWeek))
  }

  return(d)
}
