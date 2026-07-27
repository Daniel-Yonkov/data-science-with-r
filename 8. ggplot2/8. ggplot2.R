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
