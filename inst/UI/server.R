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
            updateAceEditor(session, "search", value = paste('No search results [', Sys.time(),']' ), mode = 'txt', fontSize = 20  )
            }

      })

   # EDIT & BROWSE
      observeEvent(input$snipID, ignoreInit = TRUE , {

        ok <- snipExists(input$snipID)
        
        if(ok) {
          o = snipFetch(input$snipID, banner = FALSE, asis = TRUE)  
          updateAceEditor(session= session, "editSnip",value = o$snippet,  mode = o$lang, fontSize = 14)
        
          updateTextAreaInput(session= session, "editDescribe", value = o$description) 

         # last update 
         output$last_run <- renderUI({
            hr()
            div(class='text-center font-weight-bold', div(class = 'badge label-info', paste('Last run:', o$lastGoodRun ) ) )
            })


          }


        if(!ok && input$snipID != 0) 
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

   # NEW
     observeEvent(input$saveNewButton, ignoreInit = TRUE, {
      
      last_new = snipSave(input$newSnip,input$lang,input$newAuthor, input$newDescribe )
      toastr_success( paste('Snippet', last_new, 'was saved.') )


      # reset   
      updateTextAreaInput(session = session, inputId = 'newDescribe', value = "")  
      updateTextInput(session = session, inputId = 'newAuthor', value = "")  
      

      # Last saved ID
      output$n_snippets <- renderUI({
        hr()
        div(class='text-center font-weight-bold', div(class = 'badge label-danger', paste('Last saved ID:', last_new ) ) )
        })

      })     

   # CLEAN
    invalidate_cleaner <- reactiveTimer(5000)
    
    observe({
      invalidate_cleaner()
      gosts = clean_repo()
      if(gosts == 1)
        toastr_info( paste(gosts, 'empty snippet removed from repository.') , showDuration = 5000)  
      if(gosts > 1)
        toastr_info( paste(gosts, 'empty snippets removed from repository.'), showDuration = 5000 )  
      })

    # LAST UPDATE SNIPPET AND INFO
      invalidate_repo_state <- reactiveTimer(5000)
      
      observe({
      invalidate_repo_state()
      output$repo_state <- renderUI({
        
        con = dbConnect(RMariaDB::MariaDB(), db = "SNIPPETS")
        x = dbGetQuery(con, 'SELECT count(*) snippets, lang from repo group by lang') %>% data.table
        dbDisconnect(con)

        o = x[, as.character(div(class='text-center font-weight-bold', div(class = 'badge label-warning', paste(lang, ' ▶ ', snippets, 'snippets') ) )) , 1:nrow(x) ]

        
        HTML(paste(o$V1, collapse = ''))

      })
     })
      

})   






