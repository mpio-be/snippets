# shiny::runApp('inst/UI')

# settings
    sapply(c('magrittr', 'stringr',
        'RMariaDB','shinyAce','shinydashboard'),
    require, character.only = TRUE, quietly = TRUE)

