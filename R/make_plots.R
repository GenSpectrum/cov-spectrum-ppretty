# This script is for different cov-spectrum plots
# Test with: test_file(path = "tests/testthat/test-make_plots.R")

library(ggplot2)

#' Make a plot. Depending on the config information, will call another function to make a specific type of plot.
#' @param config Configuration information
#' @param data Data to plot
#' @return A ggplot object
make_plot <- function(config, data) {
  if (config$plotName %in% c("sequences-over-time", "sequences-over-time_collection")) {
    plot <- plot_sequences_over_time(config = config, data = data)
  } else if (config$plotName == "sequences-over-time_country-comparison") {
    plot <- plot_sequences_over_time_country_comparison(config = config, data = data)
  } else {
    stop(paste("Plot name", config$plotName, "is unknown"))
  }
  # TODO: apply config options like aspect ratio, transparent background
  return(plot)
}

#' Plot sequences over time
#' @param config Configuration information
#' @param data
#' @return A ggplot object
plot_sequences_over_time <- function(config, data) {
  date_scale <- get_date_scale(data)
  bar_line_specs <- get_bar_vs_line_specs(config$plotType)

  plot <- ggplot(
    data = data,
    aes(x = as.Date(date), y = proportion)
  ) +
    bar_line_specs$geom_bar_or_line(alpha = bar_line_specs$alpha_estimate) +
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
      bar_line_specs$geom_errbar_or_ribbon(
        aes(ymin = proportionCILow, ymax = proportionCIHigh),
        alpha = bar_line_specs$alpha_uncertainty
      )
  }

  return(plot)
}

#' Plot sequences over time with country comparison
#' @param config Configuration information
#' @param data
#' @return A ggplot object
plot_sequences_over_time_country_comparison <- function(config, data) {
  date_scale <- get_date_scale(data)
  bar_line_specs <- get_bar_vs_line_specs("line")  # enforce that country comparison always a line plot
  color_scale <- get_color_scale(locations = unique(data$location))

  plot <- ggplot(
    data = data,
    aes(x = as.Date(date), y = proportion, color = location)
  ) +
    bar_line_specs$geom_bar_or_line(alpha = bar_line_specs$alpha_estimate) +
    date_scale +
    color_scale +
    labs(
      x = element_blank(),
      y = "Proportion of all samples",
      title = "Sequences over time"
    ) + # TODO: add variant name to title?
    shared_theme +
    theme(legend.title = element_blank())

  return(plot)
}
