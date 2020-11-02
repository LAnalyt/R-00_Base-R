#1. R BASICS ####

## 1.1 Basic arithmethic ====
# R uses +, -, * like a calculator.
8 - 5 
6 / 3 
# Like on a calculator, parenthese can be used to priotirize calculations
(1 + 2) * 3 
# ^ and ** are exponential operators
7 ^ 2
# The modulo operator %% returns the remainder of a division
7 %% 2 
(7 %% 4) ^ 2 

## 1.2 R variables ====
# Variables allow you to store values for later use.
age <- 23
age 
# To output the vaue of a variable to the screen, type the variable name
pi <- 3.14
pi
# Store a value in a variable is called assignment. Value must be assigned to a variable before it could be used. If a new value is assigned to an existing variable,it will replace the previous value
age <- 17
age <- 18

## 1.3 Data types ====
# Every value has a data type, which classifies the value. 
# Letters and words like "r", "data" in quote are called strings, and have the character data type.
# Use class() function to get the data type of a value or a variable.
class("HelloWorld") 
x <- "5"
class(x) # since the number is in quote "", its data type belongs to "character"
# Integers (whole numbers) and numbers with decimal places have the numeric data type.
n <- 3.14
class(n) 
# Boolean values represent something is true or false. They have logical data type, and have to be written in uppercase.
class(TRUE) 

# 2. VECTORS ####

## 2.1 Creating vectors ====
# Store multiple values with c() function, combining the elements separated by commas into a vector
c(1, 2, 3) # R prints the elements in a vector separated by spaces. The [1] is not part of the vector, it's only part of how R displays it.
# Assign a vector to a variable and print it
v <- c(2, 3, 4)
v
# Vectors may contain character or Boolean values instead of numbers
v <- c("x", "y", "z")
v <- c(TRUE, TRUE, FALSE)
# Within a single vector, all elements have the same data type
# The elements of a vector can have names; these get printed, too. Add names to a vector using another vector
v <- c(2, 4, 6)
names(v) <- c("a", "b", "c")
# Or giving name to the value with equal sign
v <- c(a = 2, b = 4, c = 6)
v # note that when vector has a name, R doesn't print [1].
values <- c(5, 3, 1)
titles <- c("x", "y", "z")
names(values) <- titles
values

## 2.2 Performing calculations with vectors ====
# You can do arithmatic when creating vectors, and the results will be stored in the vector.
v <- c(1+1, 2+2, 3+3) 
# Add 2 vectors with +, R will add the elements of the vectors element-wise.
a <- c(1, 2, 3)
b <- c(4, 5, 6)
a + b 
# You can also store the result in a new vector.
c <- a + b
c 
# Use sum() to take the sum of everything in the vector.
v <- c(5, 5, 10)
sum(v) 

## 2.3 Subsetting vectors ====
# You can pinpoint an element in a vector by its index in []
v <- c(4, 9, 1, 5, 3)
v[1] 
# You can also get multiple elements from a vector by putting a vector of indices within the brackets.
v <- c(4, 9, 1, 5, 3)
v[c(1, 3)] # the selected elements correspond directly to the indices you use, in whatever order you specify.
# Save the results of subsetting a vector as a new vector:
a <- c("red", "orange", "yellow")
b <- a[c(1, 3)]
b 
# Shortcut for creating a vector of sequential integers: typing 1:5 will create a vector of values 1 2 3 4 5. You can also use ":" syntax to subset a range of elements in a vector.
v <- c(2, 3, 4, 6, 8, 10)
v[2:4] 
# You can also subset a vector using its name:
v <- c(1.1, 2.2, 3.3)
names(v) <- c("Bob", "Joy", "Rex")
v["Bob"] 
# mean() calculates the sum of the elements divided by how many there are.
v <- c(5, 2, 5)
mean(v) 

## 2.4 Comparing values in vectors ====
# R has comparison operators:
# ==: check if one value is equal to another
# !=: check if one value is not equal to another
# <: check if one value is smaller than another
# <=: check if one value is smaller than or equal to another
# >: check if one value is greater than another
# >=: check if one value is greater than or equal to another
# When you compare two numbers or strings, you get a Boolean as results.
5 > 3 
4 == 5 
"orange" != "yellow" 
# You can use these comparison operators to compare each element in a vector to some other value:
v <- c("cat", "dog", "hamster")
v == "cat"
# You can also save the result of a comparison as a Boolean vector!
v <- c(2, 4, 3, 9, 10)
comp <- v < 7
comp 
# Subset using Boolean:
v <- c("small", "large", "huge")
big <- v != "small"
big 
v[big]

# 3. MATRICES ####

## 3.1 Create matrices ====

# A matrix stores data in rows and columns, like a table.
matrix(1:4, nrow = 2)
# nrow is an argument that tells matrix() how many rows there should be.
matrix(c("a", "b"), nrow = 2)
# By default, matrix() fills in values from top to bottom. Choose to fill them from left to right using byrow argument:
matrix(c(5, 4, 2, 3), byrow = TRUE, nrow = 2)
# To remember what's stored in the data, give rows and columns names:
m <- matrix(c(19, 31), nrow = 1)
rownames(m) <- c("Age")
colnames(m) <- c("Ed", "Amy")
m # names are printed.

## 3.2 Combining matrices ====

# You can do some useful calculations on matrices, like finding the sum of each row with rowSums() function.
m <- matrix(c(20, 25, 26, 30), nrow = 2)
rowSums(m) 
# colSums() function calculates the sum of each column.
m <- matrix(6:11, nrow = 2)
colSums(m) 
# rbind() stacks the rows from one matrix onto another.
m <- matrix(1:3, nrow = 1)
n <- matrix(4:6, nrow = 1)
rbind(m, n)
# Similarly, cbind() function pastes the columns of two matrices together.
a <- c("green", "blue") 
b <- c("red", "purple")
cbind(a, b)

## 3.3 Subsetting matrices ====

# Like with vectors, use [] to select elements form a matrix:
m <- matrix(1:6, nrow = 2)
m [1,2] 
# Use slicing to select elements from a matrix:
m <- matrix(1:9, byrow = TRUE, nrow = 3)
m[1:2, 2:3]
# To select all elements of a matrix row or column, leave out the number before or after the comman in []:
m <- matrix(1:9, byrow = TRUE, nrow = 3)
m[,2]

## 3.4 Arithmetic matrices ====

# Like with vectors, you can use the arithmetic operators element-wise on matrices.
m <- matrix(1:4, nrow = 2)
m * 2
# Or use operators on entire matrices:
m1 <- matrix(1:3, nrow = 1)
m2 <- matrix(1:3, nrow = 1)
m1 ** m2
# mean() gives the average pf all values in a matrix.
m <- matrix(1:4, byrow = TRUE, nrow = 2)
mean(m) 

# 4. FACTORS ####

## 4.1 Intro to factors ====

# In R, factor vectors store categorical data that falls into finite number of categories. They're printed out without quote " ".
v <- c("a", "b", "c")
factor(v)
# The levels of a factor are the possible categories, and are printed along with the data in alphabetical order.
v <- c("red", "red", "blue")
factor(v)
# R automatically sets the levels of the factor in alphabetical order, which can be viewed with levels().
v <- c("y", "x", "z", "y")
f <- factor(v)
levels(f) 
# Rename levels:
v <- c("r", "b", "b")
f <- factor(v)
levels(f) <- c("blue", "red")
levels(f) 
# When you change the levels of a factor, it also changes how the data is printed to use the new levels.
v <- c("c", "d", "c")
f <- factor(v)
levels(f) <- c("cat", "dog")
f

## 4.2 Summarizing categorical data ====

# Storing data in a factor can let you do useful things, like see the counts of each category with the summary() function.
v <- c("a", "a", "b", "c")
f <- factor(v)
summary(f)
# You can subset a factor with []. The levels are still displayed.
v <- c("x", "y", "z")
factor(v)[1]
# Strings can be compared alphabetically.
"a" > "z" 
"ab" < "bc" 
# If factors have no ranking of levels, the comparison will result a NA and a warning.
v <- c("a", "b")
f <- factor(v)
f[1] <f[2]

## 4.3 Ordered factor ====

# R can't compare factors without an implied order.
v <- c("low", "high", "med")
f <- factor(v)
f[1] < f[2] 
# R represents ordinal variables as ordered factors, using the ordered argument to factor(). R orders alphabetically.
speed <- c("low", "high", "med", "med")
factor(speed, ordered = TRUE)
# To explicitly tell R the levels of a factor, add the levels argument to factor():
speed <- c("low", "high", "med", "med")
factor(speed, levels = c("low", "med", "high"))
# If you specify both order = TRUE and levels, R uses the order of levels.
heights <- c("tallest", "short", "tall", "tall")
factor(heights, ordered = TRUE, levels = c("tallest", "tall", "short"))
# Now you can compare factors:
v <- c("low", "high", "med")
f <- factor(v, ordered = TRUE, levels = c("low", "med", "high"))
f[1] < f[2] 

# 5. DATA FRAMES ####

## 5.1 Create a data frame ====

# Data frames are another way to put data in table.
data.frame(a = 1:3) # makes a data frame with a column named a.
# The first number column are row labels and are not a part of the data frame.
d <- data.frame(a = 4:6, b = 7:9)
# Each column in a data frame is a vector.
a <- c(6, 5)
b <- c(1, 1)
d <- data.frame(a, b)
# Unlike matrices, data frames can have different types of data.
d <- data.frame(a = 1:2, b = c("x", "y"), c = c(FALSE, TRUE))
# When you have a lot of data, head() function lets you view the first few rows.
d <- data.frame(a = 20:49, b = 50:79)
head(d)
# tail() function is like head(), except it shows the last few rows.
# str() function is another useful way to view the structure of the dataset.
d <- data.frame(x = 7:8, y = c(TRUE, FALSE))
str(d)

# 5.2 Subset Data Frames ====

# Subset the rows and columns with single [] similar like in matrices:
d <- data.frame(a = 1:3, b = 4:6)
d[1,2] 
# As with subsetting matrices, ":" is used to select a range of rows or columns.
d <- data.frame(a = 1:3, b = 4:6)
d[2:3,1:2]
# If you leave out the row numbers, R will reteun al the rows (ditto for columns).
d <- data.frame(a = 1:3, b = 4:6)
d[1:2,]
# It's easier to remember the name of a column than its index.
d <- data.frame(a = 1:3, b = 4:6)
d[3,"b"] 
# Using $ sign to extract column from a data frame:
d <- data.frame(dog = 7:9, cat = 10:12)
d$cat
# Another way to subset rows is to use a vector of Booleans. R will keep the rows corresponding to TRUE and drop those corresponding to FALSE.
df <- data.frame(a = 1:5, b = 6:10)
v <- c(TRUE, TRUE, TRUE, FALSE, FALSE)
df[v,]
# You can also use subset() with comparison operators to get the rows that meet a condition.
d <- data.frame(a = 1:5, b = 5:9)
subset(d, a >3)

## 5.3 Reordering Data ====

# The order() function gives the indices of a vector that would rearrange it in sorted order.
v <- c(2, 7 , 1, 0)
order(v) 
# Use order() to reorder vector
v <- c(5, 7, 6)
v[order(v)] 
# Save the results of ordering a vector as a new vector to make it easier to work with:
b <- c(5, 2, 7, 3)
d <- data.frame(a = 1:4, b)
pos <- order(d$b)
d$b[pos] 
# Use order() to sort the rows of a data frame based on the values in a column:
a <- c(2, 1, 3)
b <- c("x", "y", "z")
d <- data.frame(a, b)
d[order(d$a),] # The row numbers stay attached to their original rows.

# 6. LISTS ####

## 6.1 Intro to Lists ====

# Lists can hold different kinds of objects like vectors, matrices, and data frames.
list(1:3, matrix(4:6, nrow = 1))
# The elements in the list are given numbers like [[1]], [[2]]...
# You can name the elements when creating a list
list(a = 1:3, b = matrix(4:6, nrow = 1)) # the names will be preceded by $ sign.
# Or set the names of a vector using names() function:
l <- list(7:9, 10:12)
names(l) <- c("x", "y")
# c() can also add new elements to an existing list.
l <- list(Bob = 6)
c(l, Amy = 2)

## 7.2 Subsetting lists ====

# To extract the first element from list a, write a[[1]]:
d <- data.frame(x = 1:2, y = 3:4)
m <- matrix(1:4, nrow = 1)
mylist <- list(d, m)
mylist[[1]]
# If a list's elements are named, you can put the quoted name of the element within the double [[]].
l <- list(a = 1:3, b = 4:9)
l[["a"]]
# Or use the shortcut with $ sign:
l <- list(fruit = "apple", nums = 5:7)
l$fruit
l$nums
# Combine subsetting techniques:
l <- list(a = 1:5, b = 6:10)
l[["b"]][1] 