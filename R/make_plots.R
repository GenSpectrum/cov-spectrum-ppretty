# This script is for different cov-spectrum plots
# Test with: test_file(path = "tests/testthat/test-make_plots.R")

library(ggplot2)

#' Make a plot. Depending on the config information, will call another function to make a specific type of plot.
#' @param config Configuration information
#' @param data Data to plot
#' @return A ggplot object
make_plot <- function(config, data) {
  # TODO: implement a config entry that actually details what type of plot
  plot <- plot_sequences_over_time(config = config, sequences_over_time_data = data)
  # TODO: apply config options like aspect ratio, transparent background
  return(plot)
}

#' Plot sequences over time
#' @param config Configuration information
#' @param sequences_over_time_data
#' @return A ggplot object
plot_sequences_over_time <- function(config, sequences_over_time_data) {
  date_scale <- get_date_scale(sequences_over_time_data)

  if (config$plotType == "line") {
    geom_bar_or_line <- geom_line
    geom_errbar_or_ribbon <- geom_ribbon
  } else if (config$plotType == "bar") {
    geom_bar_or_line <- geom_bar
    geom_errbar_or_ribbon <- geom_errorbar
  }

  plot <- ggplot(
    data = sequences_over_time_data,
    aes(x = as.Date(date), y = proportion)
  ) + # TODO: is count a standard column name?
    geom_bar_or_line() +
    date_scale +
    labs(
      x = element_blank(),
      y = "Proportion of all samples",
      title = "Sequences over time"
    ) + # TODO: add variant name to title?
    shared_theme

  # Add uncertainty bounds if present in data
  if ("proportionCILow" %in% colnames(data)) {
    plot <- plot +
      geom_errbar_or_ribbon(
        aes(ymin = proportionCILow, ymax = proportionCIHigh),
        alpha = 0.5
      )
  }

  return(plot)
}
