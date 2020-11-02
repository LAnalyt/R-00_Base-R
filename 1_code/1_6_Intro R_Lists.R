# 6. LISTS

# A list in R allows you to gather a variety of objects under one name in an ordered way. These objects can be matrices, vectors, data frames, even other lists, etc. It is not even required that these objects are related to each other in any way.
# A list is some kind super data type: you can store practically any piece of information in it!

# 6.1 Create a list####

# To construct a list, use the function list()
# E.g, first create a vector with numerics from 1 to 10
my_vector <- 1:10
# Create a matrix with numerics from 1 to 9
my_matrix  <- matrix(1:9, ncol = 3)
# Create a data frame out of 10 first elements from the built-in data frame "mtcars"
my_df <- mtcars[1:10,]
# Now construct a list with these different elements
my_list <- list(my_vector, my_matrix, my_df)
# The result shows a combination of those elements
my_list

# 6.2 Create a named list####

# Just like on your to-do list, you want to avoid not knowing or remembering what the components of your list stand for. 
# That is why you should give names to them:
my_list <- list("vec" = my_vector, "mat" = my_matrix, "df" = my_df)
# Check the names now appearing in the with a $ symbol
my_list 
# Another way is assigning the names first with names() function
names(my_list) <- c("vec", "mat", "df")
# E.g, create a list for the movie "The Shining". 
# First create a vector for movie name
mov <- "The Shining"
# Create a vector with the main actors' names
act <- c("Jack Nicholson", "Shelley Duvall", "Danny Lloyd", "Scatman Crothers", "Barry Nelson")
# Create a data frame that contains some reviews
scores <- c(4.5, 4.0, 5.0)
sources <- c("IMDb1","IMDb2", "IMDb3")
comments <- c("Best Horror Film I Have Ever Seen", "Best Horror Film I Have Ever Seen", "Best Horror Film I Have Ever Seen")
rev <- data.frame(scores, sources, comments)
# Now construct a list with names from combining all these elements together
shining_list <- list("moviename" = mov, "actors" = act, "reviews" = rev)
# Print out the list
shining_list 

# 6.3 Select elements from a list####

# Your list will often be built out of numerous elements and components. Therefore, getting a single element, multiple elements, or a component out of it is not always straightforward.
# One way to select a component is using the numbered position of that component. E.g, to "grab" the first component of shining_list you type:
shining_list[[1]] #"The Shining"
# Important: to select elements from vectors, use single square brackets: []. Don't mix them up!
# You can also refer to the names of the components, with [[ ]] or with the $ sign. 
shining_list[["reviews"]]
shining_list$reviews 
# Besides selecting components, you often need to select specific elements out of these components
shining_list[[2]][1] #"Jack Nicholson"
# You select from the second component, actors (shining_list[[2]]), the first element ([1]).

# Exercise: create a new list for another movie: "The Departed!"
# Create vectors for movie name and actors
movie_title <- "The Daparted"
movie_actors <- c("Leonardo DiCapiro", "Matt Damon", "Jack Nicholson", "Mark Wahlberg", "Vera Farmiga", "Martin Sheen")
# Now define the comments and scores vectors:
scores <- c(4.6, 5, 4.8, 5, 4.2)
comments <- c("I would watch it again", "Amazing!", "I liked it", "One of the best movies", "Fascinating plot") 
# Find the average of the scores vector and save it as avg_review
avg_review <- mean(scores)
# Combine scores and comments into the reviews_df data frame
reviews_df <- data.frame(scores, comments)
# Create a list that contains the movie_title, movie_actors, reviews , and the average review score
departed_list <- list(movie_title, movie_actors, reviews_df, avg_review)
# Print out the list 
departed_list

# 6.4 Flatten Lists ####

# In some cases you want to disassemble a list to its atomic components. Unlist() function produces a vector which contains all these components
unlist(my_list)
unlist(shining_list)