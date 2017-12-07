shinyServer(function(input, output, session) {

   observe( on.exit( assign('input', reactiveValuesToList(input) , envir = .GlobalEnv)) )

   # SEARCH
   observeEvent(input$searchButton, {
  
        if( length(input$snipSearch) > 0 )
        ids =  snipSearch(kw=input$snipSearch, lang=input$lang)
        
        if(length(ids) > 0) {
          o = snipFetch(ids)
          updateAceEditor(session, "search", value = o, mode = input$lang, fontSize = 14 )
          }

        if(length(ids) == 0) {
          updateAceEditor(session, "search", value = paste('No search results\n', Sys.time() ), mode = 'txt', fontSize = 20  )
          }




    })

   # EDIT
    observeEvent(input$snipID, {

      ok = snipExists(input$snipID)
      
      if(ok) {
        o = snipFetch(input$snipID, banner = FALSE, asis = TRUE)  
        updateAceEditor(session, "editSnip",     value = o$snippet,     mode = o$lang, fontSize = 14)           
        updateAceEditor(session, "editDescribe", value = o$description, mode = 'txt',  fontSize = 14)           
        }

      if(!ok) {
        updateAceEditor(session, "editDescribe", value = paste('ID does not exist\n', Sys.time() ), mode = 'txt', , fontSize = 20  )           
        updateAceEditor(session, "editSnip",     value = "", mode = 'txt', , fontSize = 20 ) 
      }

        
    })



   observeEvent(input$editButton, {
    
    ok = snipExists(input$snipID)

    if(ok) {
      o = snipUpdate(input$snipID, input$editSnip, input$editDescribe )
      toastr_success( paste('Snippet', o, 'was updated.') )
      }



    })










 })




