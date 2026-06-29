# 4.1  Tidy data
# We say that a data table is in tidy format if each row represents one 
# observation and columns represent the different variables available for each
# of these observations. The murders dataset is an example of a tidy data frame.

library(dslabs)
data(murders)
head(murders)

# 4.2 Exercises
# 1. Examine the built-in dataset co2. Which of the following is true:
  # a. co2 is tidy data: it has one year for each row.
  # b. co2 is not tidy: we need at least one column with a character vector.
  # c. co2 is not tidy: it is a matrix instead of a data frame.
  # d. co2 is not tidy: to be tidy we would have to wrangle it to have three
  # columns (year, month and value), then each co2 observation would have a row.

data(co2)
co2

# Answer: d

# 2. Examine the built-in dataset ChickWeight. Which of the following is true:
  # a. ChickWeight is not tidy: each chick has more than one row.
  # b. ChickWeight is tidy: each observation (a weight) is represented by one
  # row. The chick from which this measurement came is one of the variables.
  # c. ChickWeight is not tidy: we are missing the year column.
  # d. ChickWeight is tidy: it is stored in a data frame.

data("ChickWeight")
head(ChickWeight)
# Answer: b

# 3. Examine the built-in dataset BOD. Which of the following is true:
  # a. BOD is not tidy: it only has six rows.
  # b. BOD is not tidy: the first column is just an index.
  # c. BOD is tidy: each row is an observation with two values (time and demand)
  # d. BOD is tidy: all small datasets are tidy by definition.
data("BOD")
head(BOD)

# Answer: c

# 4. Which of the following built-in datasets is tidy (you can pick more than one):
  # a. BJsales # 
  # b. EuStockMarkets
  # c. DNase
  # d. Formaldehyde
  # e. Orange
  # f. UCBAdmissions

data("BJsales")
head(BJsales) # not tidy

data("EuStockMarkets")
head(EuStockMarkets) # Tidy

data("DNase")
head(DNase) # Tidy

data("Formaldehyde")
head(Formaldehyde) # Tidy

data("Orange")
head(Orange) # Tidy

data("UCBAdmissions")
head(UCBAdmissions) # Not Tidy
