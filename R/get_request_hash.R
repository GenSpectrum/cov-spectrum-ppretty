#' Create a hash value from a string.
#' @param s String
#' @return A sha256 hash value
#' @export
get_hash <- function(s) {
  return(cli::hash_sha256(s))
}
