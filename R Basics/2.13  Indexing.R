# 2.13  Indexing
library(dslabs)
data(murders)

murder_rate <- murders$total / murders$population * 100000
#  If we compare a vector to a single number, it actually performs the test
# for each entry
ind <- murder_rate < 0.71
# or
ind <- murder_rate <= 0.71
murders$state[ind]
# In order to count how many are TRUE
sum(ind)

# 2.13.2 Logical operators
west <- murders$region == "West"
safe <- murder_rate <= 1

ind <- west &
  safe # multiple logical operators on a similar subset of vectors
murders$state[ind]

# 2.13.3 which

ind <- which(murders$state == "California") #5L (5 as integer)
murder_rate[ind]

# 2.13.4 match

ind <- match(c("New York", "Florida", "Texas"), murders$state)
ind # #> [1] 33 10 44

murder_rate[ind]

# 2.13.5 %in%

c("Boston", "Dakota", "Washington") %in% murders$state

# 2.14 Exercises

# 1. Compute the per 100,000 murder rate for each state and store it in an
# object called `murder_rate`. Then use logical operators to create a logical
# vector named `low` that tells us which entries of `murder_rate` are lower
# than 1.

murder_rate <- murders$total * 100000 / murders$population
low <- murder_rate < 1

# 2. Now use the results from the previous exercise and the function `which`
# to determine the indices of `murder_rate` associated with values lower
# than 1.
which(low) #  [1] 12 13 16 20 24 30 35 38 42 45 46 51

# 3. Use the results from the previous exercise to report the names of the
# states with murder rates lower than 1.

murders$state[which(low)]
# [1] "Hawaii"        "Idaho"         "Iowa"          "Maine"
# [5] "Minnesota"     "New Hampshire" "North Dakota"  "Oregon"
# [9] "South Dakota"  "Utah"          "Vermont"       "Wyoming"

# 4. Now extend the code from exercises 2 and 3 to report the states in the
# Northeast with murder rates lower than 1. Hint: use the previously defined
# logical vector low and the logical operator &.

murders$state[low & murders$region == "Northeast"]
# [1] "Maine"         "New Hampshire" "Vermont"

# 5. In a previous exercise we computed the murder rate for each state and
# the average of these numbers. How many states are below the average?

avg <- mean(murder_rate)
sum(murder_rate < avg) # [1] 27

# 6. Use the match function to identify the states with abbreviations
# AK, MI, and IA. Hint: start by defining an index of the entries of
# `murders$abb` that match the three abbreviations, then use the `[`
# operator to extract the states.

abb_ind <- match(c("AK", "MI", "IA"), murders$abb)
murders$state[abb_ind] # [1] "Alaska"   "Michigan" "Iowa"

# 7. Use the `%in%` operator to create a logical vector that answers the
# question: which of the following are actual abbreviations: MA, ME, MI, MO,
# MU?

abb <- c("MA", "ME", "MI", "MO", "MU")
abb[abb %in% murders$abb] # [1] "MA" "ME" "MI" "MO"

murders$state[match(abb[abb %in% murders$abb], murders$abb)]
# [1] "Massachusetts" "Maine"         "Michigan"      "Missouri"

# 8. Extend the code you used in exercise 7 to report the one entry that is
# not an actual abbreviation. Hint: use the `!` operator, which turns FALSE
# into TRUE and vice versa, then `which` to obtain an index.

abb[which(!(abb %in% murders$abb))] # 1] "MU"
