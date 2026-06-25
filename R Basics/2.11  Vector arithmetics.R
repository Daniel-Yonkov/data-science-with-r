# 2.11 Vector arithmetics

library(dslabs)
data(murders)
# california has the most population as well as the most murders.
# This affects the ratio
murders$state[which.max(murders$population)]

# 2.11.1 Rescaling a vector
inches <- c(69, 62, 66, 70, 70, 73, 67, 73, 67, 70)
#Inches to cm
inches * 2.54

# above 69 inches
inches - 69

# 2.11.2 Two vectors

murders_rate <- murders$total / murders$population * 100000
# When comparing number of murders to total population ratio 
# (increased by a factor of 100.000), we see that California is no longer
# on first position
murders$abb[order(murders_rate)]

# 2.12 Exercises

# 1. Previously we created this data frame:
temp <- c(35, 88, 42, 84, 81, 30)
city <- c("Beijing", "Lagos", "Paris", "Rio de Janeiro",
          "San Juan", "Toronto")
city_temps <- data.frame(name = city, temperature = temp)

# Remake the data frame using the code above, but add a line that converts
# the temperature from Fahrenheit to Celsius. The conversion is 
# C = 59 × (F − 32).

city_temps <- data.frame(name = city, temperatures = (temp - 32) * 5/9)
city_temps

# 2. What is the following sum 1 + 1/2^2 + 1/3^2 + . . . 1/100^2? 
# Hint: thanks to Euler, we know it should be close to π2 /6.

sum(1/(1:100)^2)  # [1] 1.634984
pi^2/6 # [1] 1.644934

# 3. Compute the per 100,000 murder rate for each state and store it in the
# object murder_rate. Then compute the average murder rate for the US using
# the function `mean`. What is the average?

murder_rate <- murders$total*100000/murders$population
mean(murder_rate) # [1] 2.779125
