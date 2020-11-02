# 4. R PACKAGES

# R packages are bundles of code, data, documentation, and tests that are easy to share with others. E.g, the mean(), list() and sample() functions are part of the Base R package, which contains the basic functionality to use R.

# 4.1 Install packages ####

# Base R package is automatically installed and loaded. The package for data visualization, e.g, has to be installed and loaded manually
install.packages("ggvis") # this function goes to CRAN, download and install the package in your system.

# 4.2 Load packages ####

# When R loads a package, it actually attaches it to the search list
search() # list of packages and environments that R looks through to find the variable or function you want to use.
# GlobalEnv: workspace, where the user-defined R objects are stored.
# Try to access a function in the installed ggvis packages
ggvis(mtcars, ~wt, ~hp) # return an error, because ggvis is not yet in the search list.
# Load ggvis manually
library("ggvis")
# Check once more
search() # ggvis is now a part of the list.
# Run the ggvis function again
ggvis(mtcars, ~wt, ~hp) # print out a graph.

# Another way to load packages is to use require() function for loading packages that are not yet installed
require("data.table") # return a warning if attaching package fails.
# Check if the package is already attached
(result <- require("data.table")) # TRUE/FALSE
# This is a good alternative to avoid errors when attaching dynamically packages inside functions.

# Load ggplot2 package
require("ggplot2")
# Build a plot of two variables of the mtcars data frame using quick plot function from the package ggplot2
qplot(mtcars$wt, mtcars$hp)
