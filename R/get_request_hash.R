#' Create a hash value from a request.
#' @param config Configuration information
#' @param data Data to plot
#' @return A sha256 hash value
get_request_hash <- function(config, data) {
  json_request <- as.character(jsonlite::toJSON(x = list(config, data)))
  hash_value <- cli::hash_sha256(json_request)
  return(hash_value)
}
