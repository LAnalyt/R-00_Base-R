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
