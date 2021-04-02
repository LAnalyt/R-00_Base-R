# 4. TURBO CHARGED CODE

# Some problems can be solved faster using multiple cores on your machine. 

# 4.1 CPU ####
# The CPU is the brain of the computer. The faster the computer, the faster your code will run. Computer manufactures have moved from making very fast single core machine to multi-core machines to solve the heating problem. But R is still single threaded. By default, R uses only one single core.  
# parallel package allows parallel computing in R.
install.packages("parallel")
library(parallel)
# First investigate the CPU of your own hardware:
detectCores()
# The benchmarkme package extends this information with get_cpu().
library(benchmarkme)
get_cpu()

# 4.2 parallel computing ####
# The vast majority of statistical methods haven't been designed with parallel computing. 
# What type of problem can exploit multi-core CPUs? Suppose you want to perform 8 Monte-Carlo simulations. The standard way is to construct a loop, and at each iteration you simulate a realization of the process.
for (i in 1:8)
  sims[i] <- monte_carlo()
# With a 8 core CPU, each core would simulate a single realization. Once all the cores are finished, combine the result:
combine(sims)
# This is the easiest type of parallel since little effort is needed to separate the problem into separate tasks.
# Consider another for loop:
x <- 1:8
for (i in 2:8) 
  x[i] <- x[i-1] # all the values of the vector x are equal to 1.
# In parallel computing we can't guarantee the order of operations, so even with an 8 core CPU, we can't run this loop.
# To determine if a loop can be run in parallel is to think about running the loop backwards.
for (i in 8:1)
  sims[i] <- monte_carlo() # still got the same result.
for (i in 8:2) 
  x[i] <- x[i-1] # the calculation is wrong.

# E.g, a code implementation for a simple dice game:
total <- no_of_rolls <- 0 # initialize
while (total < 10) {
  total <- total + sample(1:6, 1)
  if (total %% 2 == 0) total <- 0 # if even, reset to 0
  no_of_rolls <- no_of_rolls + 1  
}
# This algorithm is a sequential algorithm and cannot be easily run in parallel. The i value depends on the previous value.
# Wrap the code in a function and construct a loop to play the dice game:
play <- function() {
  total <- no_of_rolls <- 0
  while(total < 10) {
    total <- total + sample(1:6, 1)
    if(total %% 2 == 0) total <- 0  # if even, reset to 0.
    no_of_rolls <- no_of_rolls + 1
  }
  no_of_rolls
}
results <- numeric(100)
for(i in seq_along(results)) 
  results[i] <- play()
# This for loop can be easily run in parallel because the game can be simulated in any order.

# 4.3 parallel package ####
# The parallel package has also parallel versions of standard functions in R, e.g create a matrix of random numbers:
m <- matrix(rnorm(10000), ncol = 10)
# Calculate the median value of every row:
res <- apply(m, 1, median) # 1 indicates rows, 2 for columns.
res
# Specify the number of cores:
copies_of_r <- detectCores() 
# Make a cluster object. This creates copies of R running in parallel.
cl <- makeCluster(copies_of_r)
# Swap apply() with its parallel counterpart parApply():
parApply(cl, m, 1, median)
# Finally we close the cluster:
stopCluster(cl)
# Similarly for sapply() we can run parSapply in paralel. sapply() is just another way to write for loops, by applying a function to each value of vector.
for (i in 1:10)
  x[i] <- simulate(i)
# can be wrtitten as:
sapply(1:10, simulate) 
# In general there is little speed difference between a sapply() and a standard loop, but using sapply() makes the code much neater.
# parSapply() in parallel has the same routine: load package -> create the cluster -> change to parSapply -> close the cluster.
# Simulate a simple dice game with a function:
play <- function() {
  total <- no_of_rolls <- 0
  while(total < 10) {
    total <- total + sample(1:6, 1)
    if(total %% 2 == 0) total <- 0  # if even, reset to 0.
    no_of_rolls <- no_of_rolls + 1
  }
  no_of_rolls
}
# Create a cluster: 
cl <- makeCluster(detectCores())
# Export the play() function to the cluster:
clusterExport(cl, "play")
# Now timing sapply() and parSapply() to compare:
# Set the number of games to play:
no_of_games <- 1e5
system.time(serial <- sapply(1:no_of_games, function(i) play()))
system.time(par <- parSapply(cl, 1:no_of_games, function(i) play()))
# Stop the cluster:
stopCluster(cl)