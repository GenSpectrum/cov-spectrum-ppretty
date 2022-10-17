#* @get /
#* @serializer unboxedJSON
function() {
  response <- list(message = "This is ppretty.")
  return(response)
}
