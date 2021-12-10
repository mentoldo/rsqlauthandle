auth <- Sqlauth$new(resetfile = T)
auth$set_credentials(dialect = 'postgresql',
                     host = 'localhost',
                     port = '5432',
                     user = 'matias',
                     db_name = 'conectividad',
                     passwd = 'r0Merodelacasa')

kb <- keyring::backend_file$new()
kb$keyring_create()
kb$keyring_list()
print(auth$config)

library(DBI)
con <- connect_postgres(alias='rsqlauthandle')
dbListTables(con)
