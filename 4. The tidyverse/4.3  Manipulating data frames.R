# 4.3  Manipulating data frames
library(dslabs)
library(dplyr)
data(murders)


# 4.3.1 Adding a column with `mutate`
murders <- mutate(murders, rate = total * 10^5 / population)
head(murders)

# 4.3.2 Subsetting with `filter`
filter(murders, rate <= 0.71)

# 4.3.3 Selecting columns with select
new_table <- select(murders, state, region, rate)
filter(new_table, rate <= 0.71)

#------------------------------

# 4.4 Exercises

# 1. Load the dplyr package and the murders dataset.
# Already done previously
# library(dplyr)
# library(dslabs)
# data(murders)

# You can add columns using the dplyr function mutate. This function is aware
# of the column names and inside the function you can call them unquoted:
murders <- mutate(murders, population_in_millions = population / 10^6)

# 2. If `rank(x)` gives you the ranks of x from lowest to highest, `rank(-x)`
# gives you the ranks from highest to lowest. Use the function mutate to add
# a column rank containing the rank, from highest to lowest murder rate.
# Make sure you redefine murders so we can keep using this variable.

murders <- mutate(murders, rank = rank(-rate))
murders[which.max(murders$rank), ]

# 3. With `dplyr`, we can use `select` to show only certain columns.
# For example, with this code we would only show the states and population
# sizes:
# select(murders, state, population) |> head()

# Use `select` to show the state names and abbreviations in murders.
# Do not redefine murders, just show the results.
select(murders, state, abb) |> head()

# 4. The `dplyr` function `filter` is used to choose specific rows of the
# data frame to keep. Unlike `select` which is for columns, `filter` is for
# rows. For example, you can show just the New York row like this:

# filter(murders, state == "New York")

# You can use other logical vectors to filter rows.
# Use `filter` to show the top 5 states with the highest murder rates.
# After we add murder rate and rank, do not change the murders dataset,
# just show the result. Remember that you can filter based on the rank column.

top_states <- murders[order(-murders$rate) |> head(), ]$state
filter(murders, state %in% top_states) |>
  (\(df) df[order(-df$rate), ])() |>
  head()

# 5. We can remove rows using the != operator. For example, to remove Florida,
# we would do this:

# no_florida <- filter(murders, state != "Florida")

# Create a new data frame called `no_south` that removes states from the
# South region. How many states are in this category? You can use the function
# `nrow` for this.
no_south <- filter(murders, region != "South")
nrow(no_south) # [1] 34

# 6. We can also use `%in%` to filter with `dplyr`. You can therefore see the
# data from New York and Texas like this:

# filter(murders, state %in% c("New York", "Texas"))

# Create a new data frame called `murders_nw` with only the states from the
# Northeast and the West. How many states are in this category?

murders_nw <- filter(murders, region %in% c("Northeast", "West"))
nrow(murders_nw) # [1] 22

# 7. Suppose you want to live in the Northeast or West and want the murder 
# rate to be less than 1. We want to see the data for the states satisfying
# these options. Note that you can use logical operators with filter. Here is
# an example in which we filter to keep only small states in the Northeast
# region.

# filter(murders, population < 5000000 & region == "Northeast")

# Make sure `murders` has been defined with `rate` and `rank` and still has
# all states. Create a table called `my_states` that contains rows for states
# satisfying both the conditions: it is in the Northeast or West and the 
# murder rate is less than 1. Use select to show only the state name, 
# the rate, and the rank.

filter(murders, region %in% c("Northeast", "West") & rate < 1) |>
  select(state, rate, rank)