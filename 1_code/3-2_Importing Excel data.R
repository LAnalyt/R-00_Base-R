# 3. IMPORTING EXCEL DATA

# Excel is a widely used data analysis tool. There are already a lot of packages interacting with Excel to deal with the data in R. 

# 3.1 readxl ####
# readxl of the tidyverse package makes it easy to get data out of Excel and into R. 
library(readxl)
# excel_sheets(): lists the different sheets in the Excel file.
excel_sheets("urbanpop.xlsx") # contains urban population metrics for all countries in the world throughout time. 
# readxl is able to handle both .xls and .xlsx files. read_excel() imports the sheet data into R. By default the first sheet in the Excel file is imported as a tibble.
read_excel("urbanpop.xlsx")
# Explicitly tell read_excel() which sheet to import:
read_excel("urbanpop.xlsx", sheet = 3)
# The "sheet" argument works both with index or the sheet name.
read_excel("urbanpop.xlsx", sheet = "1975-2011")
# However, loading in every sheet manually and then merging them in a list can be quite tedious. Automate this with lapply():
pop_list <- lapply(excel_sheets("urbanpop.xlsx"), 
                   read_excel, 
                   path = "urbanpop.xlsx")
# Display the structure of pop_list:
str(pop_list)

# col_names: by default is TRUE, denoting whether the first row in the Excel sheets contains the column names. If this is not the case, you can set col_names to FALSE. In this case, R will choose column names for you. You can also choose to set col_names to a character vector with names for each column. 
# Import the urbanpop_nonames.xlsx file which contains the same data as urbanpop.xlsx but has no column names in the first row of the excel sheets:
read_excel("urbanpop_nonames.xlsx", 
           sheet = 1, 
           col_names = FALSE)
# Import the file again using a character vector for column names:
cols <- c("country", paste0("year_", 1960:1966))
read_excel("urbanpop_nonames.xlsx", 
           sheet = 1, 
           col_names = cols)
# skip: ignore a specified number of rows inside the Excel sheets.
read_excel("urbanpop.xlsx", 
          sheet = 2, 
          col_names = FALSE, 
          skip = 21)
# n_max: specify the number of records to read. 

# 3.2 gdata ####
# gdata package is an entire suite of tools for performing data manipulation in all sorts of fields. It supercharges the basic R distribution to make handling the data less painful. 
install.packages("gdata")
library(gdata)
# Among these tools the function read.xls() allows you to import Excel data. gdata can only handle .xls format, but it is easy to install a driver to support the newer .xlsl format, as well.
urban_pop <- read.xls("urbanpop.xls", sheet = 2)
head(urban_pop)
# read.xls() basically comes down to two steps: converting the Excel file to a .csv file using a Perl script, and then reading that .csv file with the read.csv() function that is loaded by default in R, through the utils package. This means that all the options that you can specify in read.csv(), can also be specified in read.xls().
columns <- c("country", paste0("year_", 1967:1974))
urban_pop <- read.xls("urbanpop.xls", sheet = 2,
         skip = 50, header = FALSE, stringsAsFactors = TRUE,
         col.names = columns)
head(urban_pop)
# After reading Excel data, we can try to clean and merge it. 
path <- "urbanpop.xls"
urban_sheet1 <- read.xls(path, sheet = 1)
urban_sheet2 <- read.xls(path, sheet = 2)
urban_sheet3 <- read.xls(path, sheet = 3)
# Combine sheets with cbind(). Make sure the first column of urban_sheet2 and urban_sheet3 are removed to avoid duplicating columns. 
urban <- cbind(urban_sheet1, 
               urban_sheet2[-1], 
               urban_sheet3[-1])
# Remove all rows with NAs:
urban_clean <- na.omit(urban)
# Print out a summary of urban_clean:
summary(urban_clean)

# 3.3 XLConnect ####
# XLConnect is one of the most comprehensive packages for working with Excel files through R. It works as a bridge between Excel and R.
install.packages("XLConnect")
# XLConnect depends on Java. To run the package you might have to install the Oracle's Java Development Kit (JDK) first.
library(XLConnect)
# Load a workbook into R:
book <- loadWorkbook("cities.xlsx")
# Have a look at the structure of the workbook:
str(book) # workbook object.
# Get the names of the sheets:
getSheets(book) # works exactly like the excel_sheets() in readxl.
# Read data from one sheet:
readWorksheet(book, sheet = "year_2000")
# Specify rows and columns to read, e.g, to get the population information of Berlin and Madrid.
readWorksheet(book, sheet = "year_2000",
              startRow = 3,
              endRow = 4,
              startCol = 2,
              header = FALSE) # because the first row is skipped.
# Add fresh population data from 2010 and store in a data frame:
pop_2010 <- data.frame(Capital = c("New York", "Berlin", "Madrid", "Stockholm"), Population = c(8191900, 3460725, 3273000, 1372565))
pop_2010
# To create a sheet with the data of `pop_2010` into the current workbook, first we create a new empty sheet:
createSheet(book, name = "year_2010")
# Next write the data from `pop_2010` to this new sheet:
writeWorksheet(book, pop_2010, sheet = "year_2010") # or sheet = 3
# Finally you have to explicitly save the entire workbook to a file for the changes to take effect.
saveWorkbook(book, file = "cities2.xlsx") # save to different file to avoid overwriting original data.
# Rename sheets:
renameSheet(book, "year_1990", "Y1990")
renameSheet(book, "year_2000", "Y2000")
renameSheet(book, "year_2010", "Y2000")
# Save the result again to a new file:
saveWorkbook(book, file = "cities3.xlsx")
# Remove sheets:
removeSheet(book, sheet = "Y2010")
saveWorkbook(book, file = "cities4.xlsx")

# Build a connection to the "urbanpop.xlsx" file in R:
my_book <- loadWorkbook("urbanpop.xlsx")
# Check again the class of my_book:
class(my_book)
# List the sheets in my_book:
sheets <- getSheets(my_book)
# Have an overview about urbanpop.xlsx without having to open up the Excel file:
all <- lapply(sheets, readWorksheet, object = my_book)
str(all)
# Suppose we're only interested in urban population data of the years 1968, 1969 and 1970. The data for these years is in the columns 3, 4, and 5 of the second sheet. 
urbanpop_sel <- readWorksheet(my_book, sheet = 2, 
                              startCol = 3, 
                              endCol =5)
# urbanpop_sel no longer contains information about the countries now. Import first column from second sheet in my_book:
countries <- readWorksheet(my_book, sheet = 2, startCol = 1, endCol = 1)
# cbind() urbanpop_sel and countries together:
selection <- cbind(countries, urbanpop_sel)
# Add a worksheet to my_book, named "data_summary":
createSheet(my_book, name = "data_summary")
getSheets(my_book)
# Create a data frame with some summary statistics on the two Excel sheets:
sheets <- getSheets(my_book)[1:3]
dims <- sapply(sheets, function(x) dim(readWorksheet(my_book, sheet = x)), USE.NAMES = FALSE)
summ <- data.frame(sheets = sheets,
                   nrows = dims[1, ],
                   ncols = dims[2, ])
# Add data in summ to "data_summary" sheet:
writeWorksheet(my_book, summ, sheet = "data_summary")
# Save workbook as summary.xlsx:
saveWorkbook(my_book, file = "summary.xlsx")
# rename the new sheet to just "summary":
renameSheet(my_book, "data_summary", "summary")
# Print out sheets of `my_book`:
getSheets(my_book)
# make sure to actually save my_book to a new Excel file:
saveWorkbook(my_book, file = "renamed.xlsx")
# Remove the fourth sheet:
removeSheet(my_book, sheet = 4)
# Save the resulting workbook to a file "clean.xlsx":
saveWorkbook(my_book , file = "clean.xlsx")
