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
