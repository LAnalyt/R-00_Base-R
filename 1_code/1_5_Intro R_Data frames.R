# 5. DATA FRAMES

# 5.1 What is a data frame?####

# You will often work with data sets that contain different data types instead of only one. 
# A data frame has the variables of a data set as columns and the observations as rows.
# Load a built-in example data frame in R called "mtcars"
mtcars
# When you work with large data sets and data frames, it's better to develop a clear understanding of its structure and main elements. 
# Therefore, it is often useful to show only a small part of the entire data set. 
head(mtcars) # head() shows the first observations of a data frame
# Similarly, tail() function shows the last observations of a data frame
tail(mtcars)

# 5.2 Structure of a data frame####

# To get a rapid overview of your data is the structure function: str()
# The total number of observations
# The total number of variables
# A full list of the variable names
# The data type of each variable
# The first observations
# Applying the str() function will often be the first thing that you do when receiving a new data set or data frame. 
# It is a great way to get more insight in your data set before diving into the real analysis.
str(mtcars) 

# 5.3 Create a data frame####

# Construct a data frame that describes the main characteristics of eight planets in our solar system
name <- c("Mercury", "Venus", "Earth", "Mars", "Jupiter", "Saturn", "Uranus", "Neptune")
# Add the type of planet (Terrestrial or Gas Giant)
type <- c("Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Terrestrial planet", "Gas giant", "Gas giant", "Gas giant", "Gas giant")
# Add the planet's diameter relative to the diameter of the Earth
diameter <- c(0.382, 0.949, 1, 0.532, 11.209, 9.449, 4.007, 3.883)
# Add the planet's rotation across the sun relative to that of the Earth
rotation <- c(58.64, -243.02, 1, 1.03, 0.41, 0.43, -0.72, 0.67)
# If the planet has rings or not (TRUE or FALSE).
rings <- c(FALSE, FALSE, FALSE, FALSE, TRUE, TRUE, TRUE, TRUE)
# Now create a data frame from those vectors
planets_df <- data.frame(name, type, diameter, rotation, rings)
# The vectors become different columns of the data frame
# Because every column has the same length, the vectors should also have the same length
planets_df 
# Check the structure of the data frame
str(planets_df)

# 5.4 Selection of data frame elements####

# Similar to vectors and matrices, select elements from a data frame with square brackets [ ]
# By using a comma, you can indicate what to select from the rows and the columns respectively.
# E.g, print out diameter of Mercury (row 1, column 3)
planets_df[1,3] 
# Print out data for Mars (entire fourth row)
planets_df[4,] 
# Instead of using numerics, it's also possible to use the variable names to select columns of a data frame.
planets_df[1:3,2] 
# Or, it is often easier to just make use of the variable name:
planets_df[1:3, "type"]
# If you want to select all elements of the variable "diameter":
planets_df[,3]
# Or
planets_df[,"diameter"]
# But the shorter way is using "$" symbol
planets_df$diameter
# Select the rings variable from "planets_df"
rings_vector <- planets_df$rings
# See which planet has a ring
rings_vector
# This means that the first four observations do not have a ring, but the other four do. 
# However, you do not get a nice overview of the names of these planets, their diameter, etc. 
# Select all columns for planets with rings
planets_df[rings_vector,] #to select all columns, leave the columns part inside the [ ] empty
# Or create a subset with a condition from the data frame
subset(planets_df, subset = rings) 

# 5.5 Sorting####

# In data analysis you can sort data according to a certain variable in the data set.
# order() is a function that gives the ranked position of each element when it is applied on a variable
a <- c(100, 10, 1000)
order(a)
# This means we can use the output of order(a) to reshuffle a:
a[order(a)]
# Rearrange the data frame "planets_df" such that it starts with the smallest planet and ends with the largest one.
# Sorting on "diameter" column
positions <- order(planets_df$diameter)
# Use positions to sort "planets_df"
planets_df[positions,]