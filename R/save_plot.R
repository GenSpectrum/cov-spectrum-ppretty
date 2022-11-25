# This script is for saving a plot to several different file formats.

#' Save a plot in one or several different file formats.
#' @param plot A ggplot object
#' @param filename The name of plot files
#' @param formats A list of formats to save to. Available formats are png, svg, and pdf
#' @param dirpath Path to where the plot files should be saved
#' @param size_multiplier The width and height will be multiplied by this factor
#' @param size_ratio The width/height ratio
#' @return Full path to where the plot files are saved
#' @export
save_plot <- function(
  plot,
  filename,
  formats = c("png", "svg", "pdf"),
  dirpath = "./plots",
  size_multiplier = 1,
  size_ratio = 1
) {
  if (is.null(size_multiplier)) {
    size_multiplier <- 1
  }
  if (is.null(size_ratio)) {
    size_ratio <- 1
  }

  # Try to make the directory if it doesn't already exist
  out <- tryCatch({
      dir.create(path = dirpath, recursive = T)
    },
    error = function(cond) {
      stop(paste("cannot create directory:", dirpath))
    },
    warning = function(cond) {})

  # Save plots in the directory
  if ("png" %in% formats) {
    png(filename = paste0(dirpath, "/", filename, ".png"), width = 960 * size_multiplier * size_ratio,
        height = 960 * size_multiplier, res = 144)
    print(plot)
    dev.off()
  }
  if ("svg" %in% formats) {
    svg(filename = paste0(dirpath, "/", filename, ".svg"), width = 7 * size_multiplier * size_ratio,
        height = 7 * size_multiplier)
    print(plot)
    dev.off()
  }
  if ("pdf" %in% formats) {
    pdf(file = paste0(dirpath, "/", filename, ".pdf"), width = 7 * size_multiplier * size_ratio,
        height = 7 * size_multiplier)
    print(plot)
    dev.off()
  }
  return(paste(getwd(), dirpath, filename, sep = "/"))
}
