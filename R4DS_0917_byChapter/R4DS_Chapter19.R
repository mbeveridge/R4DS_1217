library(tidyverse)

----------
# 19. "Functions" [Chapter 15 hardcopy]
# 19.2.1 Practice

# Q1.
# Why is 'TRUE' not a parameter to 'rescale01()'?
# What would happen if 'x' contained a single missing value, and 'na.rm' was 'FALSE'?

# A1.



# Q2.
# In the second variant of rescale01(), infinite values are left unchanged.
# Rewrite rescale01() so that -Inf is mapped to 0, and Inf is mapped to 1

# A2.



# Q3.
# Practice turning the following code snippets into functions. Think about what each function does.
# What would you call it? How many arguments does it need? Can you rewrite it to be more expressive or less duplicative?
mean(is.na(x))                                       # Q3.1
x / sum(x, na.rm = TRUE)                             # Q3.2
sd(x, na.rm = TRUE) / mean(x, na.rm = TRUE)          # Q3.3

# A3.1
# A3.2
# A3.3


# Q4.
# Follow http://nicercode.github.io/intro/writing-functions.html to write your own functions to compute the variance
# and skew of a numeric vector

# A4.


# Q5.
# Write both_na(), a function that takes two vectors of the same length and returns the number of positions that have
# an NA in both vectors

# A5.


# Q6.
# What do the following functions do? Why are they useful even though they are so short?
is_directory <- function(x) file.info(x)$isdir        # Q6.1
is_readable <- function(x) file.access(x, 4) == 0     # Q6.2

# A6.1
# A6.2


# Q7.
# Read the complete lyrics [https://en.wikipedia.org/wiki/Little_Bunny_Foo_Foo] to “Little Bunny Foo Foo”.
# There’s a lot of duplication in this song. Extend the initial piping example to recreate the complete song, and
# use functions to reduce the duplication

# A7.
