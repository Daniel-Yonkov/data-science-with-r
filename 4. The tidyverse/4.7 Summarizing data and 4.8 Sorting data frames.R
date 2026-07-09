# 4.7 Summarizing data

# 4.7.1 summarize
library(dplyr)
library(dslabs)
data(heights)

# computes the average and standard deviation for females
a <- heights |>
  filter(sex == "Female") |>
  summarise(average = mean(height),
            std_deviation = sd(height))
a

#  add the median, minimum, and maximum heights

heights |>
  filter(sex == "Female") |>
  summarise(
    median = median(height),
    minimum = min(height),
    maximum = max(height)
  )

# If we do not care about names, we can archive the same with a single line using `reframe`
# instead of `summarize`

heights |>
  filter(sex == "Female") |>
  reframe(range = quantile(height, c(0, 0.5, 1)))

# We can obtain these three named values using a function and summarize
median_min_max <- function(data) {
  qs <- quantile(data, c(0, 0.5, 1))
  data.frame(median = qs[2],
             min = qs[1],
             max = qs[3])
}

heights |>
  summarise(median_min_max(height))

data(murders)

# modifiyng / adding columns

murders <- murders |> mutate(rate = total * 10^5 / population)
murders

# average murder rate for the United States
murders |>
  summarise(mean = mean(rate)) # this gives the same rate for all states, which is not valid

us_murder_rate <- murders |>
  mutate(rate = sum(total) * 10^5 / sum(population)) |>
  summarise(mean = mean(rate))

us_murder_rate$mean

# 4.7.2 `pull`

#  when a data object is piped that object and its columns can be accessed using the
# `pull` function

us_murder_rate |> pull(mean)

# To get a number from the original data table with one line of code we can type:
us_murder_rate <- murders |>
  summarise(rate = sum(total) * 10^5 / sum(population)) |>
  pull(rate)
us_murder_rate

# 4.7.3 Group then summarize with `group_by`

# compute the average and standard deviation for men’s and women’s heights separately.
# The `group_by` function helps us do this.

heights |>
  group_by(sex) |>
  summarise(avg = mean(height),
            min = min(height),
            max = max(height))

# compute the median murder rate in the four regions of the country

murders |>
  group_by(region) |>
  summarise(median_rate = median(rate))

# -------------------------------------

# 4.8 Sorting data frames
murders |>
  arrange(population) |>
  #  # arrange by default in ascending order / use `desc` for descending order
  # arrange(desc(population)) |>
  # or simply use `-` to define the descending order
  # arrange(-population) |>
  head()

# 4.8.1 Nested sorting

# If we are ordering by a column with ties, we can use a second column to break the tie.
# Similarly, a third column can be used to break ties between first and second and so on.
# Here we order by region, then within region we order by murder rate:

murders |>
  arrange(region, rate) |>
  head()

# 4.8.2 The `top` n

# Note that rows are not sorted by rate, only filtered. If we want to sort, we need to use
# `arrange`. Note that if the third argument is left blank, `top_n`, filters by the 
# last column.
murders |> top_n(5)

# equivalent
murders |> slice_min(rate, n=5) # with sorting in asc order
murders |> slice_max(rate, n=5) # with sorting in desc order
