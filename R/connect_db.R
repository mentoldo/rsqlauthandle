connect_postgres <- function(alias='rsqlauthandle'){
    auth <- Sqlauth$new(alias)
    print(auth)
    con <- dbConnect(RPostgres::Postgres(),
                     dbname = auth$config$default$db_name,
                     host = auth$config$default$host,
                     port = auth$config$default$port,
                     user = auth$config$default$user,
                     password = key_get(service = auth$alias,
                                        username = auth$config$default$user)
                     )
}
