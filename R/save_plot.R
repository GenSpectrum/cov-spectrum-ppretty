# This script is for saving a plot to several different file formats.

#' Save a plot in one or several different file formats.
#' @param plot A ggplot object
#' @param filename The name of plot files
#' @param formats A list of formats to save to. Available formats are png, svg, and pdf
#' @param path Path to where the plot files should be saved
#' @return Full path to where the plot files are saved
#' @export
save_plot <- function(plot, filename, formats = c("png", "svg", "pdf"), path = NULL) {
  # Create a directory path if not specified
  # aim is to limit number of files per directory by generating a short random path of letters
  if (is.null(path)) {
    path <- paste0(c("./plots", sample(x = LETTERS, size = 2, replace = TRUE)), collapse = "/")
  }

  # Try to make the directory if it doesn't already exist
  out <- tryCatch({
      dir.create(path = path, recursive = T)
    },
    error = function(cond) {
      stop(paste("cannot create directory:", path))
    })

  # Save plots in the directory
  if ("png" %in% formats) {
    png(filename = paste0(path, "/", filename, ".png"))
    print(plot)
    dev.off()
  }
  if ("svg" %in% formats) {
    svg(filename = paste0(path, "/", filename, ".svg"))
    print(plot)
    dev.off()
  }
  if ("pdf" %in% formats) {
    pdf(file = paste0(path, "/", filename, ".pdf"))
    print(plot)
    dev.off()
  }
  return(paste(getwd(), path, filename, sep = "/"))
}
