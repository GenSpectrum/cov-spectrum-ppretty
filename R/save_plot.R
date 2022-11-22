# This script is for saving a plot to several different file formats.

#' Save a plot in one or several different file formats.
#' @param plot A ggplot object
#' @param filename The name of plot files
#' @param formats A list of formats to save to. Available formats are png, svg, and pdf
#' @param dirpath Path to where the plot files should be saved
#' @return Full path to where the plot files are saved
#' @export
save_plot <- function(plot, filename, formats = c("png", "svg", "pdf"), dirpath = "./plots") {
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
    png(filename = paste0(dirpath, "/", filename, ".png"), width = 960, height = 960, res = 144)
    print(plot)
    dev.off()
  }
  if ("svg" %in% formats) {
    svg(filename = paste0(dirpath, "/", filename, ".svg"))
    print(plot)
    dev.off()
  }
  if ("pdf" %in% formats) {
    pdf(file = paste0(dirpath, "/", filename, ".pdf"))
    print(plot)
    dev.off()
  }
  return(paste(getwd(), dirpath, filename, sep = "/"))
}
