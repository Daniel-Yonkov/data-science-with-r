# 5. data.table
# ref: https://rafalab.dfci.harvard.edu/dsbook-part-1/R/data-table.html#fn1

# 5.1 Refining data tables
library(dplyr)
library(dslabs)
library(data.table)

data(murders)
# coverts Data Frame to data.table
murders_dt <- as.data.table(murders)

# 5.1.1 Column-wise subsetting
# equivalence for selecting columns
select(murders, state, region)
murders_dt[, c('state', 'region')]
# using variables instead of string vector
murders_dt[, .(state, region)]

# 5.1.2 Adding or transforming variables
# equivalence of mutate
murders <- mutate(murders, rate = total * 10^5 / population)

# data.table uses an approach that avoids a new assignment (update by reference)
murders_dt[, rate := total * 10^5 / population]

# To define new multiple columns, we can use the := function with multiple arguments:
murders_dt[, ':='(rate = total * 10^5 / population,
                  rank = rank(population))]

# 5.1.3 Reference versus copy
# The data.table package is designed to avoid wasting memory.
x <- data.table(a = 1)
y <- x
# y references x, changes made to y, affect x

x[, a := 2]
y

y[, a := 1]
x

# to make a new object, use copy
x <- data.table(a = 1)
y <- copy(x)
x[, a := 2]
x
y

# Note that the function `as.data.table` creates a copy of the data frame being converted.
# However, if working with a large data frames it is helpful to avoid this by using `setDT`:

x <- data.frame(a = 1)
y <- setDT(x)

# 5.1.4 Row-wise subsetting
# filter equivalence
filter(murders, rate <= 0.7)

murders_dt[rate < 0.7]
# Notice that we can combine the filter and select into one succinct command
murders_dt[rate <= 0.7, .(state, region, rate)]

# -----------------------------------

# 5.2 Summarizing data
data(heights)
heights_dt <- as.data.table(heights)
heights_dt

# equivalence of summary
s <- heights |> summarize(avg = mean(height), sd = sd(height))
s

s_dt <- heights_dt[, .(avg = mean(height), sd = sd(height))]
s_dt

# Note that this permits a compact way of subsetting and then summarizing. Instead of:
s <- heights |>
  filter(sex == "Female") |>
  summarize(avg = mean(height), sd = sd(height))
s

s_dt <- heights_dt[sex == "Female", .(avg = mean(height), sd = sd(height))]
s_dt

# 5.2.1 Multiple summaries

# consider the following function from the previous chapter for multiple column summaries
median_min_max <- function(x) {
  qt <- quantile(x, c(0, 0.5, 1))
  data.frame(median = qt[2],
             min = qt[1],
             max = qt[3])
}

#equivalence

heights |>
  summarize(median_min_max(height))

heights_dt <- as.data.table(heights)
heights_dt[, .(median_min_max(height))]

# 5.2.2 Group then summarize

#equivalence

heights |>
  group_by(sex) |>
  summarise(avg = mean(height), sd = sd(height))

heights_dt[, .(avg = mean(height), sd = sd(height)), by = sex]

# -----------------------------------

# 5.3 Sorting

# equivalence
murders |>
  arrange(population) |>
  head()

head(murders_dt[order(population)])

# order change
murders |>
  arrange(-population) |>
  head()

# or
murders |>
  arrange(desc(population)) |>
  head()


head(murders_dt[order(-population)])

# or
head(murders_dt[order(population, decreasing = TRUE)])

# more than one column
murders |>
  arrange(population, rate) |>
  head()

head(murders_dt[order(population, rate)])

# -----------------------------------

# 5.4 Exercises

# 1. Load the `data.table` package and the murders dataset and convert it to `data.table`
# object:
library(data.table)
data(murders)
murders_dt <- as.data.table(murders)
# Remember you can add columns like this:
# murders_dt[, population_in_millions := population / 10^6]
# Add a murders column named rate with the per 100,000 murder rate as in the example code above.
murders_dt[, rate := total * 10^5 / population]
murders_dt[, .(rate)]

# 2. Add a column rank containing the rank, from highest to lowest murder rate.
murders_dt[, rank := frank(-rate)]
murders_dt[rank == 1, ]

# 3. If we want to only show the states and population sizes, we can use:

# murders_dt[, .(state, population)]

# Show the state names and abbreviations in murders.
murders_dt[, .(state, abb)]

# 4. You can show just the New York row like this:

# murders_dt[state == "New York"]

# You can use other logical vectors to filter rows.

# Show the top 5 states with the highest murder rates. From here on, do not change the murders dataset, just show the result.
# Remember that you can filter based on the rank column.

murders_dt[order(rank)][1:5]

# 5. We can remove rows using the `!=` operator. For example, to remove Florida, we would do this:

# no_florida <- murders_dt[state != "Florida"]

# Create a new data frame called `murders_nw` with only the states from the Northeast and the West.
# How many states are in this category?

murders_nw <- murders_dt[region %in% c("Northeast", "West")]
nrow(murders_nw)
# 22

# 7. Suppose you want to live in the Northeast or West and want the murder rate to be less than 1.
# We want to see the data for the states satisfying these options. Note that you can use logical operators with filter.
# Here is an example in which we filter to keep only small states in the Northeast region.

# murders_dt[population < 5000000 & region == "Northeast"]

# Make sure `murders` has been defined with rate and rank and still has all states. Create a table called `my_states` that
# contains rows for states satisfying both the conditions: they are in the Northeast or West and the murder rate is less than 1.
# Show only the state name, the rate, and the rank.
murders_dt[, ':='(rate = total * 10^5 / population,
                  rank = rank(population))]
murders_dt[, .(rate, rank)]

my_states <- murders_dt[region %in% c("Northeast", "West") &
                          rate < 1]
my_states[, .(state, rate, rank)]

# For exercises 8-12, we will be using the NHANES data.
library(NHANES)

# 8. We will provide some basic facts about blood pressure. First let’s select a group to set the standard.
# We will use 20-to-29-year-old females. AgeDecade is a categorical variable with these ages. Note that the category is coded
# like " 20-29", with a space in front! Use the `data.table` package to compute the average and standard deviation of systolic
# blood pressure as saved in the `BPSysAve` variable. Save it to a variable called ref.
NH_dt <- as.data.table(NHANES)
ref <- NH_dt[AgeDecade == " 20-29", .(avg = mean(BPSysAve, na.rm = TRUE),
                                      sd = sd(BPSysAve, na.rm = TRUE))]
ref

# 9. Report the min and max values for the same group.
NH_dt[AgeDecade == " 20-29", .(min = min(BPSysAve, na.rm = TRUE),
                               max = max(BPSysAve, na.rm = TRUE))]

# 10. Compute the average and standard deviation for females, but for each age group separately rather than a selected decade as
# in exercise 8. Note that the age groups are defined by AgeDecade.
NH_dt[Gender == "female", .(avg = mean(BPSysAve, na.rm = TRUE),
                            sd = sd(BPSysAve, na.rm = TRUE)), by = AgeDecade][is.na(AgeDecade) != TRUE][order(AgeDecade)]

# 11. Repeat exercise 10 for males.
NH_dt[Gender == "male", .(avg = mean(BPSysAve, na.rm = TRUE),
                          sd = sd(BPSysAve, na.rm = TRUE)), by = AgeDecade][!is.na(AgeDecade)][order(AgeDecade)]

# 12. For males between the ages of 40-49, compare systolic blood pressure across race as reported in the `Race1` variable.
# Order the resulting table from lowest to highest average systolic blood pressure.

NH_dt[AgeDecade == ' 40-49', .(avg = mean(BPSysAve, na.rm = TRUE)), by = Race1][order(avg)]
