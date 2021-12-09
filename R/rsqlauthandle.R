# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Install Package:           'Ctrl + Shift + B'
#   Check Package:             'Ctrl + Shift + E'
#   Test Package:              'Ctrl + Shift + T'

library(R6)
library(config)
config::get(file=file)

Sqlauth <- R6Class('Sqlauth',
  public = list(
    alias = NULL,
    fileconf = NULL,
    config = NULL,

    initialize = function(alias='sqlauthandle',
                          resetfile=FALSE){
      self$alias = alias
      self$fileconf = file.path('.sqlauthandle', paste0(alias,'.yml'))

      ## Intialize the config file if it does't exist
      if (!file.exists(self$fileconf) | resetfile){
        private$init_configfile()
      }

      self$config = config::get(file=file)
    }
  ),
  private = list(
    #' @description
    #' Initialize the config file
    #'
    #' Create a config file in .sqlauthandle folder with the alias name.
    init_configfile = function() {
      file <- file.path('.rsqlauthandle', 'sqlauthandle.yml')
      def_conf <- paste0("default:\n",
                         "  alias:\n",
                         "  dialect:\n",
                         "  host:\n",
                         "  port:\n",
                         "  user:\n",
                         "  db_name:")

      if(!dir.exists(dirname(file))){
        dir.create('.rsqlauthandle/')
      }

      write(def_conf, file=file)
    }
  )
)

auth <- Sqlauth$new(resetfile = F)


