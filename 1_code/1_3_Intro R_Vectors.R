# 2. VECTORS

# Vectors are one-dimension arrays that can hold numeric data, character data, or logical data.

# 2.1 Create a vector ####

# Create a vector with the combine function c(), place the vector elements separated by a comma.
numeric_vector <- c(1, 2, 3)
character_vector <- c("a", "b", "c")
boolean_vector <- c(TRUE, FALSE, TRUE)
# E.g, make an analysis for a gamble games in Las Vegas.
# Create a data vector for poker game: 
# On Monday you won $140.
# Tuesday you lost $50.
# Wednesday you won $20.
# Thursday you lost $120.
# Friday you won $240.
poker_vector <- c(140, -50, 20, -120, 240) # negative number for losing money.
# Create a data vector for roulette game:
# On Monday you lost $24.
# Tuesday you lost $50.
# Wednesday you won $100.
# Thursday you lost $350.
# Friday you won $10.
roulette_vector <- c(-24, 50, 100, -350, 10)

# 2.2 Naming a vector ####

# It is important to have a clear view on the data that you are using. Understanding what each element refers to is essential
# Give a name to the elements of a vector with the names() function
some_vector <- c("John Doe", "poker player")
names(some_vector) <- c("Name", "Profession")
# See how it appears with names:
some_vector
# Continue with the Las Vegas exercise, assign the days as name:
names(poker_vector) <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
names(roulette_vector) <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
# Print out to see the results:
poker_vector
roulette_vector
# To avoid typing names of the days every time, create a variable for that:
days_vector <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
# Assign the name again
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

# 2.3 Calculating vectors ####

# You want to find out the following type of information:
# How much has been your overall profit or loss per day of the week?
# Have you lost money over the week in total?
# Are you winning/losing money on poker or on roulette?
# To get the answers, you have to do arithmetic calculations on vectors.
# If you sum two vectors, it takes the element-wise sum. 
# For example, the following three statements are completely equivalent:
c(1,2,3) + c(4,5,6)
c(1+4,2+5,3+6)
c(5,7,9)
# You can also do the calculations with variables that represent vectors.
A_vector <- c(1,2,3)
B_vector <-  c(4,5,6)
total_vector <- A_vector + B_vector
total_vector # sum 2 vectors.
# Find out the total sum of profit/lost on each day:
total_daily <- poker_vector + roulette_vector
total_daily
# Use sum function to calculate the sum of all elements of a vector:
total_poker <- sum(poker_vector)
total_roulette <- sum(roulette_vector)
# Total winning overall:
total_week <- total_poker + total_roulette
total_week            
# Compare total winnings by ">":
total_poker > total_roulette # TRUE (you play poker better than roulette).

# 2.4 Vector selection ####

# Select specific element of a vector with square brackets [].
# Select Wednesday which has the index 3 in the vector and assign a new variable:
poker_wednesday <- poker_vector[3]
poker_wednesday
# Select multiple elements from a vector by combine function in square brackets:
poker_midweek <- poker_vector[c(2,3,4)]
# Select contnuous elements from a vector by ":", e.g [2:5]
roulette_selection_vector <- roulette_vector[2:5]
# Since the vectors are already assigned with names, we can also select names instead of index number
poker_vector["Monday"]
# Select poker results for Monday, Tuesday and Wednesday
poker_start <- poker_vector[c("Monday","Tuesday","Wednesday")]
# Calculate the average of the selected elements with mean function
mean(poker_start)

# 2.5 Selection by comparison ####

# You can also subset the selection by using comparison. The logical comparison operators are:
# < for less than.
# > for greater than.
# <= for less than or equal to.
# >= for greater than or equal to.
# == for equal to each other.
# != not equal to each other.
# Comparison operators can be also used on vectors.
c(4, 5, 6) > 5
# Find out which days of winning:
selection_vector <- poker_vector > 0
# This tests for every element of the vector if the condition stated by the comparison operator is TRUE or FALSE.
selection_vector
# Select the winning days:
poker_winning_days <- poker_vector[selection_vector]
poker_winning_days
# Similarly, which days did you make money on roulette?
selection_vector <- roulette_vector > 0
roulette_winning_days <- roulette_vector[selection_vector]
roulette_winning_days