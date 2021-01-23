# 4. IMPORTING RELATIONAL DATA

# 4.1 Relational databases ####
# Many companies store their information in relational databases. The information is stored in separate tables whose identifier can be connected to each other through a database management system (DBMS). # Open-source DBMS: MySQL, postgreSQL, SQLite...
# Proprietary DBMS: Oracle Database, Microsoft SQL Server
# Practically all DBMS use SQL language for querying and maintaing database. Depending on the type of database you want to connect to, you will have to use different packages.
install.packages("RMySQL") # for MySQL database.
# RMySQL includes automatically the DBI package which contains functions to access and manipulate the database.
library(DBI)
# PostgresSQL: RPostgresSQL package
# Oracale Database: ROracle package

# 4.2 Connecting to a database ####
# dbConnect() creates a connection between your R session and a SQL database. Create a connection to the remote MySQL database:
con <- dbConnect(RMySQL::MySQL(),    # construct  SQL driver
                 dbname = "tweater", # specify database's name
                 host =  "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",   # credentials to identify    
                 password = "datacamp")        
# The result of dbConnect() is a DBI connection object. This object has to be passed to any function for interacting with the database.
con 

# 4.3 Import table data ####
# After connecting successfully to a database, we want to see what is in there. The first step is listing all the tables in the database.
tables <- dbListTables(con)
# The database contains data on a more tasty version of Twitter, namely Tweater. Users can post tweats with short recipes for delicious snacks. People can comment on these tweats. 
str(tables) 
# Next importing the data on the users into R session:
dbReadTable(con, "users") # specify table in second argument.
# The result is a data frame, with exactly the same contents as in the original database table.
# Use lapply() to import all the tables:
lapply(tables, dbReadTable, conn = con)
# The tweats table contains a column user_id. The ids in the column refer to the users that have posted the tweat. Similarly, the comments contain both a user_id and a tweat_id column. It specifies which user posted a comment on which tweat.

# 4.4 SQL queries from inside R ####
# Finally, explicitly disconnect the database after you're done:
dbDisconnect(con)
con # no longer available.
