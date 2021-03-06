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
#' @return             snipSave & snipUpdate returns the ID of the saved snippet 
#' 					   or NULL if this fails.
#' @export
#'
snipSave <- function(snippet, lang, author = NA, description=NA) {

	con = dbConnect(RMariaDB::MariaDB(), db = 'SNIPPETS'); on.exit(dbDisconnect(con))

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


	o = dbExecute(con, v)
	if(o == 1)
	dbGetQuery(con, 'SELECT max(ID) id from repo')%>%as.numeric else NULL

 }


#' @rdname snipSave
#' @export
snipExists <- function(ID) {

	if(is.null(ID) || is.na(ID) || is.na(as.integer(ID)) || length(ID) == 0 || nchar(ID) == 0 || ID %in% c(Inf, -Inf) || missing(ID)) ID = 0

	ID = as.integer(ID)

	if(as.integer(ID) > 0) {
	 con = dbConnect(RMariaDB::MariaDB(), db = 'SNIPPETS'); on.exit(dbDisconnect(con))
	 
	 o = nrow(dbGetQuery(con, paste('SELECT ID from repo where ID = ', ID) )) == 1
		
	} else o = FALSE

	return(o)

 }



#' @rdname snipSave
#' @export
snipUpdate <- function(ID, snippet, description) {

	if( snipExists(ID) ) {
		con = dbConnect(RMariaDB::MariaDB(), db = 'SNIPPETS'); on.exit(dbDisconnect(con))


		v = paste('UPDATE repo SET', 
		'snippet=',     shQuote2(snippet)   ,',',
		'description=', shQuote2(description), 
		'WHERE ID = ' , ID
		)


		o = dbExecute(con, v)

		if(o == 1)
		return(ID) else return(NULL)
	 }

 }


#' @rdname snipSave
#' @export
snipFetch   <- function(ID, verbose = FALSE, banner = TRUE, asis = FALSE) {
	con = dbConnect(RMariaDB::MariaDB(), db = 'SNIPPETS'); on.exit(dbDisconnect(con))

	IDs = paste(ID, collapse = ',')

	x = dbGetQuery(con, paste('SELECT * from repo where ID in (', IDs, ')') ) %>%
		data.table
    x[, lastGoodRun := as.character(lastGoodRun)]	
    x[is.na(lastGoodRun), lastGoodRun := 'never']	

	if(banner){
		x[, banner := '']
		x[lang != 'mysql', banner  := banner(c('ID', 'Author', 'Last run',''), c(ID, author, lastGoodRun, description) )   , by = ID]
		x[lang == 'mysql', banner  := banner(c('ID','Author', 'Last run', ''), c(ID, author, lastGoodRun, description) , sql = TRUE), by = ID]
		x[, snippet := paste(banner, snippet, sep = '\n'), by = ID]
    	
    	}

	o = paste(x$snippet, collapse = '\n\n')

	if(verbose) 
		cat(o)
	
	if(asis) o = x

	o

	}



#' @rdname snipSave
#' @export
snipDrop <- function(ID) {
	con = dbConnect(RMariaDB::MariaDB(), db = 'SNIPPETS'); on.exit(dbDisconnect(con))
	
	dbExecute(con, paste('DELETE FROM repo where ID = ', ID) )

	}


#' @rdname snipSave
#' @export
snipSearch  <- function(kw, lang) {
	
	con = dbConnect(RMariaDB::MariaDB(), db = 'SNIPPETS'); on.exit(dbDisconnect(con))

	if(missing(lang))
		o = dbGetQuery(con,
			paste0('SELECT ID from repo
				      WHERE snippet like "%', kw, '%" OR description like "%', kw, '%"') )$ID
	if(!missing(lang))
		o = dbGetQuery(con,
			paste0('SELECT ID from repo
				      WHERE lang =',shQuote(lang),'AND (snippet like "%', kw, '%" OR description like "%', kw, '%")') )$ID
	o

	}






