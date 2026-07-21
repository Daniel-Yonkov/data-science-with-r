# 1. Define variables containing the heights of males and females like this:
library(dslabs)
data(heights)

male <- heights$height[heights$sex == "Male"]
female <- heights$height[heights$sex == "Female"]

# How many measurements do we have for each?
length(male) # [1] 812
length(female) # [1] 238

# 2. Suppose we can’t make a plot and want to compare the distributions side by 
# side. We can’t just list all the numbers. Instead, we will look at the 
# percentiles. In Section 7.4 we defined percentiles as the values for which 
# p = 0.01, 0.02, ... , 0.99 of the data are less than or equal to that value. 
# The quantile function, which we used in Chapter 4 and Chapter 5, is a 
# generalization: `quantile(x, p)` returns the value for which proportion p of 
# the data in x are at or below, for any p between 0 and 1. Percentiles are the 
# special case where p is one of 0.01, 0.02, ... , 0.99, for example, 
# `quantile(x, 0.10)` gives the 10th percentile. You can pass a vector of 
# proportions to get several percentiles at once:
quantile(male, c(0.10, 0.30, 0.50, 0.70, 0.90))

# Use this to create a five-element vector `female_percentiles` and a 
# five-element vector `male_percentiles` containing the 10th, 30th, 50th, 70th, 
# and 90th percentiles for each sex. Then create a data frame with these two 
# vectors as columns.
female_percentile <- quantile(female, c(0.1, 0.3, 0.5, 0.7, 0.9))
male_percentile <- quantile(male, c(0.1, 0.3, 0.5, 0.7, 0.9))
percentiles <- data.frame(female_percentile, male_percentile)

# 3. Study the following boxplots showing population sizes by country:
# see exercises 3 image.png

# Which continent has the country with the biggest population size?
# Answer: Asia

# 4. What continent has the largest median population size?
# see exercises 3 image.png
# Answer: Africa

# 5. What is median population size for Africa to the nearest million?
# see exercises 3 image.png
# Answer: 10m

# 6. What proportion of countries in Europe have populations below 14 million?
# see exercises 3 image.png
# a) 0.99
# b) 0.75
# c) 0.50
# d) 0.25
# Answer: Since the 75% is around 10% of the log10 I would say it's about 75% - b)

# 7. If we use a log transformation, which continent shown above has the largest
# interquartile range?
# see exercises 3 image.png
# Answer: Americas

# 8. Load the height data set and create a vector x with just the male heights:
x <- heights$height[heights$sex == "Male"]

# What proportion of the data is between 69 and 72 inches (taller than 69, but
# shorter or equal to 72)? Hint: use a logical operator and mean.

mean(x >= 69 & x <= 72)
# Answer: 42%
