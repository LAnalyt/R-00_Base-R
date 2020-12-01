# 3. FUNCTIONS

# 3.1 Introduction to functions ####

# Create a list: list()
# Display a variable: print()
# Call sd() function for standard deviation:
sd(c(1, 5, 6, 7))  # specify function arguments inside (). 
# Assign the input vector to a variable, then call sd() function:
values <- c(1, 5, 6, 7)
sd(values)         # same result.
# Assign the result of the function to a variable to reuse it:
my_sd <- sd(values)

# Function documentation:
help(sd)  # or
?sd       # look up in the function documentation for more info.
# The syntax of sd() could be found in the help page.
sd(x, na.rm = FALSE) 
# R matches the values to the x argument by position or by name.
sd(x = values)
# na.rm argument is a logical value indicating whether or not missing values should be removed. 
values <- c(1, 5, 6, 7, NA)
sd(values) # NA.
# set na.rm argument to TRUE.
sd(values, TRUE) # or matching by name.
sd(values, na.rm = TRUE)
# sd() will return an error if there's no argument is specified
sd() # argument "x" is missing, with no default.

# args(): to learn about the arguments of a function without having to go through the entire document.
args(sd) # before using an R function, you should clarify which arguments it expects.
# Consult the documentation on the mean():
?mean
args(mean)  # inspect the arguments.
 
# Continue with the exercise on the views on social media:
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
# Calculate average number of views:
(avg_lin <- mean(linkedin))
(avg_fb <- mean(facebook)) # put the variable inside the parentheses will print it out in the console.
# Calculate the mean of the sum:
(avg_sum <- sum(mean(linkedin), mean(facebook)))
# Using trim argument to reduce the decimal ending:
(avg_trimmed <- mean(linkedin + facebook, trim = 0.2)) # the use of a trimmed mean helps eliminate the influence of outliers or data points on the tails that may unfairly affect the traditional mean.
# Suppose there are missing values in the view record:
linkedin <- c(16, 9, 13, 5, NA, 17, 14)
facebook <- c(17, NA, 5, 16, 8, 13, 14)
# To calculate the average view using mean(), set na.rm() = TRUE:
mean(linkedin, na.rm = TRUE)
# Calculate the mean absolute function:
mean(abs(linkedin - facebook), na.rm = TRUE) # Functions inside functions!

# 3.2 Writing functions ####

# A function typically serves a particular need or solves a particular problem, without having to care about how the function does this. R allows to write your own function and use it as a standard function like sd(), mean()...
# The syntax for writing a function:
my_func <- function(arg1, arg2) { # create a new function
  body  # create a function that takes arguments arg1 and arg2.
}       # performs the code in the body on these arguments.

# Define a function that calculates the triple of its input, called triple:
triple <- function(x) { # x represents input as a number
  3*x                   # calculates the triple of x.
}
# Check if the new object is already defined in the workspace
ls() # list the object "triple".
# Calculate the triple of 6:
triple(6) # numeric 6 matched to argument(x).
          # function body is executed: 3 * 6.
          # last expression evaluated becomes the return value.

# return() statement: explicitly specify the return value.
triple <- function(x) {
  y <- 3*x
  return(y)
}         # returns the same result.
# Using a return statement at the end of the function is not always useful, but there are other cases where it becomes handy.

# Write a function called math_magic() that takes 2 numbers as input and calculates the sum of the product and the division of both numbers:
math_magic <- function(a, b) {
  a*b + a/b
}
# Sourcing the new function with numbers 4 and 2:
math_magic(4,2) 
# What happens if the input has only one argument?
math_magic(4) # error, because b is missing with no default.
# Making the second argument optional:
math_magic <- function(a, b = 1) { # adding default value.
  a*b + a/b
}
# Sourcing the function again:
math_magic(4) # 8, because argument b is not specified, R set it to default value that equals 1.
# Call math_magic() with numbers 4 and 0:
math_magic(4,0) # result is Inf, or infinity, because 4/0 = inf
# Extend the function with an if-return statement to guard the function against this misuse:
math_magic <- function(a, b = 1){
  if(b == 0){
    return(0)
  }
  a*b + a/b
}
# Recall the function again:
math_magic(4,0) # return statement can halt the execution anytime.

# Create a function that takes 2 arguments and returns the sum of the absolute values of both arguments:
sum_abs <- function(a, b){
  abs(a) + abs(b)
}
sum_abs(-2, 3)

# There are situations in which the function does not require an input. E.g, write a function that gives the random outcome of throwing a fair die:
throw_die <- function(){
  number <- sample(1:6, size = 1)
  number
}
throw_die()

# Define a function without argument that prints out "Hi there!" and returns TRUE:
hello <- function(){
  print("Hi there!")
  return(TRUE)
}
hello()


# Create a function that takes one argument and returns that number squared:
power_two <- function(x){
  x^2
}
# Add an optional argument named print_info, that is TRUE by default and and if statement:
power_two <- function(x, print_info = TRUE){
  y <- x^2
  if(print_info){
    print(paste(x, "to the power two equals", y))
  }
  return(y)
}
# Call the newly defined function with different inputs:
power_two(5) 
power_two(5, FALSE)
power_two(5, TRUE)

# Function scoping: variables that are defined inside a function are not accessible outside that function.
two_dice <- function(){
  possibilities <- 1:6
  dice1 <- sample(possibilities, size = 1)
  dice2 <- sample(possibilities, size = 1)
  dice1 + dice2
} # whatever the way of calling the two_dice(), R won't have the access to dice1 and dice2 outside of the function.

# Continue the exercise with the record of social media views in linkedin and facebook. Write a function that interprets the view of a singe record day: 
interpret <- function(num_views) {
  if(num_views > 15) {
    print("You're popular!")
    return(num_views)
  } else {
    print("Try to be more visible!")
    return(0)
  }
}
interpret(linkedin[1])
interpret(facebook[2])
# Now write a function that interprets all the data from the daily views. Make return_sum an optional argument that is TRUE by default.
interpret_all <- function(views, return_sum = TRUE) {
  count <- 0
  for (v in views) {  # for loop is ideal for iterating elements.
    count <- interpret(v) + count
  }
  if (return_sum) {
    return(count)
  } else {
    return(NULL)
  }
}
interpret_all(linkedin)
interpret_all(facebook)

# 3.3 Anonymous functions ####

# Functions in R are objects in their own right. This means that they aren't automatically bound to a name. When you create a function, you can use the assignment operator to give the function a name. It's perfectly possible, however, to not give the function a name. This is called an anonymous function:
# Named function
triple <- function(x) { 3 * x }
# Anonymous function with same implementation:
function(x) { 3 * x }
# Anonymous functions are helpful when you need to use the function only once, avoid defining it with a name. 