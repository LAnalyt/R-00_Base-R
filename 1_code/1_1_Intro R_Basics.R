# INTRO TO BASICS

# 1.1 Arithmetic with R####

# In its most basic form, R can be used as a simple calculator
#Addition: +
5 + 5 
#Subtraction: -
5 - 5 
#Multiplication: *
3 * 5 
#Division: /
(5+5)/2 
#Exponentiation: ^ (raise the power)
2^5 
#Modulo: %% (returns the remainder of the division)
28%%6 

#2.2 Variable assignment####

#A variable stores a value or an object (e.g. a function description). 
#You can then later use this variable's name to easily access the value or the object that is stored within this variable.
# Assign the value 23 to my_var
my_var <- 23
# Print out the value of my_var
my_var 
# Suppose you have a fruit basket. Store the number of apples in a variable
my_apples <- 5
# Add 6 oranges into the basket and store the new variable 
my_oranges <- 6
# Calculate how many pieces of fruits in total
my_apples + my_oranges
# Assign the result to a new variable my_fruit
my_fruit <- my_apples + my_oranges
# See how many pieces of fruits in total
my_fruit

# 3.3 Basic data types in R ####

# Decimal values like 4.5 are called numerics
# Natural numbers like 4 are called integers. Integers are also numerics.
# Boolean values  (TRUE or FALSE) are called logical 
# Text or string values are called characters
# E.g, change my_numeric to be 42
my_numeric <- 42
# Change my_character to be "universe"
my_character <- "universe"
# Change my_logical to be "FALSE"
my_logical <- FALSE
# Check the data type of a variable with class function
class(my_numeric)
class(my_character)
class(my_logical)
