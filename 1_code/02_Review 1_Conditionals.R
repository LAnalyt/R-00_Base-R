# REVIEW: CONDITIONALS & CONTROL FLOW

# Grade analysis in R ####

# Suppose you're a student in a class with other 199 classmates. You want to analyze the grades of this academy. The highest possible grade is 100, the lowest possible grade is 0.
# You know your own grade
me <- 89
# You have the access to the anonymized grades of other students
other_199 <- scan("other_199.txt") # set directory path to 0_data and import the text file as a vector with scan() function.
# You also have the access to the grades of previous 4 years. Import this data and convert it into a matrix with 4 columns 
previous_4 <- matrix(scan("previous_4.txt"), ncol = 4)

# To format the data so that it'd be easier to work with and analyze later on, merge the three datasets
my_class <- c(me, other_199)
# Build a 200x5 matrix using cbind() function to merge columns
last_5 <- cbind(my_class, previous_4)
# Name last_5 approprieately from year_1 to year_5
colnames(last_5) <- paste0("year_", 1:5) # paste0() function uses an empty string to join strings.

# Explore your data ####

# To get a good feel for your data, it's a good idea to make some visualizations and make some summaries.
# Build a histogram to have an overview of the grade this year
hist(my_class) # your grade (89) is in the 85-90 bin.
# Distinguish different bars with different colors
hist(my_class, col = rainbow(10)) # use rainbow palette.
# Generate a summary of each year
summary(last_5)
# A boxplot is more informative here
boxplot(last_5) # the plot shows only a slight differenct among 5 years.

# Basic queries ####

# Using relational operators to write queries to answer question about me, my_class and last_5. 
# Is your grade equal to 72?
me == 72
# Which grades in your class are higher than 75?
my_class > 75
# Which grades in the last 5 years are below or equal to 64?
last_5 <= 64
# The result of the queries should be a vector or a matrix of logicals.

# Logical operator ####

# Next to relational operators, there are also logical operators, to combine logicals: & - AND, | - OR, ! - NOT.
# Is your grade greater than 87 and smaller than or equal to 89?
me > 87 & me <= 89
# Which grades in your class are below 60 or above 90?
my_class < 60 | my_class >90

# Build aggregates ####

# Answering the question which grades in your class are higher than 75? with a vector of logicals is not very insightful. It's much better to ask the question how many grades in your class are higher than 75? instead. 
# For a logical vector, each TRUE counts as 1, and each FALSE — as zero. So summing all the elements of a logical vector is equivalent to counting all the 1’s (i.e. counting all the TRUE values).
# How many grades in your class are higher than 75?
sum(my_class > 75)
# How many students in your class scored strictly higher than you?
sum(my_class > me)
# Just in the same way, use mean() to find proportion of TRUE values in a logical vector: mean() returns the number of TRUE values divided by the total number of values.
# What's the proportion of grades below or equal to 64 in the last 5 years?
mean(last_5 <= 64)
# What's the proportion of grades in your class that are greater than or equal to 70 and lower than or equal to 85?
mean(my_class >= 70 & my_class <= 85)
# How many students in the last 5 years had a grade of 80 or 90?
sum(last_5 == 80 | last_5 == 90)

# if, else ####

# Recall the syntax of if-else
if (me > 80) {
  print("Good student!")
} else {
  print("Better luck nex year!")  
} # your grade (me) = 89, so the condition in the if statement evaluates to TRUE, and print("Good student!) is executed.
# Assign to n_smart the number of grades in my_class that are greater than or equal to 80
n_smart <- sum(my_class >= 80)
# Write an if-else statement
if (n_smart > 50) {
  print("smart class")
} else {
  print("rather average")
}

# else if ####

# Assign prop_less the proportion of students whose grade - stored in my_class - was lower than yours
prop_less <- mean(my_class < me)
# Customize further the if-self constructs with else if statement 
if (prop_less > 0.9) {
  print("you're among the best 10 percent")
} else if (prop_less > 0.8) {
  print("you're among the best 20 percent")
} else {
  print("need more analysis")
}
# Imbedded if-else clauses
if (mean(my_class) < 75) {
  if (mean(my_class) > me) {
    print("average year, but still smarter than me")
  } else {
    print("average year, but I'm not that bad")
  } 
} else {
  if (mean(my_class) > me) {
    print("smart year, even smarter than me")
  } else {
    print("smart year, but I am smarter")
  }
}
# See whether there were more high achievers than low achievers in your class
top_grades <- my_class[my_class >= 85]
worst_grades <- my_class[my_class < 65]
if (sum(top_grades) > sum(worst_grades)){
  print("top grades prevail")
}