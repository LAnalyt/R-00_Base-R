# 6. USEFUL FUNCTIONS

# 6.1 Mathematical utilities ####

# Create 2 vectors v1 and v2
v1 <- c(1.1, -7.1, 5.4, -2.7)
v2 <- c(-3.6, 4.1, 5.8, -8.0)

# abs(): calculates the absolute value of an array of a numerical value
abs(v1)
abs(v2) # return positive value of all elements.

# round(): rounds up the input
round(abs(v1))
round(abs(v2)) # rounds up all the decimal numbers.

# sum(): computes the sum of the input array
sum(round(abs(v1))) # 16
sum(round(abs(v2))) # 22

# mean(): calculates the arithmetic mean. Mean() in R is capable of handling different types of objects, but most commonly on numerical arrays
mean(c(16,22)) # 19
# This is equally the bulky arithmetic one-liner:
mean(c(sum(round(abs(v1))), sum(round(abs(v2)))))

# Example: create a vector representing the errors made by your training model
errors <- c(1.9, -2.6, 4.0, -9.5, -3.4, 7.3)
# Calculate the sum of the absolute rounded value of the training errors
sum(round(abs(errors))) # 29.