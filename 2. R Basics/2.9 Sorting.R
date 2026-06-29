# 2.9.1 sort
library(dslabs)
data(murders)
sort(murders$total)

# 2.9.2 order

x <- c(31, 4, 15, 92, 65)
index <- order(x)
x[index]

# ordering the state by the number of murders
ind <- order(murders$total)
murders$abb[ind]

# 2.9.3 max and which.max

max(murders$total)
i_max <- which.max(murders$total)
murders$state[i_max]

min(murders$total)
i_min <- which.min(murders$total)
murders$state[i_min]

#2.9.4 rank
rank(x)

# 2.9.5 Beware of recycling
x <- c(1, 2, 3)
y <- c(10, 20, 30, 40, 50, 60, 70)
x + y # Notice the warning message for length mismatch
# notice how the result gets recurring addition of the shortest length vector

# 2.10 Exercises
# For these exercises we will use the US murders dataset.
# Make sure you load it prior to starting.

# 1. Use the `$` operator to access the population size data and store it as
# the object pop. Then use the sort function to redefine pop so that it is
# sorted. Finally, use the `[` operator to report the smallest population
# size.

pop <- murders$population
sort(pop)[1]
# 563626

# 2. Now instead of the smallest population size, find the index of the
# entry with the smallest population size. Hint: use `order` instead of sort.

order(pop)[1]
# 51

# 3. We can actually perform the same operation as in the previous exercise
# using the function `which.min`. Write one line of code that does this.

which.min(pop)
# 51

# 4. Now we know how small the smallest state is and we know which row
# represents it. Which state is it? Define a variable states to be the state
# names from the murders data frame. Report the name of the state with the
# smallest population.

states <- murders$state
states[which.min(pop)]
# [1] "Wyoming"

# 5. You can create a data frame using the `data.frame` function.
# Here is a quick example:
temp <- c(35, 88, 42, 84, 81, 30)
city <- c("Beijing",
          "Lagos",
          "Paris",
          "Rio de Janeiro",
          "San Juan",
          "Toronto")
city_temps <- data.frame(name = city, temperature = temp)

# Use the `rank` function to determine the population rank of each state
# from smallest population size to biggest. Save these ranks in an object
# called ranks, then create a data frame with the state name and its rank.
# Call the data frame my_df.
ranks <- rank(pop)
my_df <- data.frame(name = murders$state, rank = ranks)
my_df

# 6. Repeat the previous exercise, but this time order my_df so that the
# states are ordered from least populous to most populous.
# Hint: create an object ind that stores the indexes needed to order the
# population values. Then use the bracket operator
# `[` to re-order each column in the data frame.
ind <- order(pop)
my_df[ind, ]

# 7. The na_example vector represents a series of counts. You can quickly
# examine the object using:

data("na_example")
str(na_example)
# However, when we compute the average with the function `mean`, we obtain an NA:
mean(na_example)

# The `is.na` function returns a logical vector that tells us which entries
# are `NA`. Assign this logical vector to an object called ind and determine
# how many NAs does na_example have.
ind <- is.na(na_example)
length(ind)
# Answer: 1000

# 8. Now compute the average again, but only for the entries that are not
# NA. Hint: remember the ! operator.

mean(na_example[!ind])
# [1] 2.301754
