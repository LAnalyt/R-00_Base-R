# 2. READR AND DATA.TABLE

# In addition to base R, there are dedicated packages to easily and efficiently import flat file data. 

# 2.1 readr ####
# readr of the tidyverse package is fast and easy to use with consistent naming, while utils is more verbose and multiple slower.
library(readr)
# Similar function like read.csv in readr is read_csv:
read_csv("states.csv")
# The result is pretty much the same. The only difference is read_csv ouputs a tibble, which is a supercharged version of data frame. The printout conveniently shows the column classes.
# readr also provides read_tsv (tab separated value) which is a similar function to read.delim.
read_tsv("states.txt")
# In both cases there is no need to specify stringsAsFactors explicitly, because readr doesn't import strings automatically as factors. Just like in utils package, both read_csv and read_tsv are wrappers around the mother import function read_delim().
# Import the potatoes csv data which gives information on the impact of storage period and cooking on potatoes' flavor. 
read_csv("potatoes.csv")
# Use read_tsv for txt data instead:
read_tsv("potatoes.txt")
# This txt file does not contain columns names in the first row. This can be specify manually.
properties <- c("area", "temp", "size", "storage", "method", "texture", "flavor", "moistness")
potatoes <- read_tsv("potatoes.txt", col_names = properties)
head(potatoes)

# 2.2 read_delim ####
# Use the low-level read_delim from readr to read the txt files with values using "/" as separators: 
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

# Import hotdogs.txt without col_types
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

# 2.3 data.table: fread ####
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