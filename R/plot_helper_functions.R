# This script contains helper functions for plotting data for cov-spectrum

library(lubridate)
library(ggplot2)
library(RColorBrewer)

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

#' Get the appropriate geometry and aesthetic specifications for the plot type
#' @param plot_type One of "line" or "bar"
#' @return A list of geometry (`geom_` functions) and aesthetic specifications
get_bar_vs_line_specs <- function(plot_type) {
  if (plot_type == "line") {
    bar_line_specs <- list(
      "geom_bar_or_line" = geom_line,
      "geom_errbar_or_ribbon" = geom_ribbon,
      "alpha_estimate" = 1,
      "alpha_uncertainty" = 0.5
    )
  } else if (plot_type == "bar") {
    bar_line_specs <- list(
      "geom_bar_or_line" = geom_col,
      "geom_errbar_or_ribbon" = geom_errorbar,
      "alpha_estimate" = 0.5,
      "alpha_uncertainty" = 1
    )
  }
  return(bar_line_specs)
}

#' Get a diverging color scale that will always be the same for the same set of locations
#' @param locations List of unique locations
#' @return A color scale of the type scale_color_manual()
get_color_scale <- function(locations) {
  n_locations <- length(locations)
  if (n_locations == 0) {
    error("No locations specified for color scale")
  } else if (n_locations <= 8) {
    colors <- RColorBrewer::brewer.pal(n = n_locations, name = "Dark2")
  } else {
    colors <- terrain.colors(n = n_locations)
  }
  names(colors) <- sort(locations)
  color_scale <- scale_color_manual(values = colors)
  return(color_scale)
}

