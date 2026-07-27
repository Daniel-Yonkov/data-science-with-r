library(dplyr)
library(ggplot2)

# 8.1 The components of a graph
# target: build a plot similar to the one in ggplot-example-plot-1.png

# The main three components to note are:
# Data: The US murders data frame is being summarized
# Geometry: The plot in the example is a scatterplot. This is referred to as the geometry component.
# Aesthetic mapping: The plot uses several visual cues to represent the information provided by the dataset.
# The two most important cues in this plot are the point positions on the x-axis and y-axis, which represent population size
# and the total number of murders, respectively. Each point represents a different observation, and we map data about these
# observations to visual cues like x- and y-scale. Color is another visual cue that we map to region. We refer to this as the
# aesthetic mapping component. How we define the mapping depends on what geometry we are using.

# general structure
# DATA |> ggplot() + LAYER 1 + LAYER 2 + … + LAYER N
# Layers can define geometries, compute summary statistics, define what scales to use, or change styles. To add layers, we use
# the symbol `+`

# --------------------------

# 8.2 Initializing an object with data
library(dslabs)
data(murders)

ggplot(data = murders)
# equivalence
murders |> ggplot()
# we see only gray background because no geometry has been selected and the default is used (gray background)

p <- ggplot(data = murders)

print(p)
# equivalence
p

# --------------------------

# 8.3 Adding a geometry
# use ggplot2-cheatsheets.png for reference
# geometry function names follow the pattern: `geom_X` where X is the name of the geometry.
# for scatterplot, we need `geom_point`
?geom_point
# at the Aesthetics section we see what are the required parameters in bold

# --------------------------

# 8.4 Aesthetic mappings
# Aesthetic mappings describe how properties of the data connect with features of the graph, such as distance along an axis,
# size, or color.
# The `aes` function connects data with what we see on the graph by defining aesthetic mappings.

murders |> ggplot() + geom_point(aes(population/10^6, total))

# --------------------------

# 8.5 Other layers
# The `geom_label` and `geom_text` functions permit us to add text to the plot with and without a rectangle behind the text.
murders |>
  ggplot() +
  geom_point(aes(population/10^6, total)) +
  geom_text(aes(population/10^6, total, label = abb))

# --------------------------

# 8.6 Global aesthetic mappings
# We can avoid aesthetic duplication by using a global aesthetic mapping.

murders |>
  ggplot(aes(population/10^6, total)) +
  geom_point() +
  geom_text(aes(label = abb))

# If necessary, we can override the global mapping by defining a new mapping within each layer. 
murders |>
  ggplot(aes(population/10^6, total)) +
  geom_point() +
  geom_text(aes(x = 10, y = 800, label = "Hello World"))

# --------------------------

# 8.7 Non-aesthetic arguments
# Each geometry function has arguments other than `aes` and `data`
# to avoid putting the text on top of the point, we can use the `nudge_x` argument in `geom_text`

murders |>
  ggplot(aes(population/10^6, total)) +
  geom_point() +
  geom_text(aes(label = abb), nudge_x = 1.5)

# --------------------------

# 8.8 Categories as colors

murders |>
  ggplot(aes(population/10^6, total)) +
  geom_point(aes(color = region), size = 3)

# Note that `color` is also a non-aesthetic argument in several ggplot2 functions,
# including `geom_point`. This argument is not used to map colors to categories,
# but to change the color of all the points

murders |>
  ggplot(aes(population/10^6, total)) +
  geom_point(color = "blue", size = 3)
# all points are now blue

# --------------------------

# 8.9 Updating ggplot objects

p0 <- murders |> ggplot(aes(population/10^6, total))
p1 <- p0 + geom_point(aes(color = region), size = 3)
p1
p2 <- p1 + geom_text(aes(label = abb),  nudge_x = 0.1)
p2

# --------------------------

# 8.10 Scales

p2 + scale_x_continuous(trans = "log10") + scale_y_continuous(trans = "log10")
# equivalence
p2 + scale_x_log10() + scale_y_log10()

p3 <- p2 + scale_x_log10() + scale_y_log10()

# --------------------------

# 8.11 Annotations
# Examples of annotation functions are `labs`, `annotate`, and `geom_abline`.
# The labs function permits adding a title, subtitle, caption, and other labels.
# Note these can also be defined individually using the functions such as `xlab`,
# `ylab` and `ggtitle`.

p4 <- p3 + labs(title = "US Gun Murder Rates 2010",
                x = "Population in millions (log scale)",
                y = "Total number of murders (log scale)",
                color = "Region"
                )
p4

# Our desired final plot includes a line that represents the average murder rate
# for the entire country
# Once we determine the per million rate to be `r`, the desired line is defined
# by the formula: `y = r*x`, with `y` and `x` our axes: total murders and 
# population in millions, respectively. In the log-scale this line turns into: 
# `log(y) = log(r) + log(x)`, a line with slope 1 and intercept log(r). 
# We can compute r using:

r <- murders |>
  summarise(rate = sum(total) * 10^6 / sum(population)) |>
  pull(rate)

# To add a line we use the `geom_abline` function. The `ab` in the name reminds
# us we are supplying the intercept (a) and slope (b). The default line has slope
# 1 and intercept 0 so we only have to define the intercept. Note that the final
# plot has a dashed line type and is grey and these can be changed through the 
# `lty` (line type) and color non aesthetic arguments. We add the layer like this:

p5 <- p4 + geom_abline(intercept = log10(r), lty = 2, color = "darkgrey")
p5

# --------------------------

# 8.12 Add-on packages

# The power of ggplot2 is augmented further due to the availability of add-on 
# packages
# The style of a ggplot2 graph can be changed using the theme functions
# we use a function in the dslabs package that automatically sets a default theme:
ds_theme_set()

# install.packages('ggthemes', dependencies = TRUE)
# install.packages("ggrepel")
library(ggthemes)

p5 + theme_economist()

# to better position of the labels to avoid crowding the add-on package `ggrepel`
# includes a geometry that adds labels while ensuring that they don’t fall on 
# top of each other. We simply change `geom_text` to `geom_text_repel`
# install.packages("ggrepel")
library(ggrepel)

p1 + geom_text_repel(aes(label = abb))
