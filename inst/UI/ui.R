bootstrapPage(

includeCSS("./www/styles.css"),


aceEditor("sqlSnippets",height = '80vh', theme = 'merbivore' , mode = "mysql", wordWrap = TRUE ),


absolutePanel(id = "controls", class = "panel panel-default", fixed = TRUE, draggable = TRUE, top = 60, left = "auto", right = 20, bottom = "auto", width = 330, height = "auto",

  textInput("snipSearch", "Search SQL snippets", value = 'system' ) ,

  selectInput("snippetsFontSize", "Font size", 10:20, selected = 12 )

  )



)

