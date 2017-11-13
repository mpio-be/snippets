
#' @export
shQuote2 <- function(x, ...) {
    if(!is.na(x)) 
      shQuote(x, ...)   else x
    }

#' @title banner
#' @export
#' @examples
#' values = c('1', 'Aname Bname', paste(sample(iris$Species, 20), collapse = ' ' ) )
#' nams = c('ID', 'Name', NA)
#'  cat( banner(nams, values, 50)  )
banner <- function(nams, values, len = 80, sql = FALSE) {
    stopifnot(length(values) == length(nams))
    
    tb = paste(rep('-', len-2), collapse = '') %>% 
        str_pad( width = len,pad = '#',side = 'both')

    nams[is.na(nams) ] = ''
    x = paste(nams, values, sep = "=")
    x = str_replace(x, "^\\=", "")
    x = paste("#", x)
    x = paste(x, '\n')
    x = str_wrap(x, len, exdent = 3) 
    x = str_replace_all(x, '\n', '\n#')
    
    x = paste(x, '\n')


    o = paste(x, collapse = "")
    o = paste(tb,o, tb, sep = '\n')    
    o = paste(o, collapse = "")
    if(sql)
    o = paste("/*", o, "*/", collapse = "")    

    return(invisible( o))
              
    }    