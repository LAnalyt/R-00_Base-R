# 2. LOOPS

# 2.1 While loop ################################################

# While loop is similar to if statement because it executes the code inside if the condition is TRUE. However, as opposite to if statements, the while loop will continue to execute the code over and over again as long as the condition is true.
while (condition) {
  expression
}
# Make R increment a counter until it reaches the value 7
ctr <- 1 # start by defining ctr, short for counter
while (ctr <= 7) {   
  print(paste("ctr is set to", ctr)) # print out the value of ctr
  ctr <- ctr + 1 # add an increment on every run
} # no printout after 7th run.
# Without "ctr <- ctr + 1" the code will run infinitely.
# Always make sure the while loop ends at some point.

# Break statement: simply break out of the while loop. When R find it, it abandons the currently active while loop.
while (ctr <= 7) {
  if (ctr %% 5 == 0) {
    break # R stops the loop as soon as ctr is divisible by 5
  }
  print(paste("ctr is set to", ctr))
  ctr <- ctr + 1
} # no printout after 4th run.

# Initialize a variable for speed
speed <- 64
# Create a while loop that controls the speed
while (speed > 30) {
  print(paste("Slow down!"))
  speed <- speed - 7
} # no printout after speed reaches 29.
# Extend/adapt the while loop to make the driver's assistance more advanced
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
# There are some very rare situations in which severe speeding is necessary. Add a break in the while loop
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
