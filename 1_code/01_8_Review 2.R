# MATRICES ####

## Create matrices ====

# A matrix stores data in rows and columns, like a table
matrix(1:4, nrow = 2)
# nrow is an argument that tells matrix() how many rows there should be
matrix(c("a", "b"), nrow = 2)
# By default, matrix() fills in values from top to bottom. Choose to fill them from left to right using byrow argument
matrix(c(5, 4, 2, 3), byrow = TRUE, nrow = 2)
# To remember what's stored in the data, give rows and columns names
m <- matrix(c(19, 31), nrow = 1)
rownames(m) <- c("Age")
colnames(m) <- c("Ed", "Amy")
m #names are printed.

## Combining matrices ====

# You can do some useful calculations on matrices, like finding the sum of each row with rowSums() function
m <- matrix(c(20, 25, 26, 30), nrow = 2)
rowSums(m) #46 55
# colSums() function calculates the sum of each column
m <- matrix(6:11, nrow = 2)
colSums(m) #13 17 21
# rbind() stacks the rows from one matrix onto another
m <- matrix(1:3, nrow = 1)
n <- matrix(4:6, nrow = 1)
rbind(m, n)
# Similarly, cbind() function pastes the columns of two matrices together
a <- c("green", "blue") 
b <- c("red", "purple")
cbind(a, b)

## Subsetting matrices ====

# Like with vectors, use [] to select elements form a matrix
m <- matrix(1:6, nrow = 2)
m [1,2] #3
# Use slicing to select elements from a matrix
m <- matrix(1:9, byrow = TRUE, nrow = 3)
m[1:2, 2:3]
# To select all elements of a matrix row or column, leave out the number before or after the comman in []
m <- matrix(1:9, byrow = TRUE, nrow = 3)
m[,2]

## Arithmetic matrices ====

# Like with vectors, you can use the arithmetic oeprators element wise on matrices
m <- matrix(1:4, nrow = 2)
m * 2
# Or use oeprators on entire matrices
m1 <- matrix(1:3, nrow = 1)
m2 <- matrix(1:3, nrow = 1)
m1 ** m2
# mean() gives the average if akk values in a matrix
m <- matrix(1:4, byrow = TRUE, nrow = 2)
mean(m) #2.5


# FACTORS ####

## Intro to factors ====

# In R, factor vectors store categorical data that falls into finite number of categories. They're printed out without quote " "
v <- c("a", "b", "c")
factor(v)
# The levels of a factor are the possible categories, and are printed along with the data in alphabetical order
v <- c("red", "red", "blue")
factor(v)
# R automatically sets the levels of the factor in alphabetical order, which can be viewed with levels()
v <- c("y", "x", "z", "y")
f <- factor(v)
levels(f) #"x" "y" "z"
# Rename levels
v <- c("r", "b", "b")
f <- factor(v)
levels(f) <- c("blue", "red")
levels(f) #"blue" "red"
# When you change the levels of a factor, it also changes how the data is printed to use the new levels
v <- c("c", "d", "c")
f <- factor(v)
levels(f) <- c("cat", "dog")
f

## Summarizing categorical data ====

# Storing data in a factor can let you do useful things, like see the counts of each category with the summary() function
v <- c("a", "a", "b", "c")
f <- factor(v)
summary(f)
# You can subset a factor with []. The levels are still displayed
v <- c("x", "y", "z")
factor(v)[1]
# Strings can be compared alphabetically
"a" > "z" #FALSE
"ab" < "bc" #TRUE
# If factors have no ranking of levels, the comparison will result a NA and a warning
v <- c("a", "b")
f <- factor(v)
f[1] <f[2]

## Ordered factor ====

# R can't comapre factors without an implied order
v <- c("low", "high", "med")
f <- factor(v)
f[1] < f[2] #NA
# R represents ordinal variables as ordered factors, using the ordered argument to factor(). R orders alphabetically.
speed <- c("low", "high", "med", "med")
factor(speed, ordered = TRUE)
# To explicitly tell R the levels of a factor, add the levels argument to factor()
speed <- c("low", "high", "med", "med")
factor(speed, levels = c("low", "med", "high"))
# If you specify both order = TRUE and levels, R uses the order of levels
heights <- c("tallest", "short", "tall", "tall")
factor(heights, ordered = TRUE, levels = c("tallest", "tall", "short"))
# Now you can compare factors
v <- c("low", "high", "med")
f <- factor(v, ordered = TRUE, levels = c("low", "med", "high"))
f[1] < f[2] #TRUE
