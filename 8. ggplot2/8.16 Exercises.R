# Start by loading the dplyr and ggplot2 library as well as the `murders` and
# `heights` data.
library(dplyr)
library(ggplot2)
library(dslabs)

data(murders)
data(heights)

# 1. With ggplot2, plots can be saved as objects. For example we can associate a
# dataset with a plot object like this.
p <- ggplot(data = murders)
# Because data is the first argument we don’t need to spell it out
p <- ggplot(murders)
# and we can also use the pipe:
p <- murders |> ggplot()

# What is class of the object p?
class(p)
# Answer:
# [1] "ggplot2::ggplot" "ggplot"          "ggplot2::gg"     "S7_object"       "gg"

# 2. Remember that to print an object you can use the command `print` or simply
# type the object. Print the object `p` defined in exercise one and describe what you see.

# a) Nothing happens.
# b) A blank slate plot.
# c) A scatterplot.
# d) A histogram.

print(p)

# Answer: b

# 3. Using the pipe `|>`, create an object `p` but this time associated with the
# heights dataset instead of the murders dataset.
p <- heights |> ggplot()

# 4. What is the class of the object p you have just created?
class(p)
# Answer:
# [1] "ggplot2::ggplot" "ggplot"          "ggplot2::gg"     "S7_object"       "gg"

# 5. Now we are going to add a layer and the corresponding aesthetic mappings.
# For the murders data we plotted total murders versus population sizes.
# Explore the `murders` data frame to remind yourself what are the names for these
# two variables and select the correct answer. Hint: Look at ?murders.
? murders

# a) state and abb.
# b) total_murders and population_size.
# c) total and population.
# d) murders and size.

# Answer: c

# 6. To create the scatterplot we add a layer with `geom_point`. The aesthetic
# mappings require us to define the x-axis and y-axis variables, respectively.
# So the code looks like this:
murders |> ggplot(aes(x = population, y = total)) +
  geom_point()

# 7. Note that if we don’t use argument names, we can obtain the same plot by
# making sure we enter the variable names in the right order like this:
murders |> ggplot(aes(population, total)) +
  geom_point()

# Remake the plot but now with total in the x-axis and population in the y-axis.
murders |> ggplot(aes(total, population)) +
  geom_point()

# 8. If instead of points we want to add text, we can use the `geom_text()` or
# `geom_label()` geometries. The following code
murders |> ggplot(aes(population, total)) + geom_label()

# will give us the error message:
# Error: geom_label requires the following missing aesthetics: label

# Why is this?

# a) We need to map a character to each point through the label argument in aes.
# b) We need to let geom_label know what character to use in the plot.
# c) The geom_label geometry does not require x-axis and y-axis values.
# d) geom_label is not a ggplot2 command.

# Answer: a

# 9. Rewrite the code above to use abbreviation as the label through `aes`
murders |> ggplot(aes(population, total, label = abb)) + geom_label()

# 10. Change the color of the labels to blue. How will we do this?

# a) Adding a column called blue to murders.
# b) Because each label needs a different color, we map the colors through aes.
# c) Use the color argument in ggplot.
# d) Because we want all labels to be blue, we do not need to map colors,
# just use the color argument in geom_label.
# Answer: d)

# 11. Rewrite the code above to make the labels blue.
murders |> ggplot(aes(population, total, label = abb)) + geom_label(color = "blue")

# 12. Now suppose we want to use color to represent the different regions. In
# this case which of the following is most appropriate:

# a) Adding a column called color to murders with the color we want to use.
# b) Because each label needs a different color, we map the colors through the color argument of aes .
# c) Use the color argument in ggplot.
# d) Because we want all colors to be blue, we do not need to map colors,
# just use the color argument in geom_label.

# Answer: b

# 13. Rewrite the code above to make the labels’ colors be determined by the
# state’s region.
murders |> ggplot(aes(population, total, label = abb, color = region)) + geom_label()

# 14. Now we are going to change the x-axis to a log scale to account for the 
# fact the distribution of population is skewed. Let’s start by defining an object 
# p holding the plot we have made up to now
p <- murders |>
  ggplot(aes(population, total, label = abb, color = region)) +
  geom_label()
# To change the y-axis to a log scale we learned about the `scale_y_log10()` 
# function. Add this layer to the object `p` to change the scale and render the plot.

p <- p+ scale_y_log10()

# 15. Repeat the previous exercise but now change both axes to be in the log scale.
p <- p + scale_y_log10() + scale_x_log10()
p

# 16. Now edit the code above to add the title “Gun murder data” to the plot. 
# Hint: use the `ggtitle` function.

p <- p + ggtitle("Gun murder data")
p

# 17. Now we are going to use the `geom_histogram` function to make a histogram
# of the heights in the height data frame. When reading the documentation for this
# function we see that it requires just one mapping, the values to be used for 
# the histogram. Make a histogram of all the plots.

heights |> 
  ggplot(aes(height)) +
  geom_histogram()

# What is the variable containing the heights?
  # a) sex
  # b) heights
  # c) height
  # d) heights$height

# Answer: c

# 18. Now create a ggplot object using the pipe to assign the heights data to a
# ggplot object. Assign height to the x values through the aes function.
heights |> ggplot(aes(x = height))

# 19. Now we are ready to add a layer to actually make the histogram. Use the 
# object created in the previous exercise and the `geom_histogram` function to make the histogram.
heights |> ggplot(aes(x = height)) + geom_histogram()

# 20. Note that when we run the code in the previous exercise we get the 
# warning: stat_bin() using bins = 30. Pick better value with binwidth.
# Use the binwidth argument to change the histogram made in the previous 
# exercise to use bins of size 1 inch.

heights |> ggplot(aes(x = height)) + geom_histogram(binwidth = 1)

# 21. Instead of a histogram, we are going to make a smooth density plot. In this
# case we will not make an object, but instead render the plot with one line of 
# code. Change the geometry in the code previously used to make a smooth density
# instead of a histogram.

heights |> ggplot(aes(x = height)) + geom_density()

# 22. Now we are going to make a density plot for males and females separately. 
# We can do this using the group argument. We assign groups via the aesthetic 
# mapping as each point needs to a group before making the calculations needed 
# to estimate a density.

heights |>
  ggplot(aes(height, group = sex)) + geom_density()

# 23. We can also assign groups through the `color` argument. This has the added
# benefit that it uses colors to distinguish the groups. Change the code above to use color.

heights |>
  ggplot(aes(height, color = sex)) + geom_density()

# 24. We can also assign groups through the fill argument. 
# This has the added benefit that it uses colors to distinguish the groups, like this:
heights |>
  ggplot(aes(height, fill = sex)) + geom_density()

# However, here the second density is drawn over the other. We can make the 
# curves more visible by using alpha blending to add transparency. Set the alpha
# parameter to 0.2 in the `geom_density` function to make this change.
heights |>
  ggplot(aes(height, fill = sex)) + geom_density(alpha = 0.2)
