# 3. IMPORTING RELATIONAL DATA

# 3.1 Relational databases ####
# Many companies store their information in relational databases. The information is stored in separate tables whose identifier can be connected to each other through a database management system (DBMS). 
# Open-source DBMS: MySQL, postgreSQL, SQLite...
# Proprietary DBMS: Oracle Database, Microsoft SQL Server
# Practically all DBMS use SQL language for querying and maintaining database. Depending on the type of database you want to connect to, you will have to use different packages.
install.packages("RMySQL") # for MySQL database.
# RMySQL includes automatically the DBI package which contains functions to access and manipulate the database.
library(DBI)

# 3.2 Connecting to a database ####
# dbConnect(): creates a connection between your R session and a SQL database. 
con <- dbConnect(RMySQL::MySQL(),    # construct  SQL driver
                 dbname = "tweater", # specify database's name
                 host =  "courses.csrrinzqubik.us-east-1.rds.amazonaws.com",
                 port = 3306,
                 user = "student",   # credentials to identify    
                 password = "datacamp")        
# The result of dbConnect() is a DBI connection object. This object has to be passed to any function for interacting with the database.
class(con) 

# 3.3 Import table data ####
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

# 3.4 SQL queries from inside R ####
# dbReadTable() imports the entire table, which is not optimal with large database. Selective importing only imports the elements that you actually need inside R via SQL language.
# SQL queries: retrieve data based on specific criteria. 
dbGetQuery(con, "SELECT name FROM users WHERE id = 1")
# The syntax is common in SQL query, with keywords: SELECT, FROM and WHERE. 
# SELECT: specifies which column to select
# FROM: specifies which table you want to get data
# WHERE: specifies a condition that a record in the table has to meet. Notice in SQL language "=" replaces "=="  conditional constraint.
# Without dbGetQuerry(), we will have to load the entire dataset into R then create a subset out of it.
users <- dbReadTable(con, "users")
subset(users, subset = id == 1,
       select = name) # the result is exactly the same. 
# Apart from checking equality, you can also check for less than and greater than relationships, with < and >, just like in R.
dbGetQuery(con, "SELECT post FROM tweats WHERE date > 2015-09-21")
# Add more conditions with AND:
dbGetQuery(con, "SELECT message FROM comments WHERE tweat_id = 77 AND user_id > 4")
# `CHAR_LENGTH()` returns the number of characters in a string.
dbGetQuery(con, "SELECT id, name FROM users WHERE CHAR_LENGTH(name) < 5")
# Another very often used keyword is JOIN, and more specifically INNER JOIN.
dbGetQuery(con, "SELECT post FROM tweats INNER JOIN comments on tweats.id = tweat_id WHERE tweat_id = 77")
# Under the hood of dbGetQuery(), R sends a query to the database with dbSendQuery().
names <- dbSendQuery(con, "SELECT name FROM users")
# This function returns a result, but does not contain any records. For that we need to use dbFetch().
dbFetch(names)
# Clear the result manually:
dbClearResult(names)
# The combination of dbSendQuery, dbFetch and dbClearResult gives exactly the same result as dbGetQuery does. But dbFetch query calls allow you to specify a maximum number of records to retrieve per fetch.
dbFetch(names, n = 2) # This is useful to load tons of records chunk by chunk.
# Suppose you want to want to get the result of the query record by record, you can also construct a while loop.
while(!dbHasCompleted(names)) {
  chunk <- dbFetch(names, n = 1)
  print(chunk)
}
# Create the data frame long_tweats where the character length of the post variable exceeds 40:
long_tweats <- dbGetQuery(con, "SELECT post, date FROM tweats WHERE length(post) > 40")
long_tweats

# Finally, explicitly disconnect the database after you're done:
dbDisconnect(con)
con # no longer available.