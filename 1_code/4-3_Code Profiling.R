# 2. FINE TUNING

# R is flexible because you can often solve a single problem in many different ways. Some ways can be several orders of magnitude faster than the others.

# 2.1 Memory allocation ####
# There is no magic solution that will make your R code run faster. Instead, there are numbers of pitfalls you want to avoid.   
# When you assign a variable, R has to allocate memory in RAM, so an important way to make your code run faster is to minimize the amount of memory allocation R has to perform.
# Suppose you want to create a sequence of integers again. We know from benchmarking that the most obvious and fastest way is using a colon.
x <- 1:n
# Using a for loop is also not too bad.
x <- vector("numeric", n) # vector with length n.
for (i in 1:n) {          # loop to change the enter in the vector.
  x[i] <- i               # the length of x doesn't change in the loop.
}
# The final method is similar, but with one crucial exception. The object x starts empty and gradually fills it up with integers. 
x <- NULL   # length zero
for (i in 1:n) {
  x <- c(x, i)
}
# Benchmarking 3 methods above
library(microbenchmark)
n <- 1e8  
colon <- function(n) 1:n  # fastest
loop1 <- for (i in 1:n) { # not to bad        
  x[i] <- i
}
loop2 <- for (i in 1:n) {  # definitely not recommend.
  x <- c(x, i)
}
microbenchmark(colon(n), 
               loop1,
               loop2)
# Using the colon function, the operation happens so quickly, that even when n is 10 million, it takes less than a millisecond to execute. loop1 pre-allocates the vector that takes a few seconds longer, but not too bad. loop2 could turn to almost unusable, because the code requests for more memory. 
# First rule in R: never grow a vector! To illustrate this rule, write the growing() that generates n random standard normal numbers, but grow the size of the vector each time an element is added. 
# standard normal numbers are numbers drawn from a normal distribution with mean 0 and standard deviation 1.
n <- 30000
growing <- function(n) {
  x <- NULL
  for(i in 1:n)
    x <- c(x, rnorm(1)) 
  x
}
# Use system.time() to find out how long it takes to generate n:
system.time(res_grow <- growing(n)) # slow for such a small vector.
# How long does it take when we pre-allocate the vector? Write a function to measure it:
pre_locate <- function(n) {
  x <- numeric(n)
  for (i in 1:n)
    x[i] <- rnorm(1)
  x
}
# Run system.time() again:
system.time(res_allocate <- pre_allocate(n))
# Pre-allocating the vector is significantly faster than growing the vector! 

# 2.2 Vectorizing code ####
# When we call an R function we eventually call some C or FORTRAN code. The underlying code is heavily optimized. The general goal is to access this underlying code as quickly as possible; the fewer function calls, the better. This usually means vectorizing code.
# Many functions in R are vectorized, e.g:
rnorm(4) # take a number, but returns a vector.
# Other functions take a vector and return a single value.
mean(c(36, 48))
# Generate a million random numbers from the standard distribution:
n <- 1e6
x <- vector("numeric", n)
# Compare with the pre-allocate method:
microbenchmark(
  x <- rnorm(n),
  {
    for(i in seq_along(x))
      x[i] <- rnorm(1)
    },
  times = 10)
# The vectorized version of rnorm() is around 40 times faster. That's because the for loop generates one million calls to rnorm(), but the vectorized solution we only need one assignment.
# Second rule in R code: use a vectorized solution wherever possible.
# Vectorized code: multiplication
x <- rnorm(10)
x2  <- numeric(length(x))
for(i in 1:10)
  x2 <- x[i] * x[i]
# This can be simply rewritten with a vectorized code.
x2_imp <- x ^ 2
# A common operation in statistics is to calculate the sum of log probabilities.
total <- 0
x <- runif(n)
for (i in 1:n)
  total <- total + log(x[i])
# Rewrite the code:
sum(log(x))
# log() can take in a vector and outputs a vector. sum() takes in a vector and returns the sum of all the values in the vector. 

# 2.3 Data frames and matrices ####
# The key data structure in R is a data frame. A data frame is a tabular structure for representing the data. Technically, columns are variables of interest and rows are observations. A column in a data frame must be the same type. In other word, a data frame is a list of of vectors where each column is a single vector. This means accessing columns is easy, we just find the location of the column and retrieve the entire object. 
# Retrieving rows is more difficult. You'll need to find the starting location of every single column and then select what you need. 
# A matrix is similar to a data frame. It has rectangular data structure. You can also perform usual subsetting and extracting operations. The crucial difference is every element in a matrix must be the same data. Selecting rows in a matrix is much easier than in a data frame.
# Third rule in R: use a matrix when possible.

# Create a matrix of randowm number:
mat <- matrix(rnorm(10000), nrow = 100)
# Make a data frame from this matrix:
df <- data.frame(mat)
# Benchmarking mat and df: column selection
microbenchmark(mat[ ,1], df[ ,1])
# Benchmarking mat and df: row selection
microbenchmark(mat[1, ], df[1, ])
# Accessing a row of a data frame is much slower than accessing that of a matrix, more so than when accessing a column from each data type. This is because the values of a column of a data frame must be the same data type,