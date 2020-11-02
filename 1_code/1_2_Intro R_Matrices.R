# 3. MATRIX

# 3.1 What is a matrix?####

# A matrix is a collection of elements of the same data type arranged into a fixed number of rows and columns. 
# Construct a matrix with matrix() function
matrix(1:9, byrow = TRUE, nrow = 3)
# 1:9 is a shortcut for c(1,2,3,4,5,6,7,8,9)
# byrow indicates that the matrix is filled by the rows
# Change byrow = FALSE if you want to fill the matrix by the column
# nrow indicates the number of rows in the matrix

# 3.2 Analyze Matrices####

# Analyze the box office numbers of the Star Wars frenchise
new_hope <- c(460.998, 314.4) #in millions!
empire_strikes <- c(290.475, 247.900)
return_jedi <- c(309.306, 165.8)
# Combine 3 vectors into 1
box_office <- c(new_hope, empire_strikes, return_jedi)
# Construct a matrix with 3 rows, where each row represents a movie
star_wars_matrix <- matrix(box_office, byrow = TRUE, nrow = 3)
star_wars_matrix 

# 3.3 Naming a matrix####

# To remember what is stored in the matrix, add names to the rows and the columns
# rownames(my_matrix) <- row_names_vector
# colnames(my_matrix) <- col_names_vector
# Create vectors for naming
region <- c("US","non-US")
titles <- c("A New Hope", "The Empire Strikes Back", "Return of the Jedi")
# Name the columns with region
colnames(star_wars_matrix) <- region
# Name the rows with titles
rownames(star_wars_matrix) <- titles
# See how the matrix looks like
star_wars_matrix

# 3.4 Calculating matrices####

# The function rowSums() conveniently calculates the totals for each row of a matrix. 
# This function creates a new vector: rowSums(my_matrix)
# Calculate the world wide box office revenue by adding the sum of the "US" and "non-US" revenue
world_wide_vector <- rowSums(star_wars_matrix)
# Check the sum
world_wide_vector 

# 3.5 Add a row and column for the matrix####

# The new vector world_wide_vector is not yet a part of the matrix
# Use cbind() function to merge matrices and/or vectors together by column
# big_matrix <- cbind(matrix 1, matrix 2, vector1...)
# bind the new variable world_wide_vector as a column to star_wars_matrix
all_wars_matrix <- cbind(star_wars_matrix, world_wide_vector)
# See the result
all_wars_matrix 
# Just like cbind() has rbind(), colSums() has rowSums()
# Calculate total revenue for "US" and "non-US"
total_revenue_vector <- colSums(all_wars_matrix)
# Add the new vector as a row in the matrix
all_wars_matrix2 <- rbind(all_wars_matrix, total_revenue_vector)
# See the final result
all_wars_matrix2 

# 3.6 Selection of matrix elements####

# Similar to vectors, you can use [ ] to select one or multiple elements from a matrix
# Whereas vectors have one dimension, matrices have two dimensions.
# Use a comma to separate the rows from the columns
# my_matrix[1,2] selects the element at the first row and second column
# my_matrix[1:3,2:4] results in a matrix with the data on the rows 1,2,3 and columns 2,3,4
# Select all elements of a row or a column,no number is needed before or after the comma, respectively
# my_matrix[,1] selects all elements of the first column
# my_matrix[1,] selects all elements of the first row
# Select the non-US revenue for all movies
non_us_all <- all_wars_matrix[,2]
# Select the non-US revenue for the first 2 movies
non_us_some <- all_wars_matrix[1:2,2]
# Check the result
non_us_all
non_us_some

# 3.7 Arithmetic with matrices####

# Just like 2 * my_matrix multiplied every element of my_matrix by two, my_matrix1 * my_matrix2 creates a matrix where each element is the product of the corresponding elements in my_matrix1 and my_matrix2
# Create another matrix for the price of the movie ticket
# First create new vectors for the ticket price of each movie 
movie1_ticket <- c(5.0, 5.0 )
movie2_ticket <- c(6.0, 6.0)
movie3_ticket <- c(7.0, 7.0)
# Combine them into a single vector
ticket_price <- c(movie1_ticket, movie2_ticket, movie3_ticket)
# Construct a matrix from this
ticket_price_matrix <- matrix(ticket_price, byrow = TRUE, nrow = 3)
# Adding names for rows and columns
colnames(ticket_price_matrix) <- region
row.names(ticket_price_matrix) <- titles
# Print the new matrix out
ticket_price_matrix 
# Now estimate number of visitors by diving the total revenue to the unit price
visitors <- star_wars_matrix/ticket_price_matrix
visitors 
# Select the visitors from US
visitors_us <- visitors[,1]
visitors_us 