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

#4. FACTORS

#4.1 What is a factor and why we use it?

#Factors refer to a statistical data type used to store categorical values.
#The difference between a categorical variable and a continuous variable is that a categorical variable can belong to a limited number of categories.
#create a vector that contains all the observations that belong to a limited number of categories
sex_vector <- c("Male", "Female", "Female", "Male", "Male")
#there're two categories here, or the "factor levels" here are "Male" and "Female"
#convert sex_vector to a factor
factor_sex_vector <- factor(sex_vector)
#print out to see the factor levels
factor_sex_vector #Levels: Female Male (screenshot 1.4 Factor 1)

#There are two types of categorical variables: a nominal categorical variable and an ordinal categorical variable.
#A nominal variable is a categorical variable without an implied order.
animals_vector <- c("Elephant", "Giraffe", "Donkey", "Horse")
factor_animals_vector <- factor(animals_vector)
#it is impossible to say that 'one is worth more than the other
factor_animals_vector #Levels: Donkey Elephant Giraffe Horse (screenshot 1.4 Factor 2)
#In contrast, ordinal variables do have a natural ordering. 
temperature <-  c("High", "Low", "High", "Low", "Medium")
factor_temperature <- factor(temperature, ordered = TRUE, levels = c("Low", "Medium", "High"))
factor_temperature #Levels: Low < Medium < High (screenshot 1.4 Factor 3)

#4.2 Factor levels

#Some datasets contain factors with specific factor levels.
#to change the names of these levels for clarity: levels()
#E.g, the sex of the correspondents in a survey were recorded in short as "F" and "M"
survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector)
#specify the levels
levels(factor_survey_vector) <- c("Female", "Male")
#print out the result
factor_survey_vector #[1] Male Female Female Male   Male Levels: Female Male

#4.3 Summarize a factor

#You would like to know how many "Male" and "Female" responses to your survey
#generate a summary for survey
summary(survey_vector) #This shows the length, class and mode of the dataset, not what you expect
#generate a summary for the factored survey (screenshot 1.4 Factor 4)
summary(factor_survey_vector) #Female 2  Male 3 
#"Male" and "Female" are nominal (unordered) factor levels and can't be compared.

#4.4 Ordered factors

#Sometimes you will also deal with factors that do have natural ordering
#E.g, evaluate the performance of 5 data analysts as "slow", "medium" and "fast"
speed_vector <- c("medium", "slow", "slow", "medium", "fast")
#speed_vector should be converted into an ordinal factor since its categories have a natural ordering.
factor_speed_vector <- factor(speed_vector, ordered = TRUE, levels = c("slow", "medium", "fast"))
#by setting the argument "ordered" to TRUE, you indicate that the factor is ordered.
#with the argument "levels" you give the values of the factor in the correct order.
#Now you can compare elements in the vector
#Compare the performance of data analyst 2 and data analyst 5
da2 <- factor_speed_vector[2]
da5 <- factor_speed_vector[5]
da2 > da5 #FALSE

#5. DATA FRAMES

#5.1 What is a data frame?

#You will often work with data sets that contain different data types instead of only one. 
#A data frame has the variables of a data set as columns and the observations as rows.
#Load a built-in example data frame in R called "mtcars"
mtcars
#When you work with large data sets and data frames, it's better to develop a clear understanding of its structure and main elements. 
#Therefore, it is often useful to show only a small part of the entire data set. 
head(mtcars) #head() shows the first observations of a data frame
#similarly, tail() function shows the last observations of a data frame
tail(mtcars) #(screenshot 1.5 Data frame 1-2)

#5.2 Structure of a data frame

#to get a rapid overview of your data is the structure function: str()
#The total number of observations
#The total number of variables
#A full list of the variable names
#The data type of each variable
#The first observations
#Applying the str() function will often be the first thing that you do when receiving a new data set or data frame. 
#It is a great way to get more insight in your data set before diving into the real analysis.
str(mtcars) #(screenshot 1.5 Data frame 3)

#5.3 Create a data frame

#construct a data frame that describes the main characteristics of eight planets in our solar system
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
#add the type of planet (Terrestrial or Gas Giant)
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
#add the planet's diameter relative to the diameter of the Earth
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
#add the planet's rotation across the sun relative to that of the Earth
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
#if the planet has rings or not (TRUE or FALSE).
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)
#now create a data frame from those vectors
planets_df <- data.frame(name, type, diameter, rotation, rings)
#the vectors become different columns of the data frame
#Because every column has the same length, the vectors should also have the same length
planets_df #(screenshot 1.5 Data frame 4)
#check the structure of the data frame
str(planets_df)

#5.4 Selection of data frame elements

#Similar to vectors and matrices, select elements from a data frame with square brackets [ ]
#By using a comma, you can indicate what to select from the rows and the columns respectively.
#E.g, print out diameter of Mercury (row 1, column 3)
planets_df[1,3] #0.382
#print out data for Mars (entire fourth row)
planets_df[4,] #(screenshot 1.5 Data frame 5)
#Instead of using numerics, it's also possible to use the variable names to select columns of a data frame.
planets_df[1:3,2] 
#or, it is often easier to just make use of the variable name:
planets_df[1:3, "type"] #(screenshot 1.5 Data frame 6)
#If you want to select all elements of the variable "diameter":
planets_df[,3]
#or
planets_df[,"diameter"]
#but the shorter way is using "$" symbol
planets_df$diameter
#select the rings variable from "planets_df"
rings_vector <- planets_df$rings
#see which planet has a ring
rings_vector #FALSE FALSE FALSE FALSE  TRUE  TRUE  TRUE  TRUE
#This means that the first four observations do not have a ring, but the other four do. 
#However, you do not get a nice overview of the names of these planets, their diameter, etc. 
#select all columns for planets with rings
planets_df[rings_vector,] #to select all columns, leave the columns part inside the [ ] empty
#or create a subset with a condition from the data frame
subset(planets_df, subset = rings) #(screenshot 1.5 Data frame 8)

#5.5 Sorting

#In data analysis you can sort data according to a certain variable in the data set.
#order() is a function that gives the ranked position of each element when it is applied on a variable
a <- c(100, 10, 1000)
order(a)
#This means we can use the output of order(a) to reshuffle a:
a[order(a)]
#rearrange the data frame "planets_df" such that it starts with the smallest planet and ends with the largest one.
#sorting on "diameter" column
positions <- order(planets_df$diameter)
#use positions to sort "planets_df"
planets_df[positions,]
