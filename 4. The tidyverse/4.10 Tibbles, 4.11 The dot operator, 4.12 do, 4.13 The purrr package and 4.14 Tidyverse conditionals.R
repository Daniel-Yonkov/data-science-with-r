# 4.10 Tibbles
library(tidyverse)
library(dslabs)
data(murders)

murders |> group_by(region)

murders |> group_by(region) |> class()

# Tibbles are very similar to data frames. In fact, you can think of them as a modern version
# of data frames. Nonetheless there are three important differences which we describe in the
# next.

# 4.10.1 Tibbles display better
murders
as_tibble(murders) #  If using RStudio, output for a tibble adjusts to your window size

# 4.10.2 Subsets of tibbles are tibbles
class(murders[, 4]) # population
class(as_tibble(murders)[, 4])
# With tibbles, if you want to access the vector that defines a column, and not get back a
# data frame, you need to use the accessor $:
class(as_tibble(murders)$population)

# Null safety in tibbles
murders$Population
as_tibble(murders)$Population

# 4.10.3 Tibbles can have complex entries
# While data frame columns need to be vectors of numbers, strings, or logical values, tibbles
# can have more complex objects, such as lists or functions

tibble(id = c(1, 2, 3), func = c(mean, median, sd))

# 4.10.4 Tibbles can be grouped
# The function group_by returns a special kind of tibble: a grouped tibble. This class stores
#  information that lets you know which rows are in which groups

# 4.10.5 Create a tibble using `tibble` instead of `data.frame`

grades <- tibble(
  names = c("Jonh", "Juan", "Jean", "Yao"),
  exam_1 = c(95, 80, 90, 85),
  exam_2 = c(90, 85, 85, 90)
)

# ----------------------------------

# 4.11 The dot operator
# !! legacy placeholder operator is `.` for new pipe operator is `_`
rates <- filter(murders, region == "South") %>%
  mutate(rate = total * 10^5 / population) %>%
  .$rate
mean(rates)

# equivalent
rates <- filter(murders, region == "South") |>
  mutate(rate = total * 10^5 / population) |>
  pull(rate)

mean(rates)

# for new pipe operator
2 |> log(8, base = _)

# ----------------------------------

# 4.12 do

# The do function serves as a bridge between R functions such as quantile and the tidyverse.
# The do function understands grouped tibbles and always returns a data frame.
data(heights)

my_summary <- function(data) {
  x <- quantile(data$height, c(0, 0.5, 1))
  tibble(min = x[1],
         median = x[2],
         max = x[3])
}

# does not provide by gender information
heights |>
  group_by(sex) |>
  my_summary()


# does provide by gender information
heights |>
  group_by(sex) |>
  do(my_summary(.))

# ----------------------------------

# 4.13 The purrr package
# purrr functions will return objects of a specified type or return an error if this is not
# possible.

library(purrr)
compute_s_n <- function(n) {
  x <- 1:n
  sum(x)
}
n <- 1:25
s_n <- map(n , compute_s_n) # returns a list
unlist(s_n, use.names = FALSE) # to convert to vector or
#equivalent
map_dbl(n, compute_s_n)

# A particularly useful purrr function for interacting with the rest of the tidyverse is
# map_df, which always returns a tibble data frame. However, the function being called needs
# to return a vector or a list with names

compute_s_n <- function(n) {
  x <- 1:n
  tibble(sum = sum(x))
}

map_df(n, compute_s_n)

# ----------------------------------

# 4.14 Tidyverse conditionals

# 4.14.1 case_when

x <- c(-2, -1, 0, 1, 2)
case_when(x < 0 ~ "Negative", x > 0 ~ "Positive", TRUE ~ "Zero")

# we want to compare the murder rates in three groups of states: New England, West Coast,
# South, and other

murders |>
  mutate(
    group = case_when(
      abb %in% c("ME", "NH", "VT", "MA", "RI", "CT") ~ "New England",
      abb %in% c("WA", "OR", "CA") ~ "West Coast",
      region == "South" ~ "South",
      TRUE ~ "Other"
    )
  ) |>
  group_by(group) |>
  summarise(rate = sum(total) * 10^5 / sum(population))

# 4.14.2 between
a <- 0
b <- 10
x <- 5
between(x, a, b)

# ----------------------------------

# 4.15 Exercises

# 1. Load the murders dataset. Which of the following is true?
# a. murders is in tidy format and is stored in a tibble.
# b. murders is in tidy format and is stored in a data frame.
# c. murders is not in tidy format and is stored in a tibble.
# d. murders is not in tidy format and is stored in a data frame.
data(murders)

class(murders)
head(murders)
# Answer: b

# 2. Use `as_tibble` to convert the murders data table into a tibble and save it in an object
# called murders_tibble.
murders_tibble <- as_tibble(murders)

# 3. Use the `group_by` function to convert murders into a tibble that is grouped by region.
murders |>
  group_by(region)

# 4. Write tidyverse code that is equivalent to this code:
# exp(mean(log(murders$population)))
# Write it using the pipe so that each function is called without arguments. Use the dot
# operator to access the population. Hint: The code should start with murders %>%.

murders |>
  pull(population) |>
  map_dbl(log) |>
  map_dbl(mean) |>
  map_dbl(exp)

# 5. Use the `map_df` to create a data frame with three columns named `n`, `s_n`, and `s_n_2`.
# The first column should contain the numbers 1 through 100. The second and third columns
# should each contain the sum of 1 through n with n the row number.
sum_f <- function(n) {
  x <- 1:n
  tibble(n = n, sum(x), sum(x)^2)
}

map_df(1:100, sum_f)
