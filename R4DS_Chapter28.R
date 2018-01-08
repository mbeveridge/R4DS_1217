# library(tidyverse)

----------
# 28. "Graphics for communication" [Chapter 22 hardcopy]
# 28.2.1 Exercises

# Q1.
# Create one plot on the fuel economy data with customised 'title', 'subtitle', 'caption', 'x', 'y', and 'colour' labels

# A1.


# Q2.
# The 'geom_smooth()' is somewhat misleading because the 'hwy' for large engines is skewed upwards due to the
# inclusion of lightweight sports cars with big engines. Use your modelling tools to fit and display a better model

# A2.


# Q3.
# Take an exploratory graphic that you’ve created in the last month, and add informative titles to make it easier
# for others to understand.


----------
# 28. "Graphics for communication" [Chapter 22 hardcopy]
# 28.3.1 Exercises

# Q1. Use 'geom_text()' with infinite positions to place text at the four corners of the plot

# A1.


# Q2.
# Read the documentation for 'annotate()'.
# How can you use it to add a text label to a plot without having to create a tibble?

# A2.


# Q3.
# How do labels with 'geom_text()' interact with faceting?
# How can you add a label to a single facet? How can you put a different label in each facet?
# (Hint: think about the underlying data.)

# A3.


# Q4. What arguments to 'geom_label()' control the appearance of the background box?

# A4.


# Q5.
# What are the four arguments to 'arrow()'? How do they work?
# Create a series of plots that demonstrate the most important options

# A5.


----------
# 28. "Graphics for communication" [Chapter 22 hardcopy]
# 28.4.4 Exercises

# Q1.
# Why doesn’t the following code override the default scale?
ggplot(df, aes(x, y)) +
  geom_hex() +
  scale_colour_gradient(low = "white", high = "red") +
  coord_fixed()

# A1.


# Q2. What is the first argument to every scale? How does it compare to 'labs()'?

# A2.


# Q3.
# Change the display of the presidential terms by:
# Q3.1 Combining the two variants shown above
# Q3.2 Improving the display of the y axis
# Q3.3 Labelling each term with the name of the president
# Q3.4 Adding informative plot labels
# Q3.5 Placing breaks every 4 years (this is trickier than it seems!)

# A3.


# Q4.
# Use 'override.aes' to make the legend on the following plot easier to see
ggplot(diamonds, aes(carat, price)) +
  geom_point(aes(colour = cut), alpha = 1/20)

# A4.




