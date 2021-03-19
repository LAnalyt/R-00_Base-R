# 1. IMPORT DATA FROM FLAT FILES WITH UTILS

# 1.1 read.csv ####
# Flat files are typically simple text files that display data as tables. The standard distribution of R provides functionality in built-in package "utils" to import flat files into R as a data frame.
# csv: flat file (comma separated values)
# Import the "states.csv" file with read.csv() function. 
df<- read.csv("states.csv", stringsAsFactors = TRUE)
# First argument: the imported file's path. 
# stringsAsFactors: chooses to import columns that contains strings as actual strings or factors. By default, stringsAsFactors = FALSE.
df # lists basic information on some US states that corresponds nicely to the csv file.
str(df) # first 2 columns are strings, not factors.
# Use dir() to list the files in the working directory:
dir()
# Import "swimming_pools.csv" which contains data on swimming pools in Brisbane, Australia:
pools <- read.csv("swimming_pools.csv")
str(pools)

# 1.2 read.delim ####
# Another common format of flat file data is the tab-delimited file, like "*.txt" file. Import the same "states" data but in txt format, with read.delim():
read.delim("states.txt")
# By default, read.delim sets the "sep" argument to "\t" (fields in a record are delimited by tabs) and the header argument to TRUE (the first row contains the field names). 
# Import "hotdogs.txt" which contains information on sodium and calorie levels in different hotdogs:
hotdogs <- read.delim("hotdogs.txt", header = FALSE) # variable names are not on the first line.
# Print out some summary statistics about all variables in the data frame:
summary(hotdogs)
# Specify the column types or column classes of the resulting data frame with colClasses argument:
hotdogs <- read.delim("hotdogs.txt", 
                      header = FALSE, 
                      col.names = c("type", "calories", "sodium"),
                      colClasses = c("factor", "NULL", "numeric"))
str(hotdogs) # If a column is set to "NULL" in the colClasses vector, this column will be skipped and will not be loaded into the data frame.

# 1.3 read.table ####
# read.table() allows you to read in any file in table format and create a data frame from it. E.g, the same states data with the values being separated by "/" instead of "," or tab. 
read.table("states2.txt",
           header = TRUE,
           sep = "/")
# "states2.txt": path to the imported file
# header: tells R the first row of the text file contains variable names. By default header = FALSE, which means the first row is always read as an observation.
# sep: specifies how fields in a record are separated. By default sep = " ".

# Import the "hotdogs.txt" again, this time with read.table() with an argument to name the columns:
hotdogs <- read.table("hotdogs.txt", 
           sep = "",
           col.names = c("type", "calories", "sodium"),
           stringsAsFactors = TRUE)
head(hotdogs)
# Next to calories and sodium, the hotdogs have one more variable: type. This is a categorical variable because it can be only one of three things: Beef, Meat, or Poultry. Select the hot dog with the least calories:
hotdogs[which.min(hotdogs$calories), ]
# Select the observation with the most sodium:
hotdogs[which.max(hotdogs$sodium), ]

# 1.4 Wrappers ####
# read.table() is the main function of the utils package. read.csv() and read.delim() are so called wrapper functions around read.table(). Behind the scenes, read.table() is called, but with different default arguments to match the specific formats.
read.csv("states.csv")
# is the same as:
read.table("states.csv", 
           header = TRUE, 
           sep = ",",
           stringsAsFactors = FALSE)
# So you don't have to specify manually these anymore. Wrappers are shorter and easier to read.
# Likewise read.delim() is the same as:
read.delim("states.txt",
           header = TRUE,
           sep = "\t")
# read.csv2() and read.delim2() exist to deal with regional differences in representing numbers. E.g, read.csv() doesn't always give the result we want, because the values are separated by a ";", not a ",".
read.csv("states_nay.csv")
# Try again with read.csv2():
read.csv2("states_nay.csv") 
# It works perfectly, because the default argument sep = ";".
# read.delim2() has a default argument to convert the European decimal system with "," into the US "."
read.delim("states_aye.txt")
read.delim2("states_aye.txt")

# 1.5 scan ####
# when reading in spreadsheets many things can go wrong. The file might have a multiline header, be missing cells, or it might use an unexpected encoding. Scan() helps you read-in each cell of a file.
scan("states.csv", sep = ",", what = "c")

# 1.5 readr ####
# In addition to base R, there are dedicated packages to easily and efficiently import flat file data.
# readr of the tidyverse package is fast and easy to use with consistent naming, while utils is more verbose and multiple times slower.
library(readr)
# Similar function like read.csv in readr is read_csv:
read_csv("states.csv") # returns a tibble.
# readr also provides read_tsv (tab separated value) which is a similar function to read.delim.
read_tsv("states.txt")
# In both cases there is no need to specify stringsAsFactors explicitly, because readr doesn't import strings automatically as factors. Just like in utils package, both read_csv and read_tsv are wrappers around the mother import function read_delim().
# Import the "potatoes.csv" data 
read_csv("potatoes.csv") # gives information on the impact of storage period and cooking on potatoes' flavor.
# Use read_tsv for txt data instead:
read_tsv("potatoes.txt")
# This txt file does not contain columns names in the first row. This can be specify manually.
properties <- c("area", "temp", "size", "storage", "method", "texture", "flavor", "moistness")
potatoes <- read_tsv("potatoes.txt", col_names = properties)
head(potatoes)

# Use the low-level read_delim from readr to read the .txt files with values using "/" as separators: 
read_delim("states2.txt", delim = "/") # header = TRUE by default.
# "delim" argument specifies the character that is used to separate fields within a record. It is equivalent to the "sep" argument in read.table().
# col_names = TRUE by default, that takes the first record as the column names. Setting col_names = FALSE leads to automatic generation of column names.
read_delim("states3.txt", delim ="/", 
           col_names = FALSE) # first line is a record.
# Manually set col_names to a character vector:
read_delim("states3.txt", delim = "/",
           col_names = c("state", "city", "pop", "area"))
# col_types controls the column classes (similar to colClasses in utils). Without specified col_types, the column types will be guessed from the first 30 rows on the input. The printout of the tibble shows the class of each column, which is very practical. 
read_delim("states2.txt", delim = "/",
           col_types = "ccdi") # c: character, d: double, i: integer
# skip and n_max: control which part of your flat file you're actually importing into R.
read_delim("states2.txt", delim = "/",
           col_names = c("state", "city", "pop", "area"),
           skip = 2, n_max = 3)
# skip: specifies the number of lines you're ignoring in the flat file before actually starting to import data.
# n_max: specifies the number of lines you're actually importing.

# Use read_delim to potatoes.txt instead of read_tsv:
read_delim("potatoes.txt", delim = "\t",
           col_names = properties)
# Import observations 7, 8, 9, 10 and 11 only:
read_delim("potatoes.txt", delim = "\t",
           skip = 6, n_max = 5,
           col_names = properties)
# Another way of setting the types of the imported columns is using collectors. Collector functions can be passed in a list() to the col_types argument to tell them how to interpret values in a column.
# col_integer(): the column should be interpreted as an integer.
# col_factor(levels, ordered = FALSE): the column should be interpreted as a factor with levels.

# Import hotdogs.txt without col_types:
hotdogs <- read_tsv("hotdogs.txt", 
                    col_names = c("type", "calories", "sodium"))
summary(hotdogs)
# Define collector functions:
fac <- col_factor(levels = c("Beef", "Meat", "Poultry"))
int <- col_integer()
# Edit the col_types argument to import the data correctly:
hotdogs_factor <- read_tsv("hotdogs.txt",
                           col_names = c("type", "calories", "sodium"),
                           col_types = list(fac, int, int))
summary(hotdogs_factor)

# 1.7 data.table: fread ####
# fread() is a super function from the data.table package for reading huge files very fast.
install.packages("data.table")
library(data.table)
# fread() is similar to read.table() but more convenient to use. Call fread() on states.csv with the first line as column names, and states2.csv without column names:
fread("states.csv")
fread("states2.csv")
# fread() automatically deals with both cases without any specific arguments. It can also infer column types and the field separators without having to specify these. 
# Import potatoes.csv with fread()
fread("potatoes.csv")
# Import only columns 6 and 8 of potatoes.csv
fread("potatoes.csv", select = c(6, 8))
# or using the column names:
potatoes <- fread("potatoes.csv", select = c("texture", "moistness"))
# Plot texture (x) and moistness (y) of potatoes:
plot(potatoes$texture, potatoes$moistness)

# The class of the result of fread() is both data.table and data.frame. read_csv() creates an object with three classes: tbl_df, tbl and data.frame.