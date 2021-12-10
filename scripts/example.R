auth <- Sqlauth$new(resetfile = T)
auth$set_credentials(dialect = 'postgresql',
                     host = 'localhost',
                     port = '5432',
                     user = 'matias',
                     db_name = 'conectividad',
                     passwd = '1234')

kb <- keyring::backend_file$new()
kb$keyring_create()
kb$keyring_list()
print(auth$config)

library(DBI)
con <- connect_postgres(alias='rsqlauthandle')
dbListTables(con)

set_credentials('matias',
                'conectividad')
con <- connect_postgres(alias='rsqlauthandle')
dbListTables(con)
dbReadTable(con, 't_respuestas')
dbReadTable(con, 't_respuestas')
