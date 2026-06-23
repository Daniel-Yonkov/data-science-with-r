# 2.4 Data types
a <- 2
class(a)

# 2.4.1 Data frames
library(dslabs)
data(murders)

class(murders)

# 2.4.2 Examining an object
str(murders)
head(murders)

# 2.4.3 The accessor: $

murders$population
names(murders)

# 2.4.4 Vectors: numerics, characters, and logical
pop <- murders$population
length(pop)

class(pop)

class(murders$state)

z <- 3 == 2
z

class(z)

?Comparison

# 2.4.5 Factors

class(murders$region)
levels(murders$region)

region <- murders$region
value <- murders$total
region <- reorder(region, value, FUN=sum)
levels(region)

# 2.4.6 Lists
record = list()
record$name = "Jonh Doe"
record$student_id = 1234
record$grades = c(95,82,91,97,93)
record$final_grade = "A"

class(record)

record

record[["student_id"]]

record2 = list()
record2[[1]] = "Jonh Doe"
record2[[2]] = 1234
record2

# 2.4.7 Matrices
mat <- matrix(1:12, 4, 3)
mat
mat[2,3]
mat[2,]
mat[,3]
mat[,2:3]
mat[1:2, 2:3]

as.data.frame(mat)

murders[25,1]
murders[2:3,]


# 2.5 Exercises

# 1. Load the US murders dataset.
library(dslabs)
data(murders)

# Use the function `str` to examine the structure of the murders object. 
# Which of the following best describes the variables represented in this data frame?

 # a. The 51 states.
 # b. The murder rates for all 50 states and DC.
 # c. The state name, the abbreviation of the state name, the state’s region,
# and the state’s population and total number of murders for 2010.
 # d. str shows no relevant information.

str(murders)
# Answer: c

# 2. What are the column names used by the data frame for 
# these five variables?
names(murders) # [1] "state"  "abb"  "region"   "population" "total"

# 3. Use the accessor `$` to extract the state abbreviations and assign
# them to the object a. What is the class of this object?
a <- murders$abb
class(a) # [1] "character"

# 4. Now use the square brackets to extract the state abbreviations and
# assign them to the object b. Use the identical function to determine
# if a and b are the same.

b <- murders[,2]
a == b # Logical (true) vector

# 5. We saw that the region column stores a factor. You can corroborate
# this by typing:
class(murders$region) # [1] "factor"

# With one line of code, use the function `levels` and `length` to determine 
# the number of regions defined by this dataset.
length(levels(murders$region)) # Answer: 4

# 6. The function `table` takes a vector and returns the frequency of 
# each element. You can quickly see how many states are in each region by
# applying this function. Use this function in one line of code to create
# a table of states per region.
table(murders$region)

#  Northeast         South    North Central          West 
#         9            17                12            13 

# 2.6 Vectors

# 2.6.1 Creating vectors
codes <- c(380, 124, 818)
codes

country <- c("Italy", "Canada", "Egypt")
# or with single quotes
country <- c('Italy', 'Canada', 'Egypt')

# 2.6.2 Names
codes <- c(italy = 380,
           canada = 124,
           egypt = 818)
codes

class(codes) # still numeric vector

# with names
names(codes)

# we can use quotes for the names
codes <- c("italy" = 380,
           "canada" = 124,
           "egypt" = 818)

# assigning names
codes <- c(380, 124, 818)
country <- c("Italy", "Canada", "Egypt")
names(codes) <- country
codes

# 2.6.3 Sequences
seq(1, 10)

seq(1, 10, 2)

#shorthand
1:10

# 2.6.4 Subsetting
codes[2]

# accessing 1st and 3rd element
codes[c(1, 3)]
# accessing subsequent elements
codes[1:2]
# accessing using the name
codes["Canada"]
codes[c("Egypt", "Canada")]

# 2.7 Coercion
x <- c(1, "canada", 3) # no error
class(x) # character - casted the values to character because it did not know
# how to convert "canada" to numeric value

x <- 1:5
y <- as.character(x)

y

as.numeric(y)

# 2.7.1 Not availables (NA)

x <- c("1", "b", "3")
as.numeric(x) # NOTICE the warning the appears for NA

# 2.8 Exercises

# 1. Use the function `c` to create a vector with the average high
# temperatures in January for Beijing, Lagos, Paris, Rio de Janeiro,
# San Juan, and Toronto, which are 35, 88, 42, 84, 81, and 30 degrees
# Fahrenheit. Call the object temp.

temp <- c(35, 88, 42, 84, 81, 30)

# 2. Now create a vector with the city names and call the object city.
city <- c("Beijing",
          "Lagos",
          "Paris",
          "Rio de Janeiro",
          "San Juan",
          "Toronto")

# 3. Use the names function and the objects defined in the previous exercises
# to associate the temperature data with its corresponding city.
names(temp) <- city
temp

#   Beijing          Lagos          Paris Rio de Janeiro       San Juan 
#        35             88             42             84             81 
# Toronto 
#      30 

# 4. Use the `[` and `:` operators to access the temperature of the first
# three cities on the list.
temp[1:3]

# Beijing   Lagos   Paris 
#      35      88      42 

# 5. Use the`[` operator to access the temperature of Paris and San Juan.
temp[c("Paris", "San Juan")]

#    Paris San Juan 
#       42       81 

# 6. Use the `:` operator to create a sequence of numbers 12, 13, 14,..., 73.
12:73

# 7. Create a vector containing all the positive odd numbers smaller than 100.
seq(1,100, 2)

# 8. Create a vector of numbers that starts at 6, does not pass 55, 
# and adds numbers in increments of 4/7: 6, 6 + 4/7, 6 + 8/7, and so on. 
# How many numbers does the list have?
# Hint: use seq and length.
length(seq(6, 55, 4/7))
# Answer: 86

# 9. What is the class of the following object a <- seq(1, 10, 0.5)?
a <- seq(1,10,0.5)
class(a)
# Answer: numeric

# 10. What is the class of the following object a <- seq(1, 10)?
a <- seq(1,10)
class(a)
# Answer: integer

# 11. The class of class(a<-1) is numeric, not integer. R defaults to 
# numeric and to force an integer, you need to add the letter L. 
# Confirm that the class of 1L is integer.
class(a <- 1L)

# 12. Define the following vector:
x <- c("1", "3", "5")

# and coerce it to get integers.
as.integer(x)

