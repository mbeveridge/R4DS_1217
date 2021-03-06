library(tidyverse)
library(forcats)

----------
library(lubridate)
library(nycflights13)

# 16. "Dates and times" [Chapter 13 hardcopy]
# 16.2.4 Exercises

# Q1.
# What happens if you parse a string that contains invalid dates?
ymd(c("2010-10-10", "bananas"))

# A1.
# Results in an NA with warning message :
[1] "2010-10-10" NA          
Warning message: 1 failed to parse. 


# Q2.
# What does the tzone argument to today() do? Why is it important?
?today

# A2.
# "a character vector specifying which time zone you would like to find the current date of.
# tzone defaults to the system time zone set on your computer" eg. today("GMT") -- Help
# Different time-zones can have different dates, so value of today() might vary


# Q3.
# Use the appropriate lubridate function to parse each of the following dates:
d1 <- "January 1, 2010"                             # Q3.1
d2 <- "2015-Mar-07"                                 # Q3.2
d3 <- "06-Jun-2017"                                 # Q3.3
d4 <- c("August 19 (2015)", "July 1 (2015)")        # Q3.4
d5 <- "12/30/14" # Dec 30, 2014                     # Q3.5

# A3.
mdy(d1)                                             # A3.1
ymd(d2)                                             # A3.2
dmy(d3)                                             # A3.3
mdy(d4)                                             # A3.4
mdy(d5)                                             # A3.5


----------
# 16. "Dates and times" [Chapter 13 hardcopy]
# 16.3.4 Exercises
  
# Q1.
# How does the distribution of flight times within a day change over the course of the year?

# A1.
# Most obvious way to do this would be to compare daily distributions from during the year (either from a sample of
# individual days, or weekly/monthly/quarterly aggregates). Is this what the question means? (Else, if we look at how
# every day changes, I think we'd need to use an average (mean, SD) for the daily distribution, to plot it
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q2.
# Compare dep_time, sched_dep_time and dep_delay. Are they consistent? Explain your findings

# A2.
nycflights13::flights %>%
  ggplot(aes(dep_time, sched_dep_time)) +
  geom_point()
# This plot shows most points along or near-below a diagonal line, indicating on-time departure (or small delay).
# The question is probably asking whether sched_dep_time + dep_delay = dep_time
# (cf. In a previous Section we found that dep_time + air_time != arr_time ...Delay on tarmac?)
glimpse(flights)
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q3.
# Compare air_time with the duration between the departure and arrival. Explain your findings.
# (Hint: consider the location of the airport)

# A3.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q4.
# How does the average delay time change over the course of a day? Should you use dep_time or sched_dep_time? Why?

# A4.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q5.
# On what day of the week should you leave if you want to minimise the chance of a delay?

# A5.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q6.
# What makes the distribution of diamonds$carat and flights$sched_dep_time similar?

# A6.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


# Q7.
# Confirm my hypothesis that the early departures of flights in minutes 20-30 and 50-60 are caused by scheduled 
# flights that leave early. (Hint: create a binary variable that tells you whether or not a flight was delayed)

# A7.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX


----------
# 16. "Dates and times" [Chapter 13 hardcopy]
# 16.4.5 Exercises

# Q1. Why is there months() but no dmonths()?
# A1. There is no standard length of month (30, 31 days), so it wouldn't make sense to define it in seconds


# Q2.
# Explain days(overnight * 1) to someone who has just started learning R. How does it work?

# A2.
# This is referring to some code in s16.4.2, designed to add 'days(1) to the arrival time of each overnight flight'
overnight = arr_time < dep_time,
arr_time = arr_time + days(overnight * 1)
# We only want to add 'days(1)' in cases where we omitted it before. 'overnight' is TRUE (1) or FALSE (0).
# So if it is an overnight flight, we add 1 day, and if not, no days are added


# Q3.
# Q3.1 Create a vector of dates giving the first day of every month in 2015.
# Q3.2 Create a vector of dates giving the first day of every month in the current year

# A3.1
ymd(c("2015-01-01", "2015-02-10", "2015-03-01", "2015_04-01", "2015-05-01", "2015-06-01",
                     "2015-07-01", "2015-08-10", "2015-09-01", "2015_10-01", "2015-11-01", "2015-12-01"))
# That worked, but could be done more concisely :
ymd("2015-01-01") + months(0:11)

# A3.2
# Again, could do it the 'long' way or 'concise' way, as above, just replacing 2015 with 2017. BUT that seems trivial.
# INSTEAD, assume that the question is asking us to code for a generic 'current year'

# "I can do that by taking today() and truncating it to the year using floor_date" :
floor_date(today(), unit = "year") + months(0:11)
# -- https://jrnold.github.io/e4qf/dates-and-times.html#exercises-40


# Q4.
# Write a function that given your birthday (as a date), returns how old you are in years

# A4.
# We haven't covered Functions yet (s19). This is from [https://jrnold.github.io/e4qf/dates-and-times.html#exercises-40] :
age <- function(bday) {
  (bday %--% today()) %/% years(1)
}
age(ymd("1969-07-29"))
# The parts between {} were covered in s16.4.3


# Q5.
# Why can’t (today() %--% (today() + years(1)) / months(1) work?
(today() %--% (today() + years(1)) / months(1)

# A5.
# Editor shows a red cross, with "unmatched opening bracket '('" ...but I don't think that was the intended error ...?
(today() %--% (today() + years(1))) / months(1) # This works and gives an answer of 12
(today() %--% (today() + years(1)) / months(1)) # This works and gives an answer of 12

