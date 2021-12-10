
<!-- README.md is generated from README.Rmd. Please edit that file -->

# rsqlauthandle

<!-- badges: start -->
<!-- badges: end -->

The goal of rsqlauthandle is to handle in a simple and secure way your
sql db servers authentications.

## Installation

You can install the development version of rsqlauthandle like so:

``` r
devtools::install_github('mentoldo/rsqlauthandle')
```

## Example

To use rsqlauthandle in a project:

``` r
library(rsqlauthandle)

set_credentials(alias = 'postgres_db',
                dialect = 'postgresql',
                host = 'localhost',
                port = '5432',
                user = 'user',
                db_name = 'customers')
```

It sets the credential for a DB conection. Then, we can use it with:

``` r
con <- connect_postgres(alias='rsqlauthandle')
```

`con` is a DBIConnection object that we can use to list tables, get
table or query it.

``` r
dbListTables(con)
dbReadTable(con, 'accounts')
dbReadTable(con, "SELECT * FROM accounts")
```
