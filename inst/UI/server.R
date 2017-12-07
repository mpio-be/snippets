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
    observeEvent(input$snipID, ignoreInit = TRUE , {

      ok = snipExists(input$snipID)
      
      if(ok) {
        o = snipFetch(input$snipID, banner = FALSE, asis = TRUE)  
        updateAceEditor(session= session, "editSnip",value = o$snippet,  mode = o$lang, fontSize = 14)
      
        updateTextAreaInput(session= session, "editDescribe", value = o$description) 

        }


      if(!ok & input$snipID != 0) 
        toastr_warning( paste('Snippet',input$snipID, 'does not exist.') )


     })



   observeEvent(input$editButton, ignoreInit = TRUE, {
    
    ok = snipExists(input$snipID)

    if(ok) {
      o = snipUpdate(input$snipID, input$editSnip, input$editDescribe )
      toastr_success( paste('Snippet', o, 'was updated.') )

       }

    # reset   
    updateNumericInput(session = session, inputId = 'snipID', value = 0)  
              

    })












 })




