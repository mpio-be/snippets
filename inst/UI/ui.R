
material_page(title = 'Code snippets 🎣',nav_bar_color = 'blue-grey',
  useToastr(),

  br(),

  material_row( 
    material_column(width = 2,

    material_radio_button('MODE', '', choices = c('Search', 'Edit', 'New') ),   
    hr(),
    

    # ==========================================================================
    # SEARCH
    # ==========================================================================
    conditionalPanel( condition = 'input.MODE == "Search"',


      material_text_box('snipSearch', 'Search...'),
      material_button('searchButton',  'Search snippets ...' ), 

      br()


      ),

    # ==========================================================================
    # EDIT
    # ==========================================================================
    conditionalPanel( condition = 'input.MODE == "Edit"',

      material_text_box('snipID', 'Snippet ID'),
      material_button('editButton',  'UPDATE' )

 
      ),

    
    # ==========================================================================
    # COMMON ELEMENTS
    # ==========================================================================

    br(), 
    material_dropdown('lang', 'Language', 
    choices = c('R' = 'r', 'SQL' = 'mysql', 'bash' = 'sh') ,selected = 'r')

   ),



    # ==========================================================================
    # EDITORS
    # ==========================================================================
    material_column(width = 10,

        conditionalPanel( condition = 'input.MODE == "Search"',
          aceEditor('search',height = '90vh', theme='merbivore', wordWrap = TRUE, , fontSize = 14) ),
      
        conditionalPanel( condition = 'input.MODE == "Edit"',
          HTML('Update description:'),
          aceEditor('editDescribe',height = '10vh', theme='cobalt', wordWrap = TRUE, fontSize = 18) ,
          HTML('Update snippet body:'),
          aceEditor('editSnip',    height = '80vh', theme='pastel_on_dark', wordWrap = TRUE, , fontSize = 14 ) 

        )
      


      )

 ))





