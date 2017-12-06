shinyServer(function(input, output, session) {

   observe( on.exit( assign('input', reactiveValuesToList(input) , envir = .GlobalEnv)) )

   # SEARCH
   observeEvent(input$searchButton, {
  
        if( length(input$snipSearch) > 0 )
        ids =  snipSearch(kw=input$snipSearch, lang=input$lang)
        
        if(length(ids) > 0) {
          o = snipFetch(ids)
          updateAceEditor(session, "search", value = o, mode = input$lang  )

        }

    })

   # EDIT
    observeEvent(input$snipID, {

      id = as.integer(input$snipID)
      if(is.na(id)) id = 0

      o = snipFetch(id, asis  = TRUE, banner = FALSE)
      
      if(nrow(o) > 0)
      updateAceEditor(session, "edit", value = o$snippet, mode = o$lang  )           

       if(nrow(o) == 0)
      updateAceEditor(session, "edit", value = "ID does not exist.", mode = 'txt' ) 

        
    })



   observeEvent(input$editButton, {
  
    })










 })




