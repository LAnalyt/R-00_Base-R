# R BASICS ####

## Basic arithmethic ====
# R uses +, -, * like a calculator.
8 - 5 #3, [1] marks the start of R's output, not part of the result # Use / to divide
6 / 3 #2
# Like on a calculator, parenthese can be used to priotirize calculations
(1 + 2) * 3 #9
# ^ and ** are exponential operators
7 ^ 2 #49
# The modulo operator %% returns the remainder of a division
7 %% 2 #1
(7 %% 4) ^ 2 #9

## R variables ====
# Variables allow you to store values for later use
age <- 23
age #23
# To output the vaue of a variable to the screen, type the variable name
pi <- 3.14
# output pi
pi
# Store a value in a variable is called assignment. Value must be assigned to a variable before it could be used
x <- 400
x #400
# Variables can be used in operations everywhere
# IF a new value is assigned to an existing variable,it will replace the previous value
age <- 17
age <- 18

## Data types ====
# Every value has a data type, which classifies the value. 
# Letters and words like "r", "data" in quote are called strings, and have the character data type.
# Use class( ) function to get the data type of a value or a variable
class("HelloWorld") # "character"
x <- "5"
class(X) #since the number is in quote "", its data type belongs to "character"
# Integers (whole numbers) and numbers with decimal places have the numeric data type
n <- 3.14
class(n) #"numeric"
# Boolean values represent something is true or false. They have logical data type, and have to be written in uppercase.
class(TRUE) #"logical"

# VECTORS ####

## Creating vectors ====
# Store multiple values with c( ) function, combining the elements separated by commas into a vector
c(1, 2, 3) #R prints the elemnts in a vector separated by spaces. The [1] is not part of the vector, it's only part of how R displays it.
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
v #note that when vector has a name, R doesn't print [1]
values <- c(5, 3, 1)
titles <- c("x", "y", "z")
names(values) <- titles
values

# Performing calculations with vectors ====
# You can do arithmatic when creating vectors, and the results will be stored in the vector.
v <- c(1+1, 2+2, 3+3) #2 4 6 
# Add 2 vectors with +, R will add the elements of the vectors element-wise.
a <- c(1, 2, 3)
b <- c(4, 5, 6)
a + b  #5 7 9
# You can also store the result in a new vector
c <- a + b
c #5 7 9
# Use sum( ) to take the sum of everything in the vector
v <- c(5, 5, 10)
sum(v) #20

## Subsetting vectors ====
# You can pinpoint an element in a vector by its index in [ ]
v <- c(4, 9, 1, 5, 3)
v[1] #4
# You can also get multiple elements from a vector by putting a vector of indices within the brackets
v <- c(4, 9, 1, 5, 3)
v[c(1, 3)] #the elements you select correspond directly to the indices you use, in whatever order you specify.
# You can save the results of subsetting a vector as a new vector
a <- c("red", "orange", "yellow")
b <- a[c(1, 3)]
b #"red" "yellow"
# Shortcut for creating a vector of sequential integers: typing 1:5 will create a vector of values 1 2 3 4 5. You can also use ":" syntax to subset a range of elements in a vector
v <- c(2, 3, 4, 6, 8, 10)
v[2:4] #3 4 6
# You can also subset a vector using its name
v <- c(1.1, 2.2, 3.3)
names(v) <- c("Bob", "Joy", "Rex")
v["Bob"] #Bob 1.1
# mean( ) calculates the sum of the elements divided by how many there are
v <- c(5, 2, 5)
mean(v) #4

## Comparing values in vectors ====
# R has comparison operators:
# ==: check if one value is equal to another
# !=: check if one value is not equal to another
# <: check if one value is smaller than another
# <=: check if one value is smaller than or equal to another
# >: check if one value is greater than another
# >=: check if one value is greater than or equal to another
# When you compare two numbers or strings, you et a Boolean
5 > 3 #TRUE
4 == 5 #FALSE
"orange" != "yellow" #TRUE
# You can use these comparison operators to compare each element in a vector to some other value
v <- c("cat", "dog", "hamster")
v == "cat" #TRUE FALSE FALSE
# You can also save the result of a comparison as a Boolean vector!
v <- c(2, 4, 3, 9, 10)
comp <- v < 7
comp #TRUE TRUE TRUE FALSE FALSE
# Subset using Boolean
v <- c("small", "large", "huge")
big <- v != "small"
big #FALSE TRUE TRUE
v[big] #"large" "huge"