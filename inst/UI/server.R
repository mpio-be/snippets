shinyServer(function(input, output, session) {

  # snippets
    observe({
        o =  snipSearch(input$snipSearch)
        if(is.null(o) ) o = 'Your search returned no results'

        updateAceEditor(session, "sqlSnippets", value = o , fontSize = input$snippetsFontSize )
    })



})


