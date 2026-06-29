# 3.1  Conditional expressions
a <- 0

if (a != 0) {
  print (1 / 0)
} else {
  print("no reciprocal for 0.")
}

library(dslabs)
data(murders)

murders_rate <- murders$total * 100000 / murders$population

# murder rate lower than 0.5 per 100.000

ind <- which.min(murders_rate)
if (murders_rate[ind] < 0.5) {
  print(murders$state[ind])
} else {
  print("No state has murder rate that low.")
}
#> [1] "Vermont"

if (murders_rate[ind] < 0.25) {
  print(murders$state[ind])
} else {
  print("No state has murder rate that low.")
}
# [1] "No state has murder rate that low."

# shorthand
ifelse(a > 0, 1 / a, NA)

a <- c(0, 1, 2, 3, -4, 5)
result <- ifelse(a > 0, 1 / a, NA)
result


# replace NAs

data(na_example)
no_nas <- ifelse(is.na(na_example), 0, na_example)
sum(is.na(no_nas))
# [1] 0

z <- c(TRUE, TRUE, FALSE)
any(z)
all(z)

#---------------------------------

# 3.2 Defining functions

avg <- function(x) {
  s <- sum(x)
  n <- length(x)
  s / n
}

x <- 1:100
identical(mean(x), avg(x))

# multiple parameters
avg <- function(x, arithmetic = TRUE) {
  n <- length(x)
  #if it's not arithmetic, then we provide a geometric mean
  ifelse(arithmetic, sum(x) / n, prod(x)^(1 / n))
}

#--------------------------------

# 3.3 Namespaces

# when having same name functions in different namespaces, we can
# force it's use by specifying the namespace

stats::filter(x, rep(1, 3))
dplyr::filter(murders, total > 400)

#--------------------------------

# 3.4 For-loops

compute_s_n <- function(n) {
  x <- 1:n
  sum(x)
}

for (i in 1:5) {
  print(i)
}

# The sum of the first 25 numbers each indenpendently
m <- 25
s_n <- vector(length = m) # creates an empty vector of m length
for (n in 1:m) {
  s_n[n] <- compute_s_n(n)
}

plot(1:m, s_n)

#--------------------------------

# 3.5 Vectorization and functionals

x <- 1:10
sqrt(x)
y <- 1:10
x * y

# We cannot use the approach above with `compute_s_n` as it expects scalar
# in it's current definition form

sapply(x, sqrt)

s_n <- sapply(1:m, compute_s_n)
plot(s_n)

#--------------------------------

# 3.6 Exercises

# 1. What will this conditional expression return?
# x <- c(1,2,-3,4)
# if(all(x>0)){
#   print("All Postives")
# } else{
#   print("Not all positives")
# }

# Answer:  Not all positives

# 2. Which of the following expressions is always FALSE when at least one
# entry of a logical vector x is TRUE?
# a. all(x)
# b. any(x)
# c. any(!x)
# d. all(!x)

# Answer: all(!x)
# Proof
all(!c(TRUE, FALSE, FALSE))

# 3. The function `nchar` tells you how many characters long a character
# vector is. Write a line of code that assigns to the object `new_names`
# the state abbreviation when the state name is longer than 8 characters.

new_names <- na.omit(ifelse(nchar(murders$state) > 8, murders$abb, NA))

# 4. Create a function `sum_n` that for any given value, say `n`, computes
# the sum of the integers from 1 to n (inclusive). Use the function to
# determine the sum of integers from 1 to 5,000.

sum_n <- function(n) {
  sum(1:n)
}
sum_n(5000)

# 5. Create a function `altman_plot` that takes two arguments, x and y,
# and plots the difference against the sum.

altman_plot <- function(x, y) {
  plot(x + y, x - y)
}

x <- 1:10
y <- x^2

altman_plot(x, y)

# 6. After running the code below, what is the value of x?
# x <- 3
# my_func <- function(y){
#   x <- 5
#   y+5
# }

# Answer: 3
# variable scope within function definition does not affect global scope

# 7. Write a function `compute_s_n` that for any given `n` computes the
# sum `Sn = 1^2 + 2^2 + 3^2 + ... n^2. Report the value of the sum when
# n = 10.

compute_s_n <- function(n) {
  sum((1:n)^2)
}
compute_s_n(10)
# Answer: 385

# 8. Define an empty numerical vector `s_n` of size 25 using
# `s_n <- vector("numeric", 25)` and store in the results of
# S1, S2, ..., S25 using a for-loop.

s_n <- vector(mode = "numeric", length = 25)

for (i in 1:25) {
  s_n[i] <- compute_s_n(i)
}
s_n

# 9. Repeat exercise 8, but this time use sapply.
sapply(1:25, compute_s_n)

# 10. Repeat exercise 8, but this time use map_dbl.
library(purrr)
map_dbl(1:25, compute_s_n)

# 11. Plot Sn versus n. Use points defined by n = 1, ..., 25.
plot(s_n, n <- 1:25)

# 12. Confirm that the formula for this sum is Sn = n(n + 1)(2n + 1)/6.
identical(compute_s_n(25), 25 * (25 + 1) * (2 * 25 + 1) / 6)
