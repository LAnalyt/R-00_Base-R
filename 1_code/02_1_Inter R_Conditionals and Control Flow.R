# 1. CONDITIONALS AND CONTROL FLOW

# 1.1 Relational operators ####

# Relational operators, or comparators, are operators which show how one R object relates to another. 
# Equality operator
TRUE == TRUE  # returns a logical value.
TRUE == FALSE 
# Compare strings
"hello" == "goodbye" 
# Compare numbers
3 == 2 
# Compare a logical with a numeric
TRUE == 1 # TRUE

# Inequality operator
"hello" != "goodbye" # TRUE. The sentence is read as: "hello" is not equal to "goodbye".
# Naturally, the inequality operator can also be used for numerics, logicals, and other R objects
3 != 2
TRUE != FALSE 
"useR" == "user"
-6*14 != 17-101
# The result of the inequality operator is opposite for the equality operator.

# Greater and less operator
3 < 5
5 > 3
-6 * 5 + 2 > -10+1
# R uses alphabet order to sort character strings
"Hello" > "Goodbye" # TRUE
# For logical values: TRUE coerces to 1 and FALSE coerces to 0
TRUE < FALSE # FALSE, 1 > 0

# Greater/less or equal operators
5 >= 3 # TRUE
3 >= 3 # TRUE
"raining" <= "raining dogs" # TRUE

# 1.2 Compare vectors and matrices ####

# Create 2 vectors contain the number of views on social media for the last 7 days
linkedin <- c(16, 9, 13, 5, 2, 17, 14)
facebook <- c(17, 7, 5, 16, 8, 13, 14)
# Figure out which day is popular
linkedin > 15 # returns a logical result for each element.
# Quiet days
facebook <= 5
# When was Linkedin visited more often than Facebook?
linkedin > facebook # comparison is done for every element of the vector, one by one.

# Create a matrix from linkedin and facebook
views <- matrix(c(linkedin, facebook), nrow = 2, byrow = TRUE)
# When were the views exactly equal to 13?
views == 13
# When is views less than or equal to 14?
views <= 14

# 1.3 Logical operators ####

# To change or combine comparison, R uses logical operators: AND, OR, and NOT.

# AND operator "&"
# TRUE & TRUE returns TRUE
# TRUE & FALSE returns FALSE
# FALSE & TRUE returns FLASE
# FALSE & FALSE returns FALSE
x <- 12
x > 5 & x < 15   # TRUE
x <- 17
x >5 & x < 15    # FALSE

# OR operator "|"
# TRUE | TRUE returns TRUE
# TRUE | FALSE returns TRUE
# FALSE | TRUE returns TRUE
# FALSE | FALSE returns FALSE
y <- 4
y < 5 | y > 15 # TRUE or FALSE, results in TRUE
y <- 14
y < 5 | y > 15 # FALSE or FALSE, results in FALSE.

# NOT operator "!"
# simply negates the logical value its's used on.
!TRUE # FALSE
!FALSE # TRUE
# Just like AND and OR operators, NOT can be also used in combination with logical operators. This is not always necessary.
! (x < 5 ) # is exactly the same as x >= 5

# Continue the exercise with linkedin and facebook views. Create a variable for the last day of linkedin
last <- tail(linkedin, 1)
# Is last day's views under 5 or above 10?
last <5 | last > 10 # TRUE
# Is last day's views between 15 (exclusive) and 20 (inclusive)?
last > 15 & last <= 20 # FALSE
# When were one or both visited at least 12 times?
linkedin >= 12 | facebook >= 12
# When is views between 11 (exclusive) and 14 (inclusive)?
views > 11 & views <= 14

# Suppose you conducted a survey for every employee with a LinkedIn profile how many visits their profile has had over the past seven days. Load the csv file and store it in a data frame
li_df <- read.csv("linkedin.csv") # in 0_data folder
# Select the second day from the data frame
second <- li_df[,"day2"]
# Build a logical vector, TRUE if value in second is extreme
extremes <- second > 25 | second <5
# Count the number of TRUEs in extremes
sum(extremes) 

# 1.4 Conditional operators ####
# R also provides a way to use the results of the operators to change the behaviour of R scripts.

# if statements ==== 
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

# else statement ====
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

# else if statement ====
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