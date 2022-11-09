# This script is for elements shared between plots, like common theme elements

library(ggplot2)

shared_theme <- theme_bw()  # theme for all plots
line_bar_size <- 1  # controls relative thickness of lines in line plots

# Footer for every plot
footnote <- "Plot by cov-spectrum.org enabled by data from GISAID"

# Colors to use preferentially
# First color will be used for single-variable plots
diverging_colors <- c(
  '#353B89',
  '#3B8935',
  '#F0A21A',
  '#CE1A39',
  '#F7D233',
  '#A21AF0',
  '#21A0A1',
  '#898335',
  '#A76660',
  '#B8D4DC',
  '#F57E3B',
  '#DB598A')

# Function that will return as many colors as necessary from when there are more values than length(diverging_colors).
# Needs to take argument 'n' for number of colors to return.
get_unlimited_colors <- terrain.colors
