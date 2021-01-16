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
properties <- c("area", "temp", "size", "storage", "method", "texture", "flavor", "moistness")
pop_list <- lapply(excel_sheets("urbanpop.xlsx"), 
                   read_excel, 
                   path = "urbanpop.xlsx")
# Display the structure of pop_list:
str(pop_list)

# col_names: by default is TRUE, denoting whether the first row in the Excel sheets contains the column names. If this is not the case, you can set col_names to FALSE. In this case, R will choose column names for you. You can also choose to set col_names to a character vector with names for each column. 

# 3.3 gdata ####
