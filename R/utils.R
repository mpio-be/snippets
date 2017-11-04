
#' @export
shQuote2 <- function(x, ...) {
    if(!is.na(x)) 
      shQuote(x, ...)   else x
    }