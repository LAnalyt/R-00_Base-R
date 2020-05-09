# FACTORS ####

## Intro to factors ====

# In R, factor vectors store data that falls into a finite number of categories.
v <- c("a", "b", "c")
factor(v) #printed without quote " "
# The levels of a factore are the possible categories, and are printed along with the data
btype <- c("a", "ab", "o", "b", "a")
factor(btype)
# When R prints factor it displays each vector element first, followed by the levels in the factor in alphabetical order.
v <- c("red", "red", "blue")
factor(v)
# You can view them with levels()
v <- c("y", "x", "z", "y")
f <- factor(v)
levels(f)
# You can rename the levels. When you change the levels of a factor, it also changes how the data is printed to use the new levels
v <- c("r", "b", "b")
f <- factor(v)
levels(f) <- c("blue", "red")
levels(f)

## Summarizing categorical data ====

# Storing data in a factor can let you do useful things, like see the counts of each category with the summary() function
v <- c("a", "a", "b", "c")
f <- factor(v)
summary(f)
# You can subset a factor with []. The levels are still displayed
v <- c("x", "y", "z")
factor(v)[1]
# Strings can be compared alphabetically
"a" > "z" #FALSE
"ab" < "bc" #TRUE
# If factors have no ranking of levels, the comparison will result a NA and a warning
v <- c("a", "b")
f <- factor(v)
f[1] <f[2]

## Ordered factor ====

# R can't comapre factors without an implied order
v <- c("low", "high", "med")
f <- factor(v)
f[1] < f[2] #NA
# R represents ordinal variables as ordered factors, using the ordered argument to factor(). R orders alphabetically.
speed <- c("low", "high", "med", "med")
factor(speed, ordered = TRUE)
# To explicitly tell R the levels of a factor, add the levels argument to factor()
speed <- c("low", "high", "med", "med")
factor(speed, levels = c("low", "med", "high"))
# If you specify both order = TRUE and levels, R uses the order of levels
heights <- c("tallest", "short", "tall", "tall")
factor(heights, ordered = TRUE, levels = c("tallest", "tall", "short"))
# Now you can compare factors
v <- c("low", "high", "med")
f <- factor(v, ordered = TRUE, levels = c("low", "med", "high"))
f[1] < f[2] #TRUE

