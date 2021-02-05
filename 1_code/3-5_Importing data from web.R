# 5. IMPORTING DATA FROM WEB

# 5.1 HTTP ####
# More and more of the information that data scientists are using resides on the web. Importing this data into R requires an understanding of the protocols used on the web. 
# Http (HyperText Transfer Protocol) is the language of the web. It is basically a system of rules for how data should be exchanged between computers. 
# E.g, the file states.csv is located at the link: "https://raw.githubusercontent.com/ltrangng/R_00_Base-R/master/0_data/states.csv". The typical workflow would be manually download the file through a web browser, then point to the path inside read.csv(). However, we can simply pass the URL as a character string.
read.csv("https://raw.githubusercontent.com/ltrangng/R_00_Base-R/master/0_data/states.csv")
# R figures out that you referred to a URL, and requests it using a HTTP GET request. The server responses with the csv file. It also works with the secure https.
read.csv("https://s3.amazonaws.com/assets.datacamp.com/course/importing_data_into_r/states.csv")

# https URL to the swimming_pools csv file:
url_csv <- "https://raw.githubusercontent.com/ltrangng/R_00_Base-R/master/0_data/swimming_pools.csv"
# Import the file using read.csv()
pools1 <- read.csv(url_csv)
# Compare with the read_csv() from readr package
library(readr)
pools2 <- read_csv(url_csv)
# Both read.csv() and read_csv() do not need any arguments besides the file argument, which is the URL. But the results are different data types.
str(pools1) # returns a data frame.
str(pools2) # returns a tibble.

# 5.2 Downloading files ####
# Instead of reading directly from the URL, we can also download the file to local location using download.file() from the utils package.
url <- "https://raw.githubusercontent.com/ltrangng/R_00_Base-R/master/0_data/cities.xlsx"
# Define the destination path where you want to place the downloaded file in the system:
dest_path <- file.path("~", "local_cities.xlsx")
# R performs a GET request to the URL and stores the contents of the response to the local location.
download.file(url, dest_path)
# Read the Excel file with read_excel() from readxl package:
library(readxl)
read_excel(dest_path)
# download.file() is useful because of reproducibility. URLs can be specified in R script and downloaded instead of manually browsing the website.

# 5.3 RData ####
# An RData file is very efficient format to store R data. You can load data from an RData file using the load() function, but this function does not accept a URL string as an argument. 
# https URL to the wine RData file:
url_rdata <- "https://raw.githubusercontent.com/ltrangng/R_00_Base-R/master/0_data/wine.RData"
# Download the wine file to your working directory
download.file(url_rdata, destfile = "wine_local.RData")
# Load the wine data into your workspace using load():
load("wine_local.RData")
summary(wine)

# 5.4 httr ####
# Importing data with HTTP request from inside R may require authentication and additional parameters. The  httr package provides functions to deal with these.
library(httr)
# GET(): executes the GET request. The result is a response object, that provides easy access to the status code, content-type and, the actual content.
url <- "http://www.example.com"
resp <- GET(url)
resp
# content(): extract the content from the request. By default, if you don't specify the as argument, it will try to figure out what type of data you're dealing with and parses it for you.
content(resp)
# Get the raw content by passing the "as" argument:
raw_content <- content(resp, as = "raw")
head(raw_content)
# Get the URL from a sample JSON file:
url <- "http://www.omdbapi.com/?apikey=72bc447a&t=Annie+Hall&y=&plot=short&r=json"
resp <- GET(url)
resp
# Get the content of resp and print it out as text:
content(resp, as = "text")
# Without the "as" argument, R identifies automatically a JSON data, and converts the JSON to a named R list.
content(resp)

# 5.5 JSON & JSONlite ####
# Web content does not limit itself to HTML pages and files stored on remote servers. Another common one is JSON. This format is very often used by Web APIs (Application Programming Interface), interfaces to web servers with which a client can communicate to get or store information in more complicated ways.
# JSON format is very simple, concise, well-structured and human-readable. It is also easy to generate and interpret for machines, which makes it perfect to communicate with Web APIs. 
# Suppose you want to get some data on the movie "Annie Hall". 
url <- "https://www.imdb.com/title/tt0075686/"
download.file(url, "local_imdb.html")
# You could download the corresponding URL of IMDb, read it in, then start programmatically search your way through the HMTL code, which is more than 4000 lines, to get the information you need. This is very slow and error-prone.
# The OMDb API is and open movie database which can give information on movies. Simply take the URL with additional parameters like ID of the movie and what type of the response should be:
BROWSE("http://www.omdbapi.com/?apikey=72bc447a&t=Annie+Hall&y=&plot=short&r=json")
# To handle JSONs  we can use jsonlite package.
library(jsonlite)
# The fromJSON() function downloads the JSON data and converts it into a named R list.
fromJSON("http://www.omdbapi.com/?apikey=72bc447a&t=Annie+Hall&y=&plot=short&r=json")
# In the simplest setting, fromJSON() can convert character strings that represent JSON data into a nicely structured R list. 
wine_json <- '{"name":"Chateau Migraine", "year":1997, "alcohol_pct":12.4, "color":"red", "awarded":false}'
# wine_json represents a JSON. fromJSON() converts it to a list.
wine <- fromJSON(wine_json)
str(wine)
# fromJSON() also works if you pass a URL as a character string or the path to a local file that contains JSON data. 
quandl_url <- "https://www.quandl.com/api/v3/datasets/WIKI/FB/data.json?auth_token=i83asDsiWUUyfoypkgMz"
# Import Quandl data directly from the web:
quandl_data <- fromJSON(quandl_url)
# Display the structure of quandl_data:
str(quandl_data)

# A typical JSON object has the format of unordered collection of name/value pairs, e.g: {"id":1,"name":"Frank","age:23,"married":false}. Convert this JSON into R string:
x <- '{"id":1,"name":"Frank","age":23,"married":false}' # single quote
# Pass the string to fromJSON() that converts a JSON to R code.
r <- fromJSON(x)
str(r) # returns a list.

# JSON array id an ordered sequence of zero or more values, e.g: [4, 7, 4, 6, 4, 5, 10, 6, 6, 8].
# Calling fromJSON() on this JSON results in an integer vector.
fromJSON('[4, 7, 4, 6, 4, 5, 10, 6, 6, 8]')
# This is actually a simplification because JSON arrays, like JSON objects, are heterogeneous: they can contain elements of different types.
x <- '[4,"a", 4, 6, 4,"b", 10, 6, false, null]' 
fromJSON(x) # numbers and logical values are  coerced into characters, "null" to NA in R.

# Nesting JSOn: both JSON objects and JSON array can contain other JSON objects and arrays.
r <- fromJSON('{"id": 1,
              "name": "Frank",
              "age": 23,
              "married": false, 
              "partner": {"id": 4,
              "name": "Julie"}}')
str(r) # returns a nested named list.

# Build an array of JSON objects:
fromJSON('[{"id":1,"name":"Frank"},
         {"id":4,"name":"Julie"},
         {"id":12,"name":"Zach"}]') # returns a data frame.

# toJSON():  converts R data to a JSON format.
# Import a csv file containing information on the amount of desalinated water that is produced around the world:
url_csv <- "http://s3.amazonaws.com/assets.datacamp.com/production/course_1478/datasets/water.csv"
water <- read.csv(url_csv)
water_json <- toJSON(water)
