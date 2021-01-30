# 5. IMPORTING DATA FROM WEB

# 5.1 HTTP ####
# More and more of the information that data scientists are using resides on the web. Importing this data into R requires an understanding of the protocols used on the web. 
# Http (HyperText Transfer Protocol) is the language of the web. It is basically a system of rules for how data should be exchanged between computers. 
# E.g, the file states.csv is located at the link: "https://raw.githubusercontent.com/ltrangng/R_00_Base-R/master/0_data/states.csv". The typical workflow would be manually download the file through a web browser, then point to the path inside read.csv(). However, we can simply pass the url as a character string.
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