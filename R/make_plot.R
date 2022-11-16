# This script is for making different cov-spectrum plots

library(ggplot2)

#' Make a plot. Depending on the config information, will call another function to make a specific type of plot.
#' @param config Configuration information
#' @param data Data to plot
#' @return A ggplot object
#' @export
make_plot <- function(config, data) {
  # Make the correct type of plot
  if (config$plotName == "estimated-cases") {
    plot <- plot_cases_over_time(config = config, data = data)
  } else if (config$plotName %in% c("sequences-over-time", "sequences-over-time_collection")) {
    plot <- plot_sequences_over_time(config = config, data = data)
  } else if (config$plotName == "sequences-over-time_country-comparison") {
    plot <- plot_sequences_over_time_overlay(config = config, data = data, overlay_var = "location")
  } else if (config$plotName == "sequences-over-time_stratified-by-division") {
    plot <- plot_sequences_over_time_facetted(config = config, data = data, facet_var = "division")
  } else if (config$plotName == "sequences-over-time_variant-comparison") {
    plot <- plot_sequences_over_time_overlay(config = config, data = data, overlay_var = "variant")
  } else {
    stop(paste("Plot name", config$plotName, "is unknown"))
  }

  # Add acknowledgments footer to all plots
  plot <- plot + labs(caption = footnote)

  return(plot)
}

#' Plot estimated cases over time
#' @param config Configuration information
#' @param data Data to plot
#' @return A ggplot object
plot_cases_over_time <- function(config, data) {
  date_scale <- get_date_scale(data)
  bar_line_specs <- get_bar_vs_line_specs(config$plotType)

  plot <- ggplot(
    data = data,
    aes(x = as.Date(date), y = estimatedCases)
  ) +
    bar_line_specs$geom_bar_or_line(
      alpha = bar_line_specs$alpha_estimate,
      size = line_bar_size,
      color = bar_line_specs$color,
      fill = bar_line_specs$fill
    ) +
    date_scale +
    get_uncertainty_geom(data, bar_line_specs, fill_color = bar_line_specs$fill) +
    labs(
      x = element_blank(),
      y = "Estimated absolute number of cases",
      title = "Estimated cases"
    ) + # TODO: add variant name to title?
    shared_theme

  return(plot)
}

#' Plot sequences over time
#' @param config Configuration information
#' @param data Data to plot
#' @return A ggplot object
plot_sequences_over_time <- function(config, data) {
  date_scale <- get_date_scale(data)
  bar_line_specs <- get_bar_vs_line_specs(config$plotType)

  plot <- ggplot(
    data = data,
    aes(x = as.Date(date), y = proportion)
  ) +
    bar_line_specs$geom_bar_or_line(
      alpha = bar_line_specs$alpha_estimate,
      size = line_bar_size,
      color = bar_line_specs$color,
      fill = bar_line_specs$fill
  ) +
    date_scale +
    get_uncertainty_geom(data, bar_line_specs, fill_color = bar_line_specs$fill) +
    labs(
      x = element_blank(),
      y = "Proportion of all samples",
      title = "Sequences over time"
    ) + # TODO: add variant name to title?
    shared_theme

  # If variant name column present (as for collection data), facet by it
  if ("name" %in% colnames(data)) {
    plot <- plot + facet_wrap(. ~ name)
  }

  return(plot)
}

#' Plot multiple data tracks for sequences over time in one plot
#' For example, overlay sequences over time for 3 different variants in one plot.
#' @param config Configuration information
#' @param data Data to plot
#' @param overlay_var Variable name to distinguish different data tracks by (string)
#' @return A ggplot object
plot_sequences_over_time_overlay <- function(config, data, overlay_var) {
  date_scale <- get_date_scale(data)
  bar_line_specs <- get_bar_vs_line_specs("line") # enforce that overlay comparisons always a line plot
  color_scale <- get_color_scale(values = unique(data[[overlay_var]]), aesthetics = c("color", "fill"))

  plot <- ggplot(
    data = data,
    aes(x = as.Date(date), y = proportion, color = .data[[overlay_var]])
  ) +
    bar_line_specs$geom_bar_or_line(alpha = bar_line_specs$alpha_estimate, size = line_bar_size) +
    date_scale +
    color_scale +
    get_uncertainty_geom(data, bar_line_specs, fill_var = overlay_var) +
    labs(
      x = element_blank(),
      y = "Proportion of all samples",
      title = "Sequences over time"
    ) +
    shared_theme +
    theme(legend.title = element_blank())

  return(plot)
}

#' Plot sequences over time stratified by division
#' @param config Configuration information
#' @param data Data to plot
#' @param facet_var Variable name to facet by (string)
#' @return A ggplot object
plot_sequences_over_time_facetted <- function(config, data, facet_var) {
  base_plot <- plot_sequences_over_time(config, data)
  plot <- base_plot +
    facet_wrap(as.formula(paste("~", facet_var)))
  return(plot)
}
