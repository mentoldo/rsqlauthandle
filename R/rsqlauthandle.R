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
library(keyring)

#' Authorization class to manage authentication in SQL Databases
#'
#' It lets you handle and save SQL DB authentication configuration information.

Sqlauth <- R6Class('Sqlauth',
  public = list(
    #' @field alias String identifier of the db conection.
    alias = NULL,
    #' @field fileconf The path to config file.
    fileconf = NULL,
    #' @field A list with with the config options.
    config = NULL,

    #' @description
    #' Create a new sqlauth object
    #' @param alias String identifier of the db conection.
    #' @param resetfile Bool indicating if file will be reseted
    #' @return A new `Sqlauth` object.
    initialize = function(alias='rsqlauthandle',
                          resetfile=FALSE){
      self$alias = alias
      self$fileconf = file.path('.rsqlauthandle', paste0(alias,'.yml'))

      ## Intialize the config file if it does't exist
      if (!file.exists(self$fileconf) | resetfile){
        private$init_configfile()
      }

      self$config = config::get(file=self$fileconf)
    }
  ),
  private = list(
    #' @description
    #' Initialize the config file
    #'
    #' Create a config file in .sqlauthandle folder with the alias name.
    init_configfile = function() {
      #file <- file.path('.rsqlauthandle', 'sqlauthandle.yml')
      def_conf <- paste0("default:\n",
                         "  alias:\n",
                         "  dialect:\n",
                         "  host:\n",
                         "  port:\n",
                         "  user:\n",
                         "  db_name:")

      if(!dir.exists(dirname(self$fileconf))){
        dir.create(dirname(self$fileconf))
      }

      write(def_conf, file=self$fileconf)
    }
  )
)

auth <- Sqlauth$new(resetfile = T)


