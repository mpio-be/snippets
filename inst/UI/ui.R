
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

      material_dropdown('lang', 'Language', choices = c('r', 'mysql', 'sh') ,selected = 'r')

      ),

    # ==========================================================================
    # SEARCH
    # ==========================================================================
    conditionalPanel( condition = 'input.MODE == "Edit"',

      material_text_box('snipID', 'Type ID')

 
      )





    
   ),

  # ==========================================================================
  # EDITORS
  # ==========================================================================
  material_column(width = 10,

      conditionalPanel( condition = 'input.MODE == "Search"',
      aceEditor('search',height = '90vh', theme='merbivore', wordWrap = TRUE )
        )
    )

 ))





