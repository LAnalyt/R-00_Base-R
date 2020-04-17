#1. INTRO TO BASICS

#1.1 Arithmetic with R

#In its most basic form, R can be used as a simple calculator
#Addition: +
5 + 5 #10
#Subtraction: -
5 - 5 #0
#Multiplication: *
3*5 #15
#Division: /
(5+5)/2 #5
#Exponentiation: ^ (raise the power)
2^5 #32
#Modulo: %% (returns the remainder of the division)
28%%6  #4

#2.2 Variable assignment

#A variable stores a value or an object (e.g. a function description). 
#You can then later use this variable's name to easily access the value or the object that is stored within this variable.
#assign the value 23 to my_var
my_var <- 23
#print out the value of my_var
my_var #23
#suppose you have a fruit basket. Store the number of apples in a variable
my_apples <- 5
#add 6 oranges into the basket and store the new variable 
my_oranges <- 6
#calculate how many pieces of fruits in total
my_apples + my_oranges #11
#assign the result to a new variable my_fruit
my_fruit <- my_apples + my_oranges
#see how many pieces of fruits in total
my_fruit #11

#3.3 Basic data types in R

#decimal values like 4.5 are called numerics
#natural numbers like 4 are called integers. Integers are also numerics.
#boolean values  (TRUE or FALSE) are called logical 
#text or string values are called characters
#E.g, change my_numeric to be 42
my_numeric <- 42
#change my_character to be "universe"
my_character <- "universe"
#change my_logical to be "FALSE"
my_logical <- FALSE
#Check the data type of a variable with class function
class(my_numeric)
class(my_character)
class(my_logical)


#2. VECTORS

#2.1 create a vector

#Vectors are one-dimension arrays that can hold numeric data, character data, or logical data.
#create a vector with the combine function c(), place the vector elements separated by a comma.
numeric_vector <- c(1, 2, 3)
character_vector <- c("a", "b", "c")
boolean_vector <- c(TRUE, FALSE, TRUE)
#E.g, make an analysis for a gamble games in Las Vegas
#create a data vector for poker game: 
#On Monday you won $140
#Tuesday you lost $50
#Wednesday you won $20
#Thursday you lost $120
#Friday you won $240
poker_vector <- c(140, -50, 20, -120, 240) #negative number for losing money
#create a data vector for roulette game:
#On Monday you lost $24
#Tuesday you lost $50
#Wednesday you won $100
#Thursday you lost $350
#Friday you won $10
roulette_vector <- c(-24, 50, 100, -350, 10)

#2.2 Naming a vector

#It is important to have a clear view on the data that you are using. 
#Understanding what each element refers to is essential
#give a name to the elements of a vector with the names() function
some_vector <- c("John Doe", "poker player")
names(some_vector) <- c("Name", "Profession")
#see how it appears with names
some_vector
#continue with the Las Vegas exercise, assign the days as name
names(poker_vector) <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
names(roulette_vector) <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
#print out to see the results
poker_vector
roulette_vector
#to avoid typing names of the days everytime, create a variable for that
days_vector <- c("Monday","Tuesday","Wednesday","Thursday","Friday")
#assign the name again
names(poker_vector) <- days_vector
names(roulette_vector) <- days_vector

#2.3 Caculating vectors

#You want to find out the following type of information:
#How much has been your overall profit or loss per day of the week?
#Have you lost money over the week in total?
#Are you winning/losing money on poker or on roulette?
#To get the answers, you have to do arithmetic calculations on vectors.
#If you sum two vectors, it takes the element-wise sum. 
#For example, the following three statements are completely equivalent:
c(1,2,3) + c(4,5,6)
c(1+4,2+5,3+6)
c(5,7,9)
#You can also do the calculations with variables that represent vectors
A_vector <- c(1,2,3)
B_vector <-  c(4,5,6)
total_vector <- A_vector + B_vector
total_vector #sum 2 vectors
#find out the total sum of profit/lost on each day
total_daily <- poker_vector + roulette_vector
total_daily
#use sum function to calculate the sum of all elements of a vector
total_poker <- sum(poker_vector)
total_roulette <- sum(roulette_vector)
#total winning overall
total_week <- total_poker + total_roulette
total_week #16$ winning in total
#compare total winnings by ">"
total_poker > total_roulette #TRUE (you play poker better than roulette)

#2.4 Vector selection

#select specific element of a vector with square brackets []
#select Wednesday which has the index 3 in the vector and assign a new variable
poker_wednesday <- poker_vector[3]
poker_wednesday #20$ winning on wednesday in poker game
#select multiple elements from a vector by combine funcion in square brackets
poker_midweek <- poker_vector[c(2,3,4)]
#select contnuous elements from a vector by ":", e.g [2:5]
roulette_selection_vector <- roulette_vector[2:5]
#since the vectors are already assigned with names, we can also select names instead of index number
poker_vector["Monday"] #winning 140$ on Monday
#select poker results for Monday, Tuesday and Wednesday
poker_start <- poker_vector[c("Monday","Tuesday","Wednesday")]
#calculate the average of the selected elements with mean function
mean(poker_start) #winning 36.57$

#2.5 Selection by comparison

#you can also subset the selection by using comparison. The logical comparison operators are:
#< for less than
#> for greater than
#<= for less than or equal to
#>= for greater than or equal to
#== for equal to each other
#!= not equal to each other
#comparison operators can be also used on vectors
c(4, 5, 6) > 5 #FALSE FALSE  TRUE
#find out which days of winning
selection_vector <- poker_vector > 0
#This tests for every element of the vector if the condition stated by the comparison operator is TRUE or FALSE.
selection_vector
#select the winning days
poker_winning_days <- poker_vector[selection_vector]
poker_winning_days
#similarly, which days did you make money on roulette?
selection_vector <- roulette_vector > 0
roulette_winning_days <- roulette_vector[selection_vector]
roulette_winning_days


#3 MATRIX

#3.1 What is a matrix?

#a matrix is a collection of elements of the same data type arranged into a fixed number of rows and columns. 
#construct a matrix with matrix() function
matrix(1:9, byrow = TRUE, nrow = 3)
#1:9 is a shortcut for c(1,2,3,4,5,6,7,8,9)
#byrow indicates that the matrix is filled by the rows
#change byrow = FALSE if you want to fill the matrix by the column
#nrow indicates the number of rows in the matrix

#3.2 Analyze Matrices

#analyze the box office numbers of the Star Wars frenchise
new_hope <- c(460.998, 314.4) #in millions!
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)
#combine 3 vectors into 1
box_office <- c(new_hope, empire_strikes, return_jedi)
#Construct a matrix with 3 rows, where each row represents a movie
star_wars_matrix <- matrix(box_office, byrow = TRUE, nrow = 3)
star_wars_matrix #(Screenshot 1.3 Matrix 1)

#3.3 Naming a matrix

#to remember what is stored in the matrix, add names to the rows and the columns
#rownames(my_matrix) <- row_names_vector
#colnames(my_matrix) <- col_names_vector
#create vectors for naming
region <- c("US","non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")
#name the columns with region
colnames(star_wars_matrix) <- region
#name the rows with titles
rownames(star_wars_matrix) <- titles
#see how the matrix looks like
star_wars_matrix #(Screenshot 1.3 Matrix 2)

#3.4 Calculating matrices

#the function rowSums() conveniently calculates the totals for each row of a matrix. 
#This function creates a new vector: rowSums(my_matrix)
#calculate the world wide box office revenue by adding the sum of the "US" and "non-US" revenue
world_wide_vector <- rowSums(star_wars_matrix)
#check the sum
world_wide_vector #(Screenshot 1.3 Matrix 3)

#3.5 Add a row and column for the matrix

#The new vector world_wide_vector is not yet a part of the matrix
#use cbind() function to merge matrices and/or vectors together by column
#big_matrix <- cbind(matrix 1, matrix 2, vector1...)
#bind the new variable world_wide_vector as a column to star_wars_matrix
all_wars_matrix <- cbind(star_wars_matrix, world_wide_vector)
#see the result
all_wars_matrix #(Screenshot 1.3 Matrix 4)
#just like cbind() has rbind(), colSums() has rowSums()
#calculate total revenue for "US" and "non-US"
total_revenue_vector <- colSums(all_wars_matrix)
#add the new vector as a row in the matrix
all_wars_matrix2 <- rbind(all_wars_matrix, total_revenue_vector)
#see the final result
all_wars_matrix2 #(screenshot 1.3 Matrix 5)

#3.6 Selection of matrix elements

#Similar to vectors, you can use [ ] to select one or multiple elements from a matrix
#Whereas vectors have one dimension, matrices have two dimensions.
#use a comma to separate the rows from the columns
#my_matrix[1,2] selects the element at the first row and second column
#my_matrix[1:3,2:4] results in a matrix with the data on the rows 1,2,3 and columns 2,3,4
#select all elements of a row or a column, no number is needed before or after the comma, respectively
#my_matrix[,1] selects all elements of the first column
#my_matrix[1,] selects all elements of the first row
#Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]
#select the non-US revenue for the first 2 movies
non_us_some <- all_wars_matrix[1:2,2]
#check the result
non_us_all
non_us_some

#3.7 Arithmetic with matrices

#Just like 2 * my_matrix multiplied every element of my_matrix by two, my_matrix1 * my_matrix2 creates a matrix where each element is the product of the corresponding elements in my_matrix1 and my_matrix2
#create another matrix for the price of the movie ticket
#first create new vectors for the ticket price of each movie 
movie1_ticket <- c(5.0,5.0 )
movie2_ticket <- c(6.0, 6.0)
movie3_ticket <- c(7.0, 7.0)
#combine them into a single vector
ticket_price <- c(movie1_ticket, movie2_ticket, movie3_ticket)
#construct a matrix from this
ticket_price_matrix <- matrix(movie_ticket, byrow = TRUE, nrow = 3)
#adding names for rows and columns
colnames(ticket_price_matrix) <- region
row.names(ticket_price_matrix) <- titles
#print the new matrix out
ticket_price_matrix #(screenshot 1.3 Matrix 7), the result shows no decimal number
#now estimate number of visitors by diving the total revenue to the unit price
visitors <- star_wars_matrix/ticket_price_matrix
visitors #(screenshot 1.3 Matrix 8)
#select the visitors from US
visitors_us <- visitors[,1]
visitors_us #(screenshot 1.3 Matrix 9)
