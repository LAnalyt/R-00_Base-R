# 3. IMPORTING EXCEL DATA

# Excel is a widely used data analysis tool. There are already a lot of packages interacting with Excel to deal with the data in R. 

# 3.1 readxl ####
# readxl of the tidyverse package makes it easy to get data out of Excel and into R. 
library(readxl)
# An Excel file contains different sheets that contain tabular data. Typically in R we want to explore the Excel file first and then import some data from it. excel_sheets() lists the different sheets in the Excel file.
excel_sheets("urbanpop.xlsx") # contains urban population metrics for all countries in the world throughout time (source: Gapminder). 
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

# 3.2 gdata ####
# gdata package is an entire suite of tools for performing data manipulation in all sorts of fields. It supercharges the basic R distribution to make handling the data less painful. Among these tools the function read.xls() allows you to import Excel data.
install.packages("gdata")
library(gdata)
# gdata can only handle .xls format, but it is easy to install a driver to support the newer .xlsl format, as well.
urban_pop <- read.xls("urbanpop.xls", sheet = 2)
head(urban_pop)
# read.xls() basically comes down to two steps: converting the Excel file to a .csv file using a Perl script, and then reading that .csv file with the read.csv() function that is loaded by default in R, through the utils package. This means that all the options that you can specify in read.csv(), can also be specified in read.xls().
columns <- c("country", paste0("year_", 1967:1974))
urban_pop <- read.xls("urbanpop.xls", sheet = 2,
         skip = 50, header = FALSE, stringsAsFactors = TRUE,
         col.names = columns)
head(urban_pop)
str(urban_pop)
# After reading Ecel data, we can try to clean and merge it. 
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