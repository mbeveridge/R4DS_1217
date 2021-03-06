library(tidyverse)

----------
# 13. "Relational data" [Chapter 10 hardcopy]
# 13.2.1 Exercises

library(nycflights13)

# Q1.
# Imagine you wanted to draw (approximately) the route each plane flies from its origin to its destination.
# What variables would you need? What tables would you need to combine?

# A1.
flights # look at table to see the variables
# origin airport ---> destination airport. (This is just the endpoints, but assume it's what 'approximate route' meant)
origin, dest ...['flights' table]
lat, lon ...['airports' table]
# Combine 'flights' table ('origin') with 'airports' table ('faa') to get lat&lon of origin airport
# Combine 'flights' table ('dest') with 'airports' table ('faa') to get lat&lon of destination airport


# Q2.
# I forgot to draw the relationship between 'weather' and 'airports'.
# What is the relationship and how should it appear in the diagram?

# A2.
# Similarly to Q1, 'origin' (in 'weather') could combine with 'faa' (in 'airports')
# (As Q3 says, 'weather' only contains data for the NYC airports, not for the destinations)


# Q3.
# 'weather' only contains information for the origin (NYC) airports.
# If it contained weather records for all airports in the USA, what additional relation would it define with 'flights'?

# A3.
# Similarly to Q1, 'origin' (in 'weather') could combine with 'origin' or 'dest' (in 'flights') ...'dest' is additional
# Could also (maybe, depending on frequency/accuracy of readings) match the 'year', 'month', 'day', 'hour' in each
# Does that answer the question?


# Q4.
# We know that some days of the year are “special”, and fewer people than usual fly on them.
# How might you represent that data as a data frame? What would be the primary keys of that table?
# How would it connect to the existing tables?

# A4.
# Inference is that these 'special' days would be in a new dataframe/ table. They might be on different dates each year
# So 'year', 'month', 'day' in the dataframe would combine for a primary key of date
# It would connect to 'flights' via 'year', 'month', 'day'


----------
# 13. "Relational data" [Chapter 10 hardcopy]
# 13.3.1 Exercises

# Q1.
# Add a surrogate key to 'flights'

# A1.
# "If a table lacks a primary key, it’s sometimes useful to add one with mutate() and row_number().  
# ... This is called a surrogate key" -- s13.3
flights %>%
  mutate(flight_id = row_number())


# Q2.
# Identify the keys in the following datasets

# Q2.1 Lahman::Batting
# Q2.2 babynames::babynames
# Q2.3 nasaweather::atmos
# Q2.4 fueleconomy::vehicles
# Q2.5 ggplot2::diamonds
# (You might need to install some packages and read some documentation.)

# A2.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q3.
# Draw a diagram illustrating the connections between the Batting, Master, and Salaries tables in the Lahman package.
# Draw another diagram that shows the relationship between Master, Managers, AwardsManagers.
# How would you characterise the relationship between the Batting, Pitching, and Fielding tables?

# A3.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


----------
# 13. "Relational data" [Chapter 10 hardcopy]
# 13.4.6 Exercises

# Q1.
# Compute the average delay by destination, then join on the airports data frame so you can show the spatial
# distribution of delays. Here’s an easy way to draw a map of the United States:
airports %>%
  semi_join(flights, c("faa" = "dest")) %>%
  ggplot(aes(lon, lat)) +
  borders("state") +
  geom_point() +
  coord_quickmap()
# (Don’t worry if you don’t understand what semi_join() does — you’ll learn about it next.)
# You might want to use the size or colour of the points to display the average delay for each airport

# A1.
# (Why doesn't it work if I use 'avg-delay' instead of 'avg_delay'?)
flights %>%
  group_by(dest) %>% # group_by() in order to then take the group average
  summarise(avg_delay = mean(arr_delay, na.rm = TRUE)) %>% # Choose to exclude NA's from the average
  left_join(airports, by = c(dest = "faa")) %>% # Join using flight destination, not flight origin

# This next part is same as in the question, but colours each airport (by avg_delay)
ggplot(aes(lon, lat, colour = avg_delay)) +
  borders("state") +
  geom_point() +
  coord_quickmap()

# "The left join should be your default join: use it unless you have a strong reason to prefer one of the others" -- s13.4.3
# "Warning message: Removed 4 rows containing missing values (geom_point)". So did it plot as if I'd chosen 'inner_join'?


# Q2.
# Add the location of the origin and destination (i.e. the lat and lon) to flights

# A2.
# Answer combines 2 pieces of example code at the end of s13.4.5. Looks as if it worked, but is it the right way?
# ...(ie. one after the other in the 'and then' pipe, rather than some sort of parallel? ...if that is even possible)
flights %>%
  left_join(airports, by = c(origin = "faa")) %>% # Looks like the join used in A1
  left_join(airports, by = c(dest = "faa")) %>% # 'airports' table doesn't distinguish between origin & destination
View()
# There are name duplications from the 2 joins, but each has a suffix (assume .x is origin and .y is dest)
# ...re. "disambiguated in the output with a suffix" (s13.4.5, where 2 tables each had same name for different variable)


# Q3.
# Is there a relationship between the age of a plane and its delays?

# A3.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q4. What weather conditions make it more likely to see a delay?
# A4.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q5.
# What happened on June 13 2013?
# Display the spatial pattern of delays, and then use Google to cross-reference with the weather

# A5.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


----------
# 13. "Relational data" [Chapter 10 hardcopy]
# 13.5.1 Exercises

# Q1.
# What does it mean for a flight to have a missing tailnum?
# What do the tail numbers that don’t have a matching record in planes have in common?
# (Hint: one variable explains ~90% of the problems.)

# A1.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q2.
# Filter flights to only show flights with planes that have flown at least 100 flights

# A2.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q3.
# Combine fueleconomy::vehicles and fueleconomy::common to find only the records for the most common models

# A3.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q4.
# Find the 48 hours (over the course of the whole year) that have the worst delays.
# Cross-reference it with the weather data. Can you see any patterns?

# A4.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q5.
# What does anti_join(flights, airports, by = c("dest" = "faa")) tell you?
# What does anti_join(airports, flights, by = c("faa" = "dest")) tell you?

# A5.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q6.
# You might expect that there’s an implicit relationship between plane and airline, because each plane is flown
# by a single airline. Confirm or reject this hypothesis using the tools you’ve learned above

# A6.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
