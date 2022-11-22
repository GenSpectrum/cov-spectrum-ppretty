# This script is for making different cov-spectrum plots

library(ggplot2)

#' Make a plot. Depending on the config information, will call another function to make a specific type of plot.
#' @param config Configuration information
#' @param data Data to plot
#' @param metadata Metadata describing the request
#' @return A ggplot object
#' @export
make_plot <- function(config, data, metadata) {
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

  # Add acknowledgments footer, subtitle to all plots
  titles <- get_titles(config = config, metadata = metadata)
  plot <- plot + labs(caption = create_footnote(config$dataSource), title = titles$title, subtitle = titles$subtitle)

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
    get_bar_line_geom(bar_line_specs) +
    date_scale +
    get_uncertainty_geom(data, bar_line_specs, fill_color = bar_line_specs$fill) +
    labs(
      x = element_blank(),
      y = "Estimated absolute number of cases"
    ) +
    shared_theme

  return(plot)
}

#' Plot sequences over time
#' @param config Configuration information
#' @param data Data to plot
#' @return A ggplot object
plot_sequences_over_time <- function(config, data, max_date_breaks = 10) {
  date_scale <- get_date_scale(data, max_breaks = max_date_breaks)
  bar_line_specs <- get_bar_vs_line_specs(config$plotType)

  plot <- ggplot(
    data = data,
    aes(x = as.Date(date), y = proportion)
  ) +
    get_bar_line_geom(bar_line_specs) +
    date_scale +
    get_uncertainty_geom(data, bar_line_specs, fill_color = bar_line_specs$fill) +
    labs(
      x = element_blank(),
      y = "Proportion of all samples"
    ) +
    shared_theme

  # If variant name column present (as for collection data), facet by it and reduce number date breaks
  if ("name" %in% colnames(data)) {
    date_scale <- get_date_scale(data, max_breaks = 5)
    plot <- plot + facet_wrap(. ~ name)
    suppressMessages({plot <- plot + date_scale})  # silence the alert that it's overwriting the date scale
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
  color_scale <- get_color_scale(
    values = unique(data[[overlay_var]]),
    aesthetics = c("color", "fill"),
    max_char_label = 80
  )

  # Find the length of the longest label. This should control the number of columns in the legend
  max_legend_label_length <- max(nchar(data[[overlay_var]]))
  if (max_legend_label_length < 20) {
    legend_columns <- 4
  } else if (max_legend_label_length < 40) {
    legend_columns <- 3
  } else if (max_legend_label_length < 60) {
    legend_columns <- 2
  } else {
    legend_columns <- 1
  }

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
      y = "Proportion of all samples"
    ) +
    guides(col = guide_legend(ncol = legend_columns)) +
    shared_theme +
    theme(
      legend.title = element_blank(),
      legend.position = "bottom"
    )

  return(plot)
}

#' Plot sequences over time stratified by division
#' @param config Configuration information
#' @param data Data to plot
#' @param facet_var Variable name to facet by (string)
#' @return A ggplot object
plot_sequences_over_time_facetted <- function(config, data, facet_var) {
  base_plot <- plot_sequences_over_time(config, data, max_date_breaks = 5)  # fewer date breaks for facetted plots
  plot <- base_plot +
    facet_wrap(as.formula(paste("~", facet_var)))
  return(plot)
}
