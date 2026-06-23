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
