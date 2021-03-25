# 3. DIAGNOSING PROBLEMS

# In many applications, there is usually a rate limiting selection of code. Essentially a bottle neck that slows down the overall speed of execution. Profiling helps you locate the bottlenecks in your code. 

# 3.1 Code profiling ####
# The general idea of code profiling is simple. You run your code and take snapshots of what program is doing at regular intervals. This gives the data how long each function took to run.  
# rprof(): the built-in tool for code profiling, but it's not usef-friendly.
# Install and load ggplot2movies package for this experiment. 
install.packages("ggplot2movies")
library(ggplot2movies)
data(movies)
dim(movies) # idmb dataset with around 60000 rows and 24 columns. 
# Each row corresponds to a movie, e.g, retrieve the data for "Braveheart":
braveheart <- movies[7288, ]
braveheart # rating 8.3.
# Compare the rating of "Braveheart" with other action movies: first extract the Action movies from the dataset. 
movies <- movies[movies$Action == 1, ]
# Next generate a scatter plot of year against movies:
plot(movies$year, movies$rating,
     xlab = "Year", ylab = "Rating")
# Fit a local regression line to get an idea of the trend:
model <- loess(rating ~ year, 
               data = movies)
j <- order(movies$year)
lines(movies$year[j],
      model$fitted[j],
      col = "blue")
# Plot the point of "Braveheart" to highlight it:
points(braveheart$year,
       braveheart$rating, 
       pch = 21,
       bg = "red")
# Base plot might be too simple and ggplot2 is more popular. The downside is that when we ggplot, its call stack is complicated. So for this particular case we keep things simple.
# In RStudio: select the code you want to profile > Profile > Profile Selected Line(s).

# 3.2 profvis ####
# Alternative is the profvis package.
install.packages("profvis")
library(profvis)
# Use profvis function and pass all the profiled code in {}:
profvis ({
  data(movies)
  dim(movies) 
  braveheart <- movies[7288, ]
  movies <- movies[movies$Action == 1, ]
  plot(movies$year, movies$rating,
       xlab = "Year", ylab = "Rating")
  model <- loess(rating ~ year, 
                 data = movies)
  j <- order(movies$year)
  lines(movies$year[j],
        model$fitted[j],
        col = "blue")
  points(braveheart$year,
         braveheart$rating, 
         pch = 21,
         bg = "red")
})
# This script generates an interactive page that describes the amount of time we spend on each line of code. The two measurements returned by profvis() are memory used in Mb and time in milliseconds. 

# Examine the code for standard analysis of the idmb movies dataset:
data(movies)
profvis({
  comedies <- movies[movies$Comedy == 1, ] # load and select data
  plot(comedies$year, comedies$rating)    # plot data of interest
  model <- loess(rating ~ year, data = comedies) # loes regression line
  j <- order(comedies$year)
  lines(comedies$year[j], model$fitted[j], col = "red") # add fitted line
})

# 3.3 Profvis: larger example ####
# Suppose you write code to simulate a dice game with two dices:
df <- data.frame(d1 = sample(1:6, 3, replace = TRUE),
                 d2 = sample(1:6, 3, replace = TRUE))
# This can be optimized by switching the data frame with a matrix that generates the 6 dice rolls in a single steps.
m <- matrix(sample(1:6, 6, replace = TRUE),
            ncol = 2)
# Benchmarking the two functions to see the improvement:
library(microbenchmark)
d <- function() {
  data.frame(
    d1 = sample(1:6, 3, replace = TRUE),
    d2 = sample(1:6, 3, replace = TRUE)
  )
}
m <- function() {
  matrix(sample(1:6, 6, replace = TRUE),
         ncol = 2)
}
microbenchmark(
  data.frame_solution = d(),
  matrix_solution = m()
) # Switching to a matrix can save valuable seconds. 
# To calculate row sums in a matrix, R also provides rowSums(). Compare this function with a normal apply():
rolls <- matrix(sample(1:6, 6, replace = TRUE), 
                ncol = 2)
app <- function(x) {
  apply(x, 1, sum)
}
r_sum <- function(x) {
  rowSums(x)
}
microbenchmark(
  apply = app(rolls),
  rowSums = r_sum(rolls)
) # almost twice faster with rowSums()!

# The "&" operator will always evaluate both its arguments. That is, if you type x & y, R will always try to work out what x and y are. There are some cases where this is inefficient. E.g, if x is FALSE, then x & y will always be FALSE, regardless of the value of y. Thus, you can save a little processing time by not calculating it. The "&&" operator takes advantage of this trick, and doesn't bother to calculate y if it doesn't make a difference to the overall result.
# Example data:
is_double <- c(FALSE, TRUE, TRUE)
# is_double[1] is FALSE and we don't need to evaluate is_double[2] or is_double, so we can get a speedup by swapping & for &&.
# Benchmark these two solutions:
a <- function(is_double) {
  if(is_double[1] & is_double[2] & is_double[3]) {
    next
  }
}
b <- function(is_double) {
  if(is_double[1] && is_double[2] && is_double[3]) {
    next
  }
}
microbenchmark(a, b, times = 1e5) # && is slightly faster.
# "&&" only works on single logical values, i.e., logical vectors of length 1 (like you would pass into an if condition), but "&" also works on vectors of length greater than 1.
