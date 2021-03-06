library(tidyverse)

----------
# 25. "Many models" [Chapter 20 hardcopy]
# 25.2.5 Exercises

# Q1.
# A linear trend seems to be slightly too simple for the overall trend.
# Can you do better with a quadratic polynomial? How can you interpret the coefficients of the quadratic?
# (Hint you might want to transform 'year' so that it has mean zero.)

# A1.


# Q2.
# Explore other methods for visualising the distribution of 'R squared'  per continent.
# You might want to try the 'ggbeeswarm' package, which provides similar methods for avoiding overlaps as jitter,
# but uses deterministic methods

# A2.


# Q3.
# To create the last plot (showing the data for the countries with the worst model fits), we needed two steps:
# we created a data frame with one row per country and then semi-joined it to the original dataset.
# It’s possible avoid this join if we use 'unnest()' instead of 'unnest(.drop = TRUE)'. How?

# A3.


----------
# 25. "Many models" [Chapter 20 hardcopy]
# 25.4.5 Exercises

# Q1. List all the functions that you can think of that take a atomic vector and return a list

# A1.


# Q2. Brainstorm useful summary functions that, like 'quantile()', return multiple values.

# A2.


# Q3.
# What’s missing in the following data frame?
# How does 'quantile()' return that missing piece? Why isn’t that helpful here?
mtcars %>% 
  group_by(cyl) %>% 
  summarise(q = list(quantile(mpg))) %>% 
  unnest()
#> # A tibble: 15 × 2
#>     cyl     q
#>   <dbl> <dbl>
#> 1     4  21.4
#> 2     4  22.8
#> 3     4  26.0
#> 4     4  30.4
#> 5     4  33.9
#> 6     6  17.8
#> # ... with 9 more rows

# A3.


# Q4.
# What does this code do? Why might might it be useful?
mtcars %>% 
  group_by(cyl) %>% 
  summarise_each(funs(list))

# A4.


----------
# 25. "Many models" [Chapter 20 hardcopy]
# 25.5.3 Exercises

# Q1. Why might the 'lengths()' function be useful for creating atomic vector columns from list-columns?

# A1.


# Q2. List the most common types of vector found in a data frame. What makes lists different?

# A2.

