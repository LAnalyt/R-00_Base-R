# 5. THE APPLY FAMILY

# 5.1 The Lapply ####

# When using R, you will encounter vectors and lists containing all sorts of information. We could use for loop to iterate over all kinds of data structures. But there's even an easier way with Lapply.
# Reconstruct again the previous list example
nyc <- list(pop = 8405837, 
            boroughs = c("Manhatten", "Bronx", "Brooklyn", "Queens",                          "Staten Islands"), 
            capital = FALSE)
# Suppose you want to find out the class of each element in this list
for(info in nyc) {
  print(class(info))
}
# The for loop is, however, a long code just to find out the class of the elements in the list. Instead we could use lappy()
lapply(nyc, class)

# Another example with city names
cities <- c("New York", "Paris", "London", "Tokyo", "Rio de Janiero", "Cape Town")
# Suppose we want to build a vector of the same length, containing the number of characters of each city name.
num_chars <- c() # create an empty vector
for(i in 1:length(cities)) { # using loop index
  num_chars[i] <- nchar(cities[i]) #use nchar() function
}
num_chars # we got the result, but it's a lot of code.
# Refactoring this code using lapply() is easy
lapply(cities, nchar) # result a list containing the number of characters of the corresponding cities in the input vector.
# Lapply always returns a list, irrespective of the input data structure. By using lapply, the code looks much more intuitive and readable.

# Lapply can also be used not just with default functions but customized functions.
# Assume we have a list of oil prices per gallon
oil_prices <- list(2.37, 2.49, 2.18, 2.22, 2.47, 2.32)
# Write a function that triples every element of oil_prices
triple <- function(x) {
  3 * x
}
# Apply this triple function on each element using lapply()
lapply(oil_prices, triple)
# Try to make this triple function more generic
multiply <- function(x, factor) { # use an additional argument
  x * factor
}  # we can now choose which factor to multiply the input.
# Use multiply inside the lapply function
lapply(oil_prices, multiply, factor = 4)

# To put it generally, lapply takes a vector or a list x, and applies a specified function to its members. If the function requires additional arguments, it could be passed inside the lapply() function
lapply(x, FUNC, ...) # syntax lapply
# The output of lapply() is a list, where each element is the result of appply FUNC on the corresponding element of X.

# Create a vector or ramous mathematicians/statisticians and the year they were born
pioneers <- c("GAUSS:1777", "BAYES:1702", "PASCAL:1623", "PEARSON:1857")
# Split names from birth year using strplit() fucntion
split_math <- strsplit(pioneers, split = ":") # split the strings on the : sign.
# Convert to lowercase strings using tolower() function
split_low <- lapply(split_math, tolower) 
# Inspect the contents of split_low
str(split_low) # names are in converted to lowercase now.
# Now write new functions that allows to select the names and the years separately
select_first <- function(x){
  x[1]
}
select_second <- function(x){
  x[2]
}
# Apply the new functions
names <- lapply(split_low, select_first)
years <- lapply(split_low, select_second)
# Or generic select function
select_el <- function(x, index) {
  x[index]
}
# Use lapply() with additional arguments
names <- lapply(split_low, select_el, index = 1)
years <- lapply(split_low, select_el, index = 2)

# 5.2 The Sapply ####

# Using the cities example again, lapply() returns a list, although the result could fit nicely into a vector. There's an easier way to tackle the case in which all the results have the same type by using sapply()
sapply(cities, nchar) # short for "simplified apply"
# Under the hood, something more complex is going on:
# sapply calls lappy to apply the nchar function over each element of the cities vector.
# Then it uses the simplify2array function to convert that list lapply generated to an array.
# The sapply in the this case converts the result to a one dimensional array, which is a vector. 

# Sapply even found a sensible way of naming this vector. This argument could be turned off
sapply(cities, nchar, USE.NAMES = FALSE) # TRUE by default.

# What happens if the function you want to apply over the input, each time returns a vector containing two values instead of one?
first_and_last <- function(name) {
  name <- gsub(" ", "", name)
  letters <- strsplit(name, split = "")[[1]]
  c(first = min(letters), last = max(letters))
} # the written function splits up a string to its letters, and returns the minimum and maximum letter according to the alphabetial order.
first_and_last("New York")
# Use this function for every city name in cities
sapply(cities, first_and_last) # the result is now a matrix.

# What if this simplification is not possible?
# There are cases in which the function does not always return a vector of the same length at all times. For this case, simplification to a vector or a matrix just doesn't make sense.
# Write a function that returns a vector of all the letters that are used inside a character string
unique_letters <- function(name) {
name <- gsub(" ", "", name)
letters <- strsplit(name, split = "")[[1]]
unique(letters)
} 
unique_letters("London") #  returns a vector containing the unique letters in "London".
# First see how  the cities behave on your function
lapply(cities, unique_letters) # returns a list of vectors with different length.
# Trying to simplify this list could lead to strange result
sapply(cities, unique_letters) # also returns a list because R couldn't think of a meaningful way of symplifying the  
