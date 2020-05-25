# 3. FUNCTIONS

# 3.1 Introduction to functions ##################################

# Create a list: list()
# Display a variable: print()
# Blac-
# Call sd() function for standard deviation
sd(c(1, 5, 6, 7))  # specify function arguments inside () 
# Assign the input vector to a variable, then call sd() function
values <- c(1, 5, 6, 7)
sd(values)         # same result, 2.629956
# Assign the result of the function to a variable to reuse it
my_sd <- sd(values)

# Function documentation
help(sd)  # or
?sd       # look up in the function documentation for more info.
# The syntax of sd() could be found in the help page
sd(x, na.rm = FALSE) 
# R matches the values to the x argument by position or by name
sd(x = values)
# na.rm argument is a logical value indicating whether or not missing values should be removed. 
values <- c(1, 5, 6, 7, NA)
sd(values) #NA
# set na.rm argument to TRUE
sd(values, TRUE) # or matching by name
sd(values, na.rm = TRUE)
# sd() will return an error if there's no argument is specified
sd() # argument "x" is missing, with no default

# args() function: to learn about the arguments of a function without having to go through the entire document.
args(sd) # before using an R function, you should clarify which arguments it expects.
# Consult the documentation on the mean() function
?mean
args(mean)  # inspect the arguments.
 
# Continue with the exercise on the views on social media
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
# Calculate average number of views
(avg_lin <- mean(linkedin))
(avg_fb <- mean(facebook)) # put the variable inside the parenthese will print it out in the console.
# Calculate the mean of the sum
(avg_sum <- sum(mean(linkedin), mean(facebook)))
# Using trim argument to reduce the decimal ending
(avg_trimmed <- mean(linkedin + facebook, trim = 0.2)) # the use of a trimmed mean helps eliminate the influence of outliers or data points on the tails that may unfairly affect the traditional mean.
# Suppose there're missing values in the view record
linkedin <- c(16, 9, 13, 5, NA, 17, 14)
facebook <- c(17, NA, 5, 16, 8, 13, 14)
# To calcuate the average view using mean(), set na.rm()=TRUE
mean(linkedin, na.rm = TRUE)
# Calculate the mean absolute function
mean(abs(linkedin - facebook), na.rm = TRUE) # Functions inside functions!