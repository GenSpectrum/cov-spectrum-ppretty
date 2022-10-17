library(ggplot2)


#' @param data A tibble with the columns: date, count
plot_example <- function(data) {
  p <- ggplot(data, aes(x = date, y = count)) +
    geom_bar(stat = "identity")
  return(p)
}
