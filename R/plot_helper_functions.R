# This script contains helper functions for plotting data for cov-spectrum

library(lubridate)
library(ggplot2)

#' Get an appropriate date scale, depending on the date range of the data
#' @param data The data to plot
#' @param date_colname The column name for the data data
#' @param max_breaks Maximum number of breaks for the scale. Note: will be ignored if number of years > max_breaks.
#' @return A date scale of the type scale_x_date()
get_date_scale <- function(data, date_colname = "date", max_breaks = 10) {
  # Declare break options for the scale in increasing order of coarseness
  break_options <- c("1 day", "1 week", "1 month", "1 year") # last is maximum regardless of max_breaks
  break_units <- c("days", "weeks", "months", "years")
  break_labels <- c("%d-%m-%y", "%d-%m-%y", "%b %y", "%Y")

  # Increase coarseness of scale if too many breaks
  n_breaks <- max_breaks + 1
  i <- 0
  while (n_breaks > max_breaks & i < length(break_options)) {
    i <- i + 1
    n_breaks <- as.numeric(
      as.period(difftime(
        max(data[[date_colname]]), min(data[[date_colname]])
      )),
      break_units[i]
    )
  }

  # Define scale
  scale <- scale_x_date(date_breaks = break_options[i], date_labels = break_labels[i])
  return(scale)
}
