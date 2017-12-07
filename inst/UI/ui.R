
dashboardPage(
  dashboardHeader(title = 'Code snippets 🎣'),
  
  dashboardSidebar( 
  useToastr(),

    radioButtons('MODE', '', choices = c('Search', 'Edit', 'New'), inline = TRUE ),   
    hr(),
    
    # ==========================================================================
    # COMMON ELEMENTS
    # ==========================================================================
      conditionalPanel( condition = 'input.MODE == "Search" | input.MODE == "New"',
        br(), 
        selectizeInput('lang', 'Language', 
        choices = c('R' = 'r', 'SQL' = 'mysql', 'bash' = 'sh') ,selected = 'r')

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

        numericInput('snipID', 'Snippet ID', value = 0),
        actionButton('editButton',  'UPDATE' ), 
        textAreaInput('editDescribe','Edit description') 
        )
    
    ), 

    
    # ==========================================================================
    # EDITORS
    # ==========================================================================
    dashboardBody(

        conditionalPanel( condition = 'input.MODE == "Search"',
          aceEditor('search',height = '90vh', theme='merbivore', wordWrap = TRUE, fontSize = 14) ),
      
        conditionalPanel( condition = 'input.MODE == "Edit"',
           aceEditor('editSnip',    height = '90vh', theme='pastel_on_dark', wordWrap = TRUE,fontSize = 14 ) 

          )
      


      )

 )





