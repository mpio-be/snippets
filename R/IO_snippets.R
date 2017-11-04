# ==========================================================================
# snippets I/O
# ==========================================================================

#' SQL Snippets
#'
#' @param snippet      The snippet
#' @param lang         language: R, python, bash
#' @param author       author
#' @param description  description
#' @param ID           snip ID - will overwrite that ID
#'
#' @return             snipSave returns the ID of the saved snippet 
#' 					   or NULL if this fails.
#' @export
#'
snipSave <- function(snippet, lang, author = NA, description=NA, ID) {

	con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))

	if(missing(ID)) # then INSERT
	v = paste("INSERT INTO repo (
				snippet, 
				lang,
				author, 
				description) 
			VALUES(", paste(
				shQuote2(snippet),
				shQuote2(lang),
				shQuote2(author), 
				shQuote2(description), 
		sep = ",")   ,");")

    if(!missing(ID)) { # then UPDATE
     id_exists = nrow(dbGetQuery(con, paste('SELECT ID from repo where ID = ', ID) )) == 1
     if(!id_exists) stop( paste('ID', ID, 'does not exist!'))
    
    v = paste('UPDATE repo SET', 
    		  'snippet=',     shQuote2(snippet)   ,',',
    		  'lang=',        shQuote2(lang)      ,',',
			  'author=',      shQuote2(author)    ,',', 
			  'description=', shQuote2(description), 
			  'WHERE ID = ' , ID
			 )
	 } 

	o = dbExecute(con, v)
	if(o == 1)
	dbGetQuery(con, 'SELECT max(ID) id from repo')%>%as.numeric else NULL

 }

#' @rdname snipSave
#' @export
snipFetch        <- function(ID) {
	IDs = paste(ID, collapse = ',')
	con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))

	x = dbGetQuery(con, paste('SELECT * from repo where ID in (', IDs, ')') )

	# TODO; format given language (include all fields)

	x$snippet

	}



#' @rdname snipSave
#' @export
snipDrop         <- function(ID) {
	con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))
	
	dbExecute(con, paste('DELETE FROM repo where ID = ', ID) )

	}


#' @rdname snipSave
#' @export
snipSearch  <- function(kw) {
	
	con = dbConnect(RMariaDB::MariaDB(), group = "snippets"); on.exit(dbDisconnect(con))

	ids = dbGetQuery(con,
		paste0('SELECT ID from repo
			      WHERE snippet like "%', kw, '%" OR description like "%', kw, '%"') )$ID


	snipFetch(ids)

	}






