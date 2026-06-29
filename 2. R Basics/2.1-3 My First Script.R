library(tidyverse)
library(dslabs)
data(murders)

murders %>%
  ggplot(aes(population, total, label = abb, color = region))+ 
  geom_label()

# 2.2 The very basics

## 2.2.1 Objects

a <- 1
b <- 1
c <- -1

## 2.2.2 The workspace

ls()

(-b + sqrt(b^2 - 4*a*c)) / (2*a)
(-b - sqrt(b^2 - 4*a*c)) / (2*a)

## 2.2.3 Functions
log(8)
log(1)

help(log)
?log

args(log)

log(8, base = 2)
log(x = 8, base = 2)
log(8,2)

help("+")
help(">")

## 2.2.4 Other prebuilt objects
data()
co2

pi

Inf + 1

## 2.2.5 Variable names
solution_1 <- (-b + sqrt(b^2 - 4*a*c)) / (2*a)
solution_2 <- (-b - sqrt(b^2 - 4*a*c)) / (2*a)

# 2.3 Exercises
# 1. What is the sum of the first 100 positive integers? The formula for the 
# sum of integers 1 through n is n(n + 1)/2. Define n = 100 and then use R
# to compute the sum of 1 through 100 using the formula. What is the sum?

n <- 100
n*(n+1)/2

# 2. Now use the same formula to compute the sum of the integers from 1 
# through 1,000.
n <- 1000
n*(n+1)/2

# 3. Look at the result of typing the following code into R:
n <- 1000
x <- seq(1, n)
sum(x)

# 4. In math and programming, we say that we evaluate a function when we
# replace the argument with a given number. So if we type sqrt(4), 
# we evaluate the sqrt function. In R, you can evaluate a function inside 
# another function. The evaluations happen from the inside out. 
# Use one line of code to compute the log, in base 10, of the square root
# of 100.

log(sqrt(100),10)

# 5. Which of the following will always return the numeric value stored in x?
# You can try out examples and use the help system if you want.
log(10^3) # does not
log10(3^10) # does not
log(exp(3)) # does, as expected - default log is natural log
exp(log(3, base=2)) # does not
