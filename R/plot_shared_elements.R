# This script is for elements shared between plots, like common theme elements

library(ggplot2)

shared_theme <- theme_bw()  # theme for all plots
line_bar_size <- 1  # controls relative thickness of lines in line plots

# Footer for every plot
footnote <- "Plot by cov-spectrum.org enabled by data from GISAID"

# Colors to use preferentially
diverging_colors <- RColorBrewer::brewer.pal(n = 8, name = "Set2")

# Function that will return as many colors as necessary from when there are more values than length(diverging_colors).
# Needs to take argument 'n'.
get_unlimited_colors <- terrain.colors
