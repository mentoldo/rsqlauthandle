#' Authorization class to manage authentication in SQL Databases
#'
#' It lets you handle and save SQL DB authentication configuration information.
#' 
Sqlauth <- R6::R6Class('Sqlauth',
  public = list(
    #' @field alias String identifier of the db conection.
    alias = NULL,
    #' @field fileconf The path to config file.
    fileconf = NULL,
    #' @field config A list with with the config options.
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

      self$config = yaml::read_yaml(file=self$fileconf)
    },

    #' @description
    #' Set the credentials to connect to SQL DB.
    #'
    #' Save dialect, host, port, db_name, user and app in config file. Save password
    #' in system keyring.
    #'
    #' @param dialect The dialect to config ...
    #' @param host Str. Host url of DB server.
    #' @param port Str. Port number.
    #' @param db_name Str. Name of database to conect.
    #' @param user Str. User.
    #' @param passwd Str. Password
    set_credentials = function(dialect, host, port, db_name, user, passwd){
      self$config$default$alias <- self$alias
      self$config$default$dialect <- dialect
      self$config$default$host <- host
      self$config$default$port <- port
      self$config$default$db_name <- db_name
      self$config$default$user <- user

      # Save configuration credentials in file
      yaml::write_yaml(self$config,
                 file=self$fileconf)

      keyring::key_set_with_value(service = self$alias,
                                  username = user,
                                  password = passwd)
    }

  ),
  private = list(
    
    #' @description
    #' Initialize the config file
    #'
    #' Create a config file in .sqlauthandle folder with the alias name.
    init_configfile = function() {
      config <- list(
        default=list(
          alias=NULL,
          dialect=NULL,
          host=NULL,
          port=NULL,
          user=NULL,
          db_name=NULL))

      if(!dir.exists(dirname(self$fileconf))){
        dir.create(dirname(self$fileconf))
      }

      yaml::write_yaml(config, file=self$fileconf)
    }
  )
)

