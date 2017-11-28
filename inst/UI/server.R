shinyServer(function(input, output, session) {

   observe( on.exit( assign('input', reactiveValuesToList(input) , envir = .GlobalEnv)) )

   observeEvent(input$searchButton, {
  
        if( length(input$snipSearch) > 0 )
        ids =  snipSearch(kw=input$snipSearch, lang=input$lang)
        
        if(length(ids) > 0) {
          o = snipFetch(ids)
          updateAceEditor(session, "search", value = o, mode = input$lang  )

        }

    })

 })




