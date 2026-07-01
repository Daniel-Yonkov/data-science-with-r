# 4.5  The pipe: %>%
library(dslabs)
library(dplyr)
data(murders)

murders <- mutate(murders, rate = total * 10^5 / population)

murders %>% select(state, region, rate) %>% filter(rate <= 0.71)

16 %>% sqrt()

16 %>% sqrt() %>% log2()

# pipe sends values to the first argument
16 %>% sqrt() %>% log(base = 2)

# 4.6 Exercises

# 1. The pipe `%>%` can be used to perform operations sequentially without
# having to define intermediate objects. Start by redefining murder to include
# rate and rank.

murders <- mutate(murders,
                  rate = total / population * 100000,
                  rank = rank(-rate))

# In the solution to the previous exercise, we did the following:

# my_states <- filter(murders, region %in% c("Northeast", "West") &
#                       rate < 1)
# select(my_states, state, rate, rank)

# The pipe `%>%` permits us to perform both operations sequentially without
# having to define an intermediate variable `my_states`. We therefore could
# have mutated and selected in the same line like this:

# mutate(murders, rate = total / population * 100000,
#        rank = rank(-rate)) %>%
#   select(state, rate, rank)

# Notice that select no longer has a data frame as the first argument.
# The first argument is assumed to be the result of the operation conducted
# right before the `%>%`.

# Repeat the previous exercise, but now instead of creating a new object,
# show the result and only include the `state`, `rate`, and `rank` columns.
# Use a pipe `%>%` to do this in just one line.

# Already done by mistake in the previous exercise

## Create a table called `my_states` that contains rows for states
# satisfying both the conditions: it is in the Northeast or West and the
# murder rate is less than 1. Use select to show only the state name,
# the rate, and the rank.

filter(murders, region %in% c("Northeast", "West") & rate < 1) |>
  select(state, rate, rank)

# 2. Reset `murders` to the original table by using `data(murders)`. Use a
# pipe to create a new data frame called `my_states` that considers only
# states in the Northeast or West which have a murder rate lower than 1,
# and contains only the state, rate and rank columns. The pipe
# should also have four components separated by three `%>%`.

data(murders)
my_states <- murders |>
  mutate(rate = total * 10^5 / population, rank = rank(-rate)) |>
  filter(region %in% c("Northeast", "West") & rate < 1) |>
  select(state, rate, rank)

my_states
