#4. FACTORS

#4.1 What is a factor and why we use it?####

#Factors refer to a statistical data type used to store categorical values.
#The difference between a categorical variable and a continuous variable is that a categorical variable can belong to a limited number of categories.
#Create a vector that contains all the observations that belong to a limited number of categories
sex_vector <- c("Male", "Female", "Female", "Male", "Male")
#There're two categories here, or the "factor levels" here are "Male" and "Female"
#Convert sex_vector to a factor
factor_sex_vector <- factor(sex_vector)
#Print out to see the factor levels
factor_sex_vector #Levels: Female Male (1.4 Factor 1)

#There are two types of categorical variables: a nominal categorical variable and an ordinal categorical variable.
#A nominal variable is a categorical variable without an implied order.
animals_vector <- c("Elephant", "Giraffe", "Donkey", "Horse")
factor_animals_vector <- factor(animals_vector)
#It is impossible to say that 'one is worth more than the other
factor_animals_vector #levels: Donkey Elephant Giraffe Horse (1.4 Factor 2)
#In contrast, ordinal variables do have a natural ordering. 
temperature <-  c("High", "Low", "High", "Low", "Medium")
factor_temperature <- factor(temperature, ordered = TRUE, levels = c("Low", "Medium", "High"))
factor_temperature #levels: Low < Medium < High (screenshot 1.4 Factor 3)

#4.2 Factor levels####

#Some datasets contain factors with specific factor levels.
#To change the names of these levels for clarity: levels()
#E.g, the sex of the correspondents in a survey were recorded in short as "F" and "M"
survey_vector <- c("M", "F", "F", "M", "M")
factor_survey_vector <- factor(survey_vector)
#Specify the levels
levels(factor_survey_vector) <- c("Female", "Male")
#Print out the result
factor_survey_vector #[1] Male Female Female Male   Male Levels: Female Male

#4.3 Summarize a factor####

#You would like to know how many "Male" and "Female" responses to your survey
#Generate a summary for survey
summary(survey_vector) #this shows the length, class and mode of the dataset, not what you expect
#Generate a summary for the factored survey (1.4 Factor 4)
summary(factor_survey_vector) #Female 2  Male 3 
#"Male" and "Female" are nominal (unordered) factor levels and can't be compared.

#4.4 Ordered factors####

#Sometimes you will also deal with factors that do have natural ordering
#E.g, evaluate the performance of 5 data analysts as "slow", "medium" and "fast"
speed_vector <- c("medium", "slow", "slow", "medium", "fast")
#speed_vector should be converted into an ordinal factor since its categories have a natural ordering.
factor_speed_vector <- factor(speed_vector, ordered = TRUE, levels = c("slow", "medium", "fast"))
#By setting the argument "ordered" to TRUE, you indicate that the factor is ordered.
#with the argument "levels" you give the values of the factor in the correct order.
#Now you can compare elements in the vector
#Compare the performance of data analyst 2 and data analyst 5
da2 <- factor_speed_vector[2]
da5 <- factor_speed_vector[5]
da2 > da5 #FALSE