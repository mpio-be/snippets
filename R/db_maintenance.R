
#' remove empty lines
#'
#' @return   numeric: N lines updated in repo table
#' @export
#'
clean_repo <- function() {

    con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))

    dbExecute(con, 'DELETE FROM repo where length(snippet) = 0 and length(description) = 0')

 }

#' check one snippet 
#'
#' @return   datetime if the snippet runs without errors else NA
#' @export
#' @examples
#' runSnippet(snippet = 'x = rnorm(10)', lang = 'r')
#' runSnippet(snippet = 'SELECT 1', lang = 'mysql')
runSnippet <- function(snippet, lang) {

    if(lang == 'r') {
      o = try(eval(parse(text=snippet)), silent = TRUE)
    }


    if(lang == 'mysql') {
      con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))  
      o = try( dbExecute(con, snippet), silent = TRUE)
    }


    if( inherits(o, 'try-error') ) ans = as.POSIXct(NA) else ans = Sys.time()

    ans
  }



#' check all snippets (for now R and mysql snippets)
#'
#' @return   numeric: the number of updated rows.
#' @export
#'
run_snippets <- function() {

    con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))

    x = dbGetQuery(con, 'SELECT * from repo where lang in ("mysql", "r")') %>% data.table

    x[, lastGoodRun := runSnippet(snippet, lang), by = ID]


    dbWriteTable(con, 'temp', x[!is.na(lastGoodRun), .(ID, lastGoodRun)], row.names = FALSE)

    o = dbExecute(con, 'UPDATE repo r, temp t set r.lastGoodRun = t.lastGoodRun where t.ID = r.ID')
    dbExecute(con, 'DROP TABLE temp')

    o

 }

