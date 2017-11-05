shinyServer(function(input, output, session) {

  # snippets
    observeEvent(input$searchButton, {
  
        if( length(input$snipSearch) > 0 )
        ids =  snipSearch(kw=input$snipSearch, lang=input$lang)
        
        if(length(ids) > 0) {
          o = snipFetch(ids)
          updateAceEditor(session, "search", value = o, mode = input$lang  )

        }

    })

 })




