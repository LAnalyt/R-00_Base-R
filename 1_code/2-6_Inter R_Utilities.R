# 6. UTILITIES

# 6.1 Mathematical utilities ####

# Create 2 vectors v1 and v2:
v1 <- c(1.1, -7.1, 5.4, -2.7)
v2 <- c(-3.6, 4.1, 5.8, -8.0)

# abs(): calculates the absolute value of an array of a numerical value.
abs(v1)
abs(v2) # return positive value of all elements.

# round(): rounds up the input.
round(abs(v1))
round(abs(v2)) # rounds up all the decimal numbers.

# sum(): computes the sum of the input array.
sum(round(abs(v1))) 
sum(round(abs(v2))) 

# mean(): calculates the arithmetic mean. Mean() in R is capable of handling different types of objects, but most commonly on numerical arrays.
mean(c(16,22)) 
# This is equally the bulky arithmetic one-liner.
mean(c(sum(round(abs(v1))), sum(round(abs(v2)))))

# E.g, create a vector representing the errors made by your training model:
errors <- c(1.9, -2.6, 4.0, -9.5, -3.4, 7.3)
# Calculate the sum of the absolute rounded value of the training errors:
sum(round(abs(errors))) 

# 6.2 Functions for data structures ####

# seq(): generates a sequence of numbers.
seq(8, 2, by = -2) # first arguments tell the start and end of the sequence respectively. The "by" argument specifies the increment value for the sequence on each step.
# E.g.,calculating the sum of an arithmetic series:
seq1 <- seq(1, 500, by = 3)
seq2 <- seq(1200, 900, by = -7)
sum(c(seq1, seq2))

# rep(): replicate the input, which typically is a vector or a list.
rep(c(8, 6, 4, 2), times = 2) # "times" argument specifies how the replication should happen.
rep(c(8, 6, 4, 2), each = 2) # with "each" argument, every element gets repeated.

# sort(): a generic function for sorting and input vector. It could be used on numerical values, but also on character and logical vectors.
sort(c(8, 6, 4, 2, 8, 6, 4, 2)) # sorting in increasing order.
sort(c(8, 6, 4, 2, 8, 6, 4, 2), decreasing = TRUE) # reverse order.

# Create a list of different data types:
li <- list(log = TRUE,
           ch = "hello",
           int_vec = sort(rep(seq(8, 2, by = -2), times = 2)))
# str(): see the data structure in a concise way.
str(li)

# is.*(): check the type of the structure.
is.list(li) # return a logical.
is.list(c(1, 2 ,3)) 

# as.*(): convert into different type of data.
li2 <- as.list(c(1, 2, 3))
is.list(li2)

# rev(): reverse elements in a data structure.
rev(li)
# append(): add elements to a vector or a list in a readable way.
li3 <- append(li, rev(li)) # create a list of double li's length.
# Inspect the structure again:
str(li3)

# 6.3 Data utilities ####

# Use again the example of the social media profile views data with LinkedIn and Facebook view counts for the last seven days. 
linkedin <- list(16, 9, 13, 5, 2, 17, 14)
facebook <- list(17, 7, 5, 16, 8, 13, 14)
# Convert both linkedin and facebook lists to a vector:
li_vec <- unlist(linkedin)
fb_vec <- unlist(facebook)
# Append fb_vec to li_vec:
social_vec <- append(li_vec, fb_vec)
# Sort social_vec from high to low:
sort(social_vec, decreasing = TRUE)

# 6.4 Regular expressions ####

# Regular expression is a sequence of characters and metacharacters that form a search pattern which you can use to match strings.

# grep(), grepl(): search for matches to argument pattern within each element of a character vector.
animals <- c("cats", "mouse", "impala", "ant", "kiwi")
# With grepl(), e.g, we can determine which animal has an "a" in their name. The 1st argument is the pattern, 2nd argument is the character vector where matches are sought.
grepl(pattern = "a", x = animals) # returns a logical vector.
# Match for a string that starts with an "a":
grepl(pattern = "^a", x = animals)
# Match for a string that ends with an "a":
grepl(pattern = "a$", x = animals)
# grep() returns the indices of the elements of the x that yield a match.
grep(pattern = "a", x = animals) # returns indices for TRUE value.
# Use which() to get a similar answer:
which(grepl(pattern = "a", x = animals))
# Similarly, grep() can find the value in the vector that begins or ends with "a".
grep(pattern = "^a", x = animals)
grep(pattern = "a$", x = animals)
# E.g, query and manipulate a character vector of email addresses:
emails <- c("john.doe@ivyleague.edu", "education@world.gov", "dalai.lama@peace.org", "invalid.edu", "quant@bigdatacollege.edu", "cookie.monster@sesame.tv")
# Generate a vector of logicals that indicates whether these email addresses contain "edu":
grepl(pattern = "edu", x = emails)
# Save the resulting indexes:
hits <- grep(pattern = "edu", x = emails)
# Subset emails with "edu" in it using the index:
emails[hits] # "education@world.gov" is also subsetted.
# Match only the ".edu" email addresses from our list of emails:
grepl(pattern = "@.*\\.edu$", x = emails) 
hits <- grep(pattern = "@.*\\.edu$", x = emails)
emails[hits]
# Metacharacters used in regular expressions:
# @, because a valid email must contain an @ sign.
# .*, which matches any character (.) zero or more times (*).
# \\.edu$, to match the ".edu" part of the email at the end of the string. The \\ part escapes the dot: it tells R that you want to use the . as an actual character.

# sub(), gsub(): replace the matches with other strings.
sub(pattern = "a", replacement = "o", x = animals)
# The 3rd animal name "impala" was replaced with "impola" instead of "impolo", because as soon as sub() finds the matches, it replaces it with the replacement argument, then immediately stop looping. 
# Use gsub() instead to replace entirely all matches:
gsub(pattern = "a", replacement = "o", x = animals)
# Locating the pattern with "a" or "i":
gsub(pattern = "a|i", replacement = "_", x = animals)
# Continue the "emails" example, supposing you want to convert the "edu" domains to "datacamp.edu":
sub(pattern = "@.*\\.edu$", replacement = "@datacamp.edu", x = emails)

# More example on sub():
awards <- c("Won 1 Oscar.",
            "Won 1 Oscar. Another 9 wins & 24 nominations.",
            "1 win and 2 nominations.",
            "2 wins & 3 nominations.",
            "Nominated for 2 Golden Globes. 1 more win & 2 nominations.",
            "4 wins & 1 nomination.")
sub(".*\\s([0-9]+)\\snomination.*$", "\\1", awards)
# Other meta-characters being used in regular expressions:
# \\s: match a space. The "s" is normally a character, escaping it (\\) makes it a meta-character.
# [0-9]+: Match the numbers 0 to 9, at least once (+).
# ([0-9]+): The () are used to make parts of the matching string available to define the replacement. The \\1 in the replacement argument of sub() gets set to the string that is captured by the regular expression [0-9]+.