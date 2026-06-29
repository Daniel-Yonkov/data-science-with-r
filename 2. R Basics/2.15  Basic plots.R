# 2.15  Basic plots
library(dslabs)
data(murders)

# 2.15.1 plot
x <- murders$population / 10^6
y <- murders$total
plot(x, y)

with(murders, plot(population, total))

# 2.15.2 hist
x <- with(murders, total / population * 100000)
hist(x)
# an outlier with more than 15 murders per 100.000
murders$state[which.max(x)]

# 2.15.3 boxplot

murders$rate <- with(murders, total / population * 100000)
boxplot(rate ~ region, murders)

# 2.15.4 image
x <- matrix(1:120, 12, 10)

image(x)

# 2.16 Exercises
# 1. We made a plot of total murders versus population and noted a strong
# relationship. Not surprisingly, states with larger populations had more
# murders.

library(dslabs)
data(murders)
population_in_millions <- murders$population / 10^6
total_gun_murders <- murders$total
plot(population_in_millions, total_gun_murders)

# Keep in mind that many states have populations below 5 million and are
# bunched up. We may gain further insights from making this plot in the
# log scale. Transform the variables using the `log10` transformation and then
# plot them.
plot(log10(murders$population), log10(total_gun_murders))

# 2. Create a histogram of the state populations.
hist(log10(murders$population))

# 3. Generate boxplots of the state populations by region.
boxplot(population ~ region, murders)
