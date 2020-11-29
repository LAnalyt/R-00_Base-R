# 2. LOOPS

# 2.1 While loop ####

# While loop is similar to if statement because it executes the code inside if the condition is TRUE. However, as opposite to if statements, the while loop will continue to execute the code over and over again as long as the condition is true.
while (condition) {
  expression
}
# Make R increment a counter until it reaches the value 7:
ctr <- 1 # start by defining ctr, short for counter
while (ctr <= 7) {   
  print(paste("ctr is set to", ctr)) # print out the value of ctr.
  ctr <- ctr + 1 # add an increment on every run.
} # no printout after 7th run.
# paste() converts its input to character strings and concatenates them.
# Without "ctr <- ctr + 1" the code will run infinitely.
# Always make sure the while loop ends at some point.

# Break statement: simply break out of the while loop. When R find it, it abandons the currently active while loop.
while (ctr <= 7) {
  if (ctr %% 5 == 0) {
    break # R stops the loop as soon as ctr is divisible by 5.
  }
  print(paste("ctr is set to", ctr))
  ctr <- ctr + 1
} # no printout after 4th run.

# Initialize a variable for speed:
speed <- 64
# Create a while loop that controls the speed:
while (speed > 30) {
  print(paste("Slow down!"))
  speed <- speed - 7
} # no printout after speed reaches 29.
# Extend/adapt the while loop to make the driver's assistance more advanced:
while (speed > 30) {
  print(paste("Your speed is", speed))
  if (speed > 40) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}
# There are some very rare situations in which severe speeding is necessary. Add a break in the while loop:
speed <- 88
while (speed > 30) {
  print(paste("Your speed is", speed))
  if (speed > 80) {
    break
  }
  if (speed > 48) {
    print("Slow down big time!")
    speed <- speed - 11
  } else {
    print("Slow down!")
    speed <- speed - 6
  }
}

# 2.2 For loop ####

# For loop iterates over a sequence where a looping variable changes for each iteration, according to the sequence.
# Syntax:
for(var in seq) { # for each variable in the sequence.
  expression
}
# Create a vector containing the name of a number of cities:
cities <- c("New York", "Paris", "London", "Tokyo", "Rio de Janeiro", "Cape Town")
# Print out every element of the vector one by one using for loop
for (city in cities) {
  print(city) # R repeats the code until all the elements are printed out. 
}

# break statement: like in the while loop, break statement stops the execution of the code and abandons the for loop.
# Suppose we want to leave the for loop as soon as we encounter a city that consists of 6 characters, use the nchar() function.
for (city in cities) {
  if (nchar(city) == 6) {
    break
  }
  print(city) # stops before "London".
}

# next statement: skips the remainder of the code inside the for loop and proceeds the next iteration.
for (city in cities) {
  if (nchar(city) == 6) {
    next
  }
  print(city) # stops before "London".
}

# Build a loop from the scratch:
rquote <- "r's internals are irrefutably intriguing"
chars <- strsplit(rquote, split = "")[[1]] # strsplitt() splits the characters in the quote in separate letters.
rcount <- 0 # initialize rcount.
for (char in chars) {
  if (char == "r") {
    rcount <- rcount + 1  
  }   
  if (char == "u") {
    break            # count the number of r's that come before u.
  } 
}
print(rcount)

# 2.3 Second version of for loop ####

# Give information on the city's position inside the vector by creating a looping index manually:
for (i in 1:length(cities)) { # i progresses from 1 to 6
  print(cities[i])            # change the content of the loop
}                             # exact printout like version 1
# Second version requires more work, but we gain access to the index. Adding more information is easier now:
for (i in 1:length(cities)) {
  print(paste(cities[i], "is on position", 
              i, "in the cities vector"))
}

# Compare version 1 and version 2:
primes <- c(2, 3, 5, 7, 11, 13)
# Loop version 1:
for (p in primes) {            # concise
  print(p)                     # easy to read
}                              # no access to looping index.
# Loop version 2:
for (i in 1:length(primes)) {  # harder to read and write
  print(primes[i])           # more versatile
}

# Create a vector that contains the number of views your LinkedIn profile had in the last 7 days:
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
# Loop version 1:
for (view in linkedin) {
  print(view)
}
# Loop version 2:
for (i in 1:length(linkedin)) {
  print(linkedin[i])
}
# Code the for loop with conditionals:
for (li in linkedin) {
  if (li > 10) {
    print("You're popular!")
  } else {
    print("Be more visible!")
  } 
  if (li > 16) {
    print("This is ridiculous, I'm outta here!")
    break
  }
  if (li < 5) {
    print("This is too embarrassing!")
    next
  }
  print(li)
}

# 2.4 Loop over a list ####

# Looping over a list is as easy and convenient as looping over a vector. 
primes_list <- list(2, 3, 5, 7, 11, 13)
# Loop version 1:
for (p in primes_list) {
  print(p)
}
# Loop version 2:
for (i in 1:length(primes_list)) {
  print(primes_list[[i]])
}
# Create a list with different information of New York City:
nyc <- list(pop = 8405837, 
            boroughs = c("Manhattan", "Bronx", "Brooklyn", "Queens", "Staten Island", 
                         capital = FALSE))
# Loop version 1:
for (borough in nyc) {
  print(borough)
}
# Loop version 2:
for (i in 1:length(nyc)) {
  print(nyc[[i]])
}

# 2.5 Loop over a matrix ####

# Create a matrix that represents the status of a tic-tac-toe game that contains the value "X", "O" and NA:
ttt <- matrix(c("O", "NA", "X", NA, "O", "O", "X", NA, "X"), 
              nrow = 3, byrow = TRUE)
# Build a nested loop (for loop inside a for loop):
for (i in 1:nrow(ttt)) {
  for (j in 1:ncol(ttt)) {
    print(paste("On row", i, "and column", j, "the board contains", ttt[i,j]))
  }
}