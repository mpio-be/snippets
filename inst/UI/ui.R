
dashboardPage(
  dashboardHeader(title = 'Code snippets 🎣'),
  
  dashboardSidebar( 
  useToastr(),

    radioButtons('MODE', '', choices = c('Search','Browse', 'Edit', 'New'), inline = FALSE ), 
    hr(),
    
    # ==========================================================================
    # COMMON ELEMENTS
    # ==========================================================================
      conditionalPanel( condition = 'input.MODE == "Search" | input.MODE == "New"',
        br(), 
        selectizeInput('lang', 'Language', 
        choices = c('R' = 'r', 'SQL' = 'mysql', 'bash' = 'sh') ,selected = 'r')

        ),

      conditionalPanel( condition = 'input.MODE == "Browse" | input.MODE == "Edit"',
          numericInput('snipID', 'Snippet ID', value = 0),
          textAreaInput('editDescribe','Description', placeholder = 'Snippet\'s description ...') 

        ),



    # ==========================================================================
    # SEARCH
    # ==========================================================================
      conditionalPanel( condition = 'input.MODE == "Search"',


        textInput('snipSearch', 'Search code or description'),
        actionButton('searchButton',  'Search snippets' ), 

        br()


        ),


    # ==========================================================================
    # EDIT
    # ==========================================================================
      conditionalPanel( condition = 'input.MODE == "Edit"',

        div(class='text-center text-primary', 'To remove a snippet delete both the Description and the Snippet and press Update'), 

        actionButton('editButton',  'UPDATE' )
        
        ),


    # ==========================================================================
    # NEW
    # ==========================================================================
      conditionalPanel( condition = 'input.MODE == "New"',

        actionButton('saveNewButton',  'SAVE' ), 
        textAreaInput('newDescribe','Snippet description:', placeholder = 'Script short description ...'),
        textInput('newAuthor','Author\'s name:', placeholder = 'Name or initials')
        ) ,


     # INFO
      htmlOutput("n_snippets"), 
      hr(),
      htmlOutput("repo_state") 



    
    ), 

    
    # ==========================================================================
    # ACE EDITORS
    # ==========================================================================
    dashboardBody(

        conditionalPanel( condition = 'input.MODE == "Search"',
          aceEditor('search',height = '90vh', theme='merbivore', wordWrap = TRUE, fontSize = 14) ),
      
        conditionalPanel( condition = 'input.MODE == "Edit" | input.MODE == "Browse"',
           aceEditor('editSnip',    height = '90vh', theme='pastel_on_dark', wordWrap = TRUE,fontSize = 14 ) ), 

        conditionalPanel( condition = 'input.MODE == "New"',
           aceEditor('newSnip',    height = '90vh', theme='clouds', wordWrap = TRUE,fontSize = 14 ) )




      


      )

 )





