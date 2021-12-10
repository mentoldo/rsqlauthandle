#' Create a SQL DB conection
#'
#' Create a SQL DB conection for alias.
#'
#' @param alias Str. Alias of db server. You need to set the connection before
#'   create it
#' 
#' @return PqConnection. Return the connection to db
#' 
#' @examples 
#' 
#' \dontrun{
#' library(DBI)
#' con <- connect_postgres(alias='rsqlauthandle')
#' dbListTables(con)
#' }
#' @export
connect_postgres <- function(alias='rsqlauthandle'){
    auth <- Sqlauth$new(alias)
    print(auth)
    con <- DBI::dbConnect(RPostgres::Postgres(),
                     dbname = auth$config$default$db_name,
                     host = auth$config$default$host,
                     port = auth$config$default$port,
                     user = auth$config$default$user,
                     password = keyring::key_get(service = auth$alias,
                                        username = auth$config$default$user)
                     )
}


#' Set the credentials to connect to SQL DB.
#'
#' Save dialect, host, port, db_name, user and app in config file. Save password
#' in system keyring. It will ask the db user password interactively.
#'
#' @param alias Service alias
#' @param dialect The dialect to config (...)
#' @param host Str. Host url of DB server.
#' @param port Str. Port number.
#' @param db_name Str. Name of database to conect.
#' @param user Str. User.
#' 
#' @export
set_credentials <- function(alias = 'rsqlauthandle',
                            dialect = 'postgresql',
                            host = 'localhost',
                            port = '5432',
                            user,
                            db_name){
    
    auth <- Sqlauth$new(alias = alias)
    
    auth$set_credentials(dialect = dialect,
                         host = host,
                         port = port,
                         user = user,
                         db_name = db_name,
                         passwd = getPass::getPass())
    
}
    
   