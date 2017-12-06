
material_page(title = 'snippets',nav_bar_color = 'blue-grey',
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

      br(), br(),

      material_dropdown('lang', 'Language', 
          choices = c('R' = 'r', 'SQL' = 'mysql', 'bash' = 'sh') ,selected = 'r')

      ),

    # ==========================================================================
    # EDIT
    # ==========================================================================
    conditionalPanel( condition = 'input.MODE == "Edit"',

      material_text_box('snipID', 'Snippet ID'),
      material_button('editButton',  'UPDATE' )

 
      )

    
   ),


  # ==========================================================================
  # EDITORS
  # ==========================================================================
  material_column(width = 10,

      conditionalPanel( condition = 'input.MODE == "Search"',
      aceEditor('search',height = '90vh', theme='merbivore', wordWrap = TRUE ) ),
    
      conditionalPanel( condition = 'input.MODE == "Edit"',
      aceEditor('edit',height = '90vh', theme='pastel_on_dark', wordWrap = TRUE ) )
    


    )

 ))





