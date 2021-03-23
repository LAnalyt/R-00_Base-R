# 1. BENCHMARKING

# R has the unfortunate reputation for being slow, compared in raw speed with other programming languages like C++, Java...etc But the total programming time is made up of 3 components: thinking, coding and running. In many statistical analyses, we want to try multiple methods and optimize the thinking and coding parts. 

# A typical R workflow:
# Load
data_set <- read.csv("dataset.csv")
# Plot
plot(data_set$x, data_set$y)
# Model
lm(y ~ x, data = data_set)
# We use R because it's good with statistics.

# 1.1 Optimization ####
# Simple and first optimization: always keep R up-to-date. New versions of R often provide speed boots, such as improved handling data frames, so your code goes a bit faster.
# "version" command: returns a list that contains the major and minor version of R currently being used.
version # version is not a function.
# Extract the major component of version:
version$major
# Extract the minor component of version:
version$minor

# 1.2 Benchmarking ####
# Benchmarking is a 2-step process:
# Step 1: construct a function around the feature we wish to benchmark.
# Step 2: time the function under different scenarios.

# E.g, suppose you want to generate a sequence of integers 1, 2, 3..., n. There are 3 obvious ways to do it:
# Option 1:
1:n
# Option 2:
seq(1, n)
# Option 3
seq(1, n, by = 1) # explicitly specify the step size.
# Wrap the options in functions and allow the sequence length n, to be passed as an argument:
colon <- function(n) 1:n
seq_default <- function(n) seq(1, n)
seq_by <- function(n) seq(1, n, by = 1)
# Wrap the functions with system.time() to determine how long the function takes to run:
system.time(colon(1e8))
system.time(seq_default(1e8))
system.time(seq_by(1e8)) # this function is the slowest.
# Running these codes produces 3 numbers: user, system, and elapsed time.
# user: CPU time charged for the execution of user instructions.
# system: CPU time charged for the execution by the system on behalf of the calling process.
# elapsed: approximately the sum of user and system. This is the number we typically care about. 

# Store the result from system.time():
res <- colon(1e8)
# The "<-" operator performs 2 tasks: argument passing and object assignment, which allow us to store both time and the operation.
system.time(res <- colon(1e8))
# The = operator only perform either argument passing or object assignment. 
system.time(res = colon(1e8)) # return an error.
# Along with elapsed time, it also worths considering relative time, which is a ratio between elapsed time and the absolute time.

# One of the most common tasks we perform is reading in data from CSV files. However, for large CSV files this can be slow. One neat trick is to read in the data and save as an R binary file (rds) using saveRDS(). The files "movies.csv" and "movies.rds" both contain identical data frames with information on 45,000 movies. Benchmark the 2 approaches to see how long it takes to read the file:
system.time(read.csv("movies.csv"))
system.time(readRDS("movies.rds")) # Reading in RDS files are much quicker than reading in CSV files.

# 1.3 Microbenchmark package ####
# The microbenchmark package is a wrapper around system.time and makes it straightforwards when comparing multiple functions. 
install.packages("microbenchmark")
library(microbenchmark)
# Compare 3 functions above:
n <- 1e8
microbenchmark(colon(n), 
               seq_default(n),
               seq_by(n),
               times = 10) # run each function 10 times.
# The "cld" column provides a statistical ranking of functions. The colon() is apparently the fastest one. 
# Using microbenchmark to compare the 2 approaches for reading the movies file:
microbenchmark(read.csv("movies.csv"),
               readRDS("movies.rds"),
               times = 10) # import rds file is clearly faster.

# 1.4 Benchmarkme package ####
# The benchmarkme package aims to compare the performance of difference machines on the same code.
install.packages("benchmarkme")
library(benchmarkme)
# The main function of the package is benchmark_std(). These benchmarks are standard R operations such as loops and matrix operations.
res <- benchmark_std(runs = 3)
# Once the benchmark has completed, you can upload the results and compare with other users.
plot(res)
upload_results(res)
# Sometimes having a faster computer will solve the problem. Measuring the performance of your computer is called benchmarking.
# Obtain the amount of RAM on this machine:
get_ram()
# Obtain the CPU specifications:
get_cpu()
# One set of benchmarks tests is reading and writing speeds.
res <- benchmark_io(runs = 1, size = 5)
# Compare to other users:
plot(res)