library(tidyverse)

----------
# 23. "Model basics" [Chapter 18 hardcopy]
# 23.2.1 Exercises

# Q1.
# One downside of the linear model is that it is sensitive to unusual values because the distance incorporates a
# squared term.
# Fit a linear model to the simulated data below, and visualise the results.
# Rerun a few times to generate different simulated datasets. What do you notice about the model?

sim1a <- tibble(
  x = rep(1:10, each = 3),
  y = x * 1.5 + 6 + rt(length(x), df = 2)
)

# A1.


# Q2.
# One way to make linear models more robust is to use a different distance measure. For example, instead of
# root-mean-squared distance, you could use mean-absolute distance:
  
measure_distance <- function(mod, data) {
  diff <- data$y - make_prediction(mod, data)
  mean(abs(diff))
}
# Use optim() to fit this model to the simulated data above and compare it to the linear model.

# A2.


# Q3.
# One challenge with performing numerical optimisation is that it’s only guaranteed to find one local optima.
# What’s the problem with optimising a three parameter model like this?

model1 <- function(a, data) {
  a[1] + data$x * a[2] + a[3]
}

# A3.


----------
# 23. "Model basics" [Chapter 18 hardcopy]
# 23.3.3 Exercises

# Q1.
# Instead of using 'lm()' to fit a straight line, you can use 'loess()' to fit a smooth curve. Repeat the process of
# model fitting, grid generation, predictions, and visualisation on 'sim1' using 'loess()' instead of 'lm()'.
# How does the result compare to 'geom_smooth()'?

# A1.


# Q2.
# 'add_predictions()' is paired with 'gather_predictions()' and 'spread_predictions()'.
# How do these three functions differ?

# A2.


# Q3.
# What does geom_ref_line() do? What package does it come from?
# Why is displaying a reference line in plots showing residuals useful and important?

# A3.


# Q4.
# Why might you want to look at a frequency polygon of absolute residuals?
# What are the pros and cons compared to looking at the raw residuals?

# A4.


----------
# 23. "Model basics" [Chapter 18 hardcopy]
# 23.4.5 Exercises

# Q1.
# What happens if you repeat the analysis of 'sim2' using a model without an intercept.
# What happens to the model equation? What happens to the predictions?

# A1.


# Q2.
# Use 'model_matrix()' to explore the equations generated for the models I fit to 'sim3' and 'sim4'.
# Why is '*' a good shorthand for interaction?

# A2.


# Q3.
# Using the basic principles, convert the formulas in the following two models into functions.
# (Hint: start by converting the categorical variable into 0-1 variables.)
mod1 <- lm(y ~ x1 + x2, data = sim3)
mod2 <- lm(y ~ x1 * x2, data = sim3)

# A3.


# Q4.
# For 'sim4', which of 'mod1' and 'mod2' is better? I think mod2 does a slightly better job at removing patterns,
# but it’s pretty subtle.
# Can you come up with a plot to support my claim?


