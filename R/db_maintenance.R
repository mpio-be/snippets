
#' remove empty lines
#'
#' @return   N lines updated in repo table
#' @export
#'
clean_repo <- function() {

    con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))

    dbExecute(con, 'DELETE FROM repo where length(snippet) = 0 and length(description) = 0')

 }

