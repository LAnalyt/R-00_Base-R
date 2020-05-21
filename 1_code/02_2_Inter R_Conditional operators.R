# 1. CONDITIONALS AND CONTROL FLOW (cont)

# 1.4 Conditional operators ####################################
# R also provides a way to use the results of the operators to change the behaviour of R scripts.

# if statements ================================================ 
# if the condition evaluates to TRUE, the R code associated with the if statement is executed 
if (condition) {
  expression
}
x <- -3
if (x < 0) {
  print("x is a negative number")
}
# If we change x to 5 and rerun the code, the condition will be FALSE, the code will not be operated and the printout will not occur
x <- 5
if (x < 0) {
  print("x is a negative number")
}

# else statement =============================================== 
# has to be used together with an if statement. The code associated with the else statement gets executed whenever the condition of the if test is not satisfied. 
if (condition) {
  expression1
} else {
  expression2
}
x <- -3
if (x < 0) {
  print("x is a negative number")
} else {
  print("x is either a positive number or zero")
}
# If we change x to 5 and run the code again, the text "x is either a positive number or zero" will be printed out
x <- 5
if (x < 0) {
  print("x is a negative number")
} else {
  print("x is either a positive number or zero")
}

# else if statement ============================================
# customize even further
if (condition) {
  expression1
} else if (condition2) {
  expression2
} else {
  expression3
}
x <- -3
if (x < 0) {
  print("x is a negative number")
} else if (x == 0) {
  print("x is zero")
} else {
  print("x is either a positive number or zero")
}
# Try x <- 0 and x <- 5 then run the code again. The text will be printed out respectively.

# As soon as R meets the condition that is evaluates as TRUE, it will execute the corresponding code and ignore the rest of the control structure.
x <- 6
if (x %% 2 == 0) {
  print("divisible by 2")
} else if (x %% 3 == 0) {
    print("divisible by 3")
} else {
    print("not divisible by 2 nor 3...")
} # although the second condition is also TRUE, nothing gets printed out because the first condition is already met.

# Create a variable for the last day of your social website recordings
medium <- "LinkedIn"
num_views <- 14
# Examine the if statement for medium
if (medium == "LinkedIn") {
  print("Showing LinkedIn information") 
} else if (medium == "Facebook") {
  print("Showing Facebook information")
} else {
  print("Unknown medium")
}
# Write the if statement for num_views
if (num_views > 15) {
  print("You are popular!")
} else if (num_views <= 15 & num_views > 10) { 
  print("Your number view is just average")
} else {
  print("Try to be more visisble!")
}

# You can do anything you want inside if-else constructs, even put in another set of conditional statements.
if (number < 10) {
  if (number < 5) {
    result <- "extra small"
  } else {
    result <- "small"
  }
} else if (number < 100) {
  result <- "medium"
} else {
  result <- "large"
}
print(result)
number <- 6    # "small" gets printed out.
number <- 99   # "medium" gets printed out.
number <- 4    # "extra small" gets printed out.
number <- 2000 # "large" gets printed out.

# Create 2 variables denoting the number of views your LinkedIn and Facebook profile have for the last day of recording
li <- 15
fb <- 9
# Through the control-flow construct to generate a "social media score" called sms based on the values of li and fb.
if (li >= 15 & fb >= 15) {
  sms <- 2 * (li + fb)
} else if (li < 10 & fb < 10) {
  sms <- 0.5 * (li + fb)
} else {
  sms <- li + fb
}
print(sms)