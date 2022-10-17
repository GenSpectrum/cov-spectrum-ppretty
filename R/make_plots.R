# This script is for different cov-spectrum plots

library(ggplot2)

source("plot_shared_elements.R")
source("plot_helper_functions.R")

#' Make a plot. Depending on the config information, will call another function to make a specific type of plot.
#' @param config Configuration information
#' @param data Data to plot
#' @return A ggplot object
make_plot <- function(config, data) {
  # TODO: implement a config entry that actually details what type of plot
  plot <- plot_sequences_over_time(sequences_over_time_data = data)
  # TODO: apply config options like aspect ratio, transparent background
  return(plot)
}

# Sequences over time
plot_sequences_over_time <- function(sequences_over_time_data) {
  date_scale <- get_date_scale(sequences_over_time_data)

  plot <- ggplot(
    data = sequences_over_time_data,
    aes(x = as.Date(date), y = count)
  ) + # TODO: is count a standard column name?
    geom_line() +
    date_scale +
    labs(
      x = element_blank(),
      y = "Proportion of all samples",
      title = "Sequences over time"
    ) + # TODO: add variant name to title?
    shared_theme

  # Add uncertainty bounds if present in data
  if ("estimatedCasesCILower" %in% colnames(data)) {
    plot <- plot +
      geom_ribbon(
        aes(ymin = estimatedCasesCILower, ymax = estimatedCasesCIUpper),
        alpha = 0.5
      )
  }

  return(plot)
}
