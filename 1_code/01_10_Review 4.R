# DATA FRAMES ####

# Create a data frame ====

# Data frames are another way to put data in table
data.frame(a = 1:3) #makes a data frame with a column named a.
# The first number column are row labels and are not a part of the data frame
d <- data.frame(a = 4:6, b = 7:9)
# Each column in a data frame is a vector
a <- c(6, 5)
b <- c(1, 1)
d <- data.frame(a, b)
# Unlike matrices, data frames can have different types of data
d <- data.frame(a = 1:2, b = c("x", "y"), c = c(FALSE, TRUE))
# When you have a lot of data, head() function lets you view the first few rows
d <- data.frame(a = 20:49, b = 50:79)
head(d)
# tail() function is like head(), except it shows the last few rows.
# str() function is another useful way to view the structure of the dataset
d <- data.frame(x = 7:8, y = c(TRUE, FALSE))
str(d)

# Subset Data Frames ====

# Subset the rows and columns with single [] similar like in matrices
d <- data.frame(a = 1:3, b = 4:6)
d[1,2] #4
# As with subsetting matrices, ":" is used to select a range of rows or columns
d <- data.frame(a = 1:3, b = 4:6)
d[2:3,1:2]
# If you leave out the row numbers, R will reteun al the rows (ditto for columns)
d <- data.frame(a = 1:3, b = 4:6)
d[1:2,]
# It's easier to remember the name of a column than its index
d <- data.frame(a = 1:3, b = 4:6)
d[3,"b"] #6
# Using $ sign to extract column from a data frame
d <- data.frame(dog = 7:9, cat = 10:12)
d$cat
# Another way to subset rows is to use a vector of Booleans. R will keep the rows corresponding to TRUE and drop those corresponding to FALSE
df <- data.frame(a = 1:5, b = 6:10)
v <- c(TRUE, TRUE, TRUE, FALSE, FALSE)
df[v,]
# You can also use subset() with comparison operators to get the rows that meet a condition'd <- data.frame(a = 1:5, b = 5:9). R will return all the columns.
subset(d, a >3)

# Reordering Data ====

# The order() function gives the indices of a vector that would rearrange it in sorted order
v <- c(2, 7 , 1, 0)
order(v) #4 3 1 2
# Use order() to reorder vector
v <- c(5, 7, 6)
v[order(v)] #5 6 7
# Save the results of ordering a vector as a new vector to make it easier to work with
b <- c(5, 2, 7, 3)
d <- data.frame(a = 1:4, b)
pos <- order(d$b)
d$b[pos] #2 3 5 7
# Use order() to sort the rows of a data frame based on the values in a column
a <- c(2, 1, 3)
b <- c("x", "y", "z")
d <- data.frame(a, b)
d[order(d$a),] #The row numbers stay attached to their original rows.

# LISTS ####

# Intro to Lists ====

# Lists can hold different kinds of objects like vectors, matrices, and data frames.
list(1:3, matrix(4:6, nrow = 1))
# The elements in the list are given numbers like [[1]], [[2]]...
# You can name the elements when creating a list
list(a = 1:3, b = matrix(4:6, nrow = 1)) #the names will be preceded vy $ sign.
# Or set the names of a vector using names() function
l <- list(7:9, 10:12)
names(l) <- c("x", "y")
# c() can also add new elements to an existing list
l <- list(Bob = 6)
c(l, Amy = 2)

# Subsetting lists ====

# To extract the first element from list a, write a[[1]]
d <- data.frame(x = 1:2, y = 3:4)
m <- matrix(1:4, nrow = 1)
mylist <- list(d, m)
mylist[[1]]
# If a list's elements are named, you can put the quoted name of the element within the double [[]]
l <- list(a = 1:3, b = 4:9)
l[["a"]]
# Or use the shortcut with $ sign
l <- list(fruit = "apple", nums = 5:7)
l$fruit
l$nums
# Combine subsetting techniques
l <- list(a = 1:5, b = 6:10)
l[["b"]][1] #6