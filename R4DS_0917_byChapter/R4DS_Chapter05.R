# install.packages("nycflights13")
library(nycflights13)
library(tidyverse)

----------
# 5. "Data transformation" [Chapter 3 hardcopy]
# 5.2.4 Exercises
  
# Q1.
# Find all flights that :
# Q1.1 Had an arrival delay of two or more hours
# Q1.2 Flew to Houston (IAH or HOU)
# Q1.3 Were operated by United, American, or Delta
# Q1.4 Departed in summer (July, August, and September)
# Q1.5 Arrived more than two hours late, but didn’t leave late
# Q1.6 Were delayed by at least an hour, but made up over 30 minutes in flight
# Q1.7 Departed between midnight and 6am (inclusive)

# A1.
flights
glimpse(flights)

filter(flights, arr_delay >= 120) # A1.1
filter(flights, dest == "IAH" | dest == "HOU")  # A1.2
filter(flights, dest %in% c("IAH", "HOU")) # A1.2 alternate
filter(flights, carrier %in% c("UA", "AA", "DL")) # A1.3
filter(flights, month %in% c(7, 8, 9)) # A1.4
filter(flights, arr_delay >= 120, dep_delay <= 0) # A1.5
filter(flights, dep_delay >= 60, dep_delay - arr_delay >= 30) # A1.6
filter(flights, dep_time >= 0000, dep_time <= 0600) # A1.7


# Q2.
# Another useful dplyr filtering helper is between(). What does it do?
# Can you use it to simplify the code needed to answer the previous challenges?

# A2.
?between # This is a shortcut for x >= left & x <= right
filter(flights, between(month, 7, 9)) # A1.4
filter(flights, between(dep_time, 0000, 0600)) # A1.7


# Q3.
# How many flights have a missing dep_time? What other variables are missing?
# What might these rows represent?

# A3.
# filter(flights, dep_time == NA) ...doesn't work
filter(flights, is.na(dep_time))
# Arrival time (and departure/arrival delay) also missing. These are probably cancelled flights


# Q4.
# Q4.1 Why is NA ^ 0 not missing?
# Q4.2 Why is NA | TRUE not missing?
# Q4.3 Why is FALSE & NA not missing?
# Q4.4 Can you figure out the general rule? (NA * 0 is a tricky counterexample!)

# A4. (In practice, expressions will evaluate to these things. Try running them, to confirm outcome)
# A4.1 NA ^ 0 == 1, because any numeric value to the 0th power equals 1. (So we know result is 1)
# A4.2 One of the 'OR' expressions is TRUE, so the other doesn't affect the outcome. (So we know result is TRUE)
# A4.3 One of the 'AND' expressions is FALSE, so the other doesn't affect the outcome. (So we know result is FALSE)
# A4.4 "In operations, any value interacting with an NA becomes missing. Missing values are ignored in conditional expressions"


----------
# 5. "Data transformation" [Chapter 3 hardcopy]
# 5.3.1 Exercises
  
# Q1. How could you use arrange() to sort all missing values to the start? (Hint: use is.na())
# A1.
arrange(flights, !is.na(dep_time))
# ?Rows with 'dep_time' missing will return a value of FALSE/0, so will be at start


# Q2.
# Sort flights to find the most delayed flights
# Find the flights that left earliest

# A2.
arrange(flights, desc(arr_delay))
arrange(flights, dep_delay)


# Q3. Sort flights to find the fastest flights
# A3.
arrange(flights, desc(distance / air_time))


# Q4.
# Which flights travelled the longest?
# Which travelled the shortest?

# A4.
arrange(flights, desc(distance))
arrange(flights, distance)


----------
# 5. "Data transformation" [Chapter 3 hardcopy]
# 5.4.1 Exercises
  
# Q1. Brainstorm as many ways as possible to select dep_time, dep_delay, arr_time, and arr_delay from flights
# A1.
select(flights, dep_time, dep_delay, arr_time, arr_delay)
select(flights, starts_with("dep"), starts_with("arr"))
select(flights, ends_with("_time"), ends_with("_delay")) # though this also gives 'sched_dep_time', 'sched_arr_time' and air_time'
select(flights, ends_with("time"), ends_with("delay"), -(starts_with("sched")), -(starts_with("air")))
select(flights, contains("dep_"), contains("arr_")) # though this also gives 'sched_dep_time'and 'sched_arr_time'
select(flights, contains("dep"), contains("arr_"), -(contains("sched")))
select(flights, matches("^(dep|arr)_(time|delay)$")) # Am not familiar with this [https://jrnold.github.io/e4qf/data-transformation.html]


# Q2. What happens if you include the name of a variable multiple times in a select() call?
select(flights, dep_time, dep_time, dep_time)
# A2. The variable is included only once in the new data frame. (No error/warning messages)


# Q3 What does the one_of() function do? Why might it be helpful in conjunction with this vector?
vars <- c("year", "month", "day", "dep_delay", "arr_delay")
?one_of()
select(flights, one_of(vars))

# A3.
# It selects any variable which matches one of those in the vector
# It’s useful because then you can easily pass vectors to select()
# PS. as a memory-jogger : In filter() we had '%in% c(,,)'


# Q4.
# Does the result of running the following code surprise you?
# How do the select helpers deal with case by default? How can you change that default?
select(flights, contains("TIME"))

# A4.
# By default the select() helpers ignore case
# To change that, set ignore.case = FALSE in the helper function
select(flights, contains("TIME", ignore.case = FALSE)) # eg. for contains()


----------
# 5. "Data transformation" [Chapter 3 hardcopy]
# 5.5.2 Exercises
  
# Q1.
# Currently dep_time and sched_dep_time are convenient to look at, but hard to compute with
# because they’re not really continuous numbers. 
# Convert them to a more convenient representation of number of minutes since midnight

# A1.
transmute(flights, dep_time = (dep_time %/% 100) * 60 + dep_time %% 100, sched_dep_time = (sched_dep_time %/% 100) * 60 + sched_dep_time %% 100)


# Q2.
# Compare air_time with arr_time - dep_time.
# What do you expect to see? What do you see? What do you need to do to fix it?
transmute(flights, air_time, arr_time, dep_time, arr_time - dep_time)

# A2:
# Expect that air_time equals arr_time - dep_time in 'reality'. But from Q1 we know that representation prevents that computation
transmute(flights, air_time, air_time_new = ((arr_time %/% 100) * 60 + arr_time %% 100) - ((dep_time %/% 100) * 60 + dep_time %% 100))
# air_time 'still' doesn't equal air_time_new. Why not?
# My air_time_new values are correct (ie. calc same as some online answers). How are air_time values obtained??
# Some flights may cross timezones (and arrival and departure times are reported in local time)
# Some flights may leave before midnight and arrive after (giving large -ve values)
# But (without yet including the latter 2 effects in my calculation) the differences I still see
# ...are rarely a multiple of 60 (nor half etc), so is this worth pursuing, or will I never match
# ...to the ‘air_time’ number with available info ?


# Q3.
# Compare dep_time, sched_dep_time, and dep_delay.
# How would you expect those three numbers to be related?
select(flights, dep_time, sched_dep_time, dep_delay)

# A3. dep_time = sched_dep_time + dep_delay ...If we convert dep_time and sched_dep_time to minutes past midnight, etc etc


# Q4.
# Find the 10 most delayed flights using a ranking function.
# How do you want to handle ties? Carefully read the documentation for min_rank()

# A4.
arrange(flights, min_rank(desc(arr_delay))) # Didn't use filter() here, but 10 results displayed by default
filter(flights, min_rank(desc(dep_delay))<=10) # Displays 10 results (there were no ties), but not in order
?min_rank
# min_rank() "does the most usual type of ranking (e.g. 1st, 2nd, 2nd, 4th)" ...so could be >10 rows, if ties

# Using pipes, it would look like
flights %>% 
  mutate(rank = min_rank(desc(dep_delay))) %>%
  arrange(rank)


# Q5. What does 1:3 + 1:10 return? Why?
1:3 + 1:10

# A5.
# Vector of (2,4,6,5,7,9,8,10,12,11) and Warning message "longer object length is not a multiple of shorter object length"
# The two vectors are not the same length, so R 'recycles' the shorter one until each vector is the same length
# Because 10 doesn't divide exactly by 3, the vectors do not line up properly and we get a Warning


# Q6. What trigonometric functions does R provide?
?Trig
# A6.
# cos(x), sin(x), tan(x)
# acos(x), asin(x), atan(x), atan2(y, x)
# cospi(x), sinpi(x), tanpi(x)


----------
# 5. "Data transformation" [Chapter 3 hardcopy]
# 5.6.7 Exercises

# Q1: Brainstorm at least 5 different ways to assess the typical delay characteristics
# of a group of flights. Consider the following scenarios:
# Q1.1 A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time.
# Q1.2 A flight is always 10 minutes late.
# Q1.3 A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time.
# Q1.4 99% of the time a flight is on time. 1% of the time it’s 2 hours late.
# Q1.5 Which is more important: arrival delay or departure delay?

# A1.
# A1.1 A flight is 15 minutes early 50% of the time, and 15 minutes late 50% of the time
flights %>%
  group_by(flight) %>%
  summarise(early_15min = sum(arr_delay == -15, na.rm = TRUE) / n(),
            late_15min = sum(arr_delay == 15, na.rm = TRUE) / n()) %>%
  filter(early_15min == 0.5, late_15min == 0.5)
# A1.1 This gives zero rows (flight numbers)

# A1.1 A flight is >=15 minutes early 50% of the time, and >=15 minutes late 50% of the time
flights %>%
  group_by(flight) %>%
  summarise(early_15min = sum(arr_delay <= -15, na.rm = TRUE) / n(),
            late_15min = sum(arr_delay >= 15, na.rm = TRUE) / n()) %>%
  filter(early_15min == 0.5, late_15min == 0.5)
# A1.1 This gives 18 rows (flight numbers)

# A1.1 using mean() instead of sum()/n()
View(flights %>%
  group_by(flight) %>%
  summarise(early_15min = mean(arr_delay <= -15, na.rm = TRUE),
            late_15min = mean(arr_delay >= 15, na.rm = TRUE)) %>%
  filter(early_15min == 0.5, late_15min == 0.5))
# A1.1 This gives 21 rows (including flight=3505, flight=4436, flight=5910 not got with 'sum/n')


# A1.2 A flight is always 10 minutes late
flights %>%
  group_by(flight) %>%
  summarise(late_10min = sum(arr_delay == 10, na.rm = TRUE) / n()) %>%
  filter(late_10min == 1)
# A1.2 This gives 4 rows (flight=2254, 3656, 3880, 5854)


# A1.3 A flight is 30 minutes early 50% of the time, and 30 minutes late 50% of the time
flights %>%
  group_by(flight) %>%
  summarise(early_30min = sum(arr_delay <= -30, na.rm = TRUE) / n(),
            late_30min = sum(arr_delay >= 30, na.rm = TRUE) / n()) %>%
  filter(early_30min == 0.5, late_30min == 0.5)
# A1.3 This gives 3 rows (flight=3651, 3916, 3951)


# A1.4 99% of the time a flight is on time. 1% of the time it's 2 hours late
flights %>%
  group_by(flight) %>%
  summarise(on_time = sum(arr_delay == 0, na.rm = TRUE) / n(),
            late_120min = sum(arr_delay >= 120, na.rm = TRUE) / n()) %>%
  filter(on_time == .99, late_120min == .01)
# A1.4 This gives zero rows, even though I made '2 hours late' looser


# A1.5 Which is more important: arrival delay or departure delay?
# For an individual, it's personal preference (eg. extra time in air v's extra time waiting at airport,
# or need to be at a meeting on time).
# May also depend on certainty (low variance) for that flight (could you arrive late IF gate stays open,
# and could you plan/book onward travel 'knowing' there would be delay)

# For an airport/(airline), both could affect capacity planning & wastage & customer compensation,
# and again certainty (low variance) would be important

# For both (specific flightroute, overall group), could create scatterplot (delay v's count) as in s5.6.3
# And/or could create an aggregate calculation of 'typical' delay (taking account probability)


# Q2.
# Come up with another approach that will give you the same output as not_cancelled %>% count(dest)
# and not_cancelled %>% count(tailnum, wt = distance) (without using count())
not_cancelled <- flights %>% 
  filter(!is.na(dep_delay), !is.na(arr_delay))

# A2.1 cf. not_cancelled %>% count(dest) ...[104 rows x 2 cols (dest, n)]
not_cancelled %>%
  group_by(dest) %>%
  summarise(n())

# A2.2 cf. not_cancelled %>% count(tailnum, wt = distance) ...[4037 rows x 2 cols (tailnum, n)]
not_cancelled %>%
  group_by(tailnum) %>%
  summarise(sum(distance))


# Q3.
# Our definition of cancelled flights (is.na(dep_delay) | is.na(arr_delay) ) is slightly suboptimal.
# Why? Which is the most important column?
flights %>%
  group_by(!is.na(dep_delay), !is.na(arr_delay)) %>%
  summarise(n())

# A3.
# The data has some flights that departed but didn't arrive (so those weren't cancelled
# and shouldn't be excluded as such). It doesn't have any that arrived but didn't depart.
# So the important column is 'dep_delay', and our optimal definition of cancelled flights is now
# '(is.na(dep_delay)'


# Q4.
# Q4.1 Look at the number of cancelled flights per day. Is there a pattern?
# Q4.2 Is the proportion of cancelled flights related to the average delay?

# A4.1
cancelled <- flights %>%
  filter(is.na(dep_delay)) %>%
  group_by(year, month, day) %>%
  summarise(count = n())

View(cancelled) # Can't tell a pattern from looking at table

ggplot(data = cancelled, mapping = aes(x = day, y = count)) +
  geom_point() # 31 days along x-axis (with one point per month). 2 days had a point with count=400ish : 8th & 9th
date_long <- paste(cancelled$year, cancelled$month, cancelled$day) # trying to get 365 days in a timeline
ggplot(data = cancelled, mapping = aes(x = date_long, y = count)) +
  geom_point() # still 2 days with count=400ish : 8Feb and 9Feb. Why are these *midway* along x-axis?

# There is no obvious pattern

--------------------------
# Comment & code from @michaeljw in (R4DS Slack) board=03_week on 20/9/17 ~16:15
# Using `paste()` is a fine guess, but there's an even simpler way: the data frame has a column
# called `time_hour`, which contains the date and the time of the flight. You can use `as.Date()`
# to strip the time out, like so:

cancelled <- flights %>%
filter(is.na(dep_delay)) %>%
mutate(date = as.Date(time_hour)) %>%
group_by(date) %>%
summarise(count = n())

# Note that I've done this in a `mutate()` call so that the new `date` column is part of the `cancelled`
# data frame. That will make it easier to use as the axis when plotting.
# This `cancelled` data frame now just has `date` and `count` columns; with a small modification to
# your original code we can plot them like so:
  
ggplot(data = cancelled, mapping = aes(x = date, y = count)) +
  geom_point()
--------------------------


# A4.2
flights %>%
  group_by(year, month, day) %>%
  summarise(cancelled = sum(is.na(dep_delay)),
            cancelled_propn = mean(is.na(dep_delay)),
            mean_dep_delay = mean(dep_delay,na.rm=TRUE),
            mean_arr_delay = mean(arr_delay,na.rm=TRUE)) %>%
  ggplot(aes(y = cancelled_propn)) +
  geom_point(aes(x=mean_dep_delay), colour='blue', alpha=0.5) +
  geom_point(aes(x=mean_arr_delay), colour='red', alpha=0.5) +
  geom_smooth(aes(x=mean_dep_delay), colour='blue') +
  geom_smooth(aes(x=mean_arr_delay), colour='red') +
  xlab('average delay (minutes)') +
  ylab('proportion of cancelled flights')

# There is a +ve correlation between proportion of cancelled flights and average delay
# So (simplifying), on days with a lot of delays, there will also be a lot of cancellations


# Q5.
# Q5.1 Which carrier has the worst delays?
# Q5.2 Challenge: can you disentangle the effects of bad airports vs. bad carriers?
# Why/why not? (Hint: think about flights %>% group_by(carrier, dest) %>% summarise(n()))

# A5.1
flights %>%
  filter(!is.na(dep_delay), !is.na(arr_delay)) %>%
  group_by(carrier) %>%
  summarise(mean_arr_delay = mean(arr_delay)) %>% # 'na.rm = TRUE' argument not needed, as filter() does similar
  arrange(desc(mean_arr_delay))
# carrier=F9 has the highest average delay, of 22 minutes
filter(airlines, carrier == "F9") # Frontier Airlines Inc

# A5.2
flights %>% group_by(carrier) %>% summarise(n()) # 16 carriers
View(flights %>% group_by(dest) %>% summarise(n())) # 105 destination airports
flights %>% group_by(carrier, dest) %>% summarise(n()) # sometimes airlines flew to dest only 1 or 2 times
View(flights %>% group_by(dest) %>% summarise(unique = n_distinct(carrier)) %>% arrange(desc(unique))) # s5.6.4
# We could try to disentangle the effects of bad carriers v's bad airports by comparing a carrier’s delay
# at a destination airport v's average delay at that airport (where latter excludes that carrier's flights)
# However, 53 of those airports only receive 1 or 2 carriers (and max is 7), so it would be hard to disentangle
# NOTE: I haven't done any calculations, to actually try and disentangle the effects


# Q6. What does the sort argument to count() do. When might you use it?
# A6.
# The sort argument will sort the results of count() in descending order of n.
# You might use this (to save a line of code), if you want to count() and then arrange() the results
# ...and you might want to do that because the most important results are often in the Top10


----------
# 5. "Data transformation" [Chapter 3 hardcopy]
# 5.7.1 Exercises

# Q1.
# Refer back to the lists of useful mutate and filtering functions.
# Describe how each operation changes when you combine it with grouping

# A1.
# Not sure which lists (but possibly s5.5.1 and probably s5.6.4) ...eg. min_rank(), rank(), n(), sum()
# The function operates within each group rather than over the entire data frame.
# eg. mean() will calculate the mean within each group


# Q2. Which plane (tailnum) has the worst on-time record?
# A2.
flights %>% # 336,776 x 19
  group_by(tailnum) %>% # 336,776 x 19
  summarise(arr_delay = mean(arr_delay, na.rm = TRUE)) %>% # 4044 x 2
  filter(min_rank(desc(arr_delay)) == 1) # 1 x 2
# tailnum = N844MH


# Q3. What time of day should you fly if you want to avoid delays as much as possible?
# A3. Grouping by hour, and only considering delays >15min
flights %>%
  group_by(hour) %>%
  summarise(arr_delay = sum(arr_delay > 0, na.rm = TRUE) / n()) %>%
  ggplot(aes(x = hour, y = arr_delay)) +
  geom_col()
# Flying midnight to 5am has zero chance of arrival delay (because no flights available?) The later you fly
# the worse (peaking at 9pm). (Delays early in the morning have a knockon effect throughout the day. Etc)


# Q4.
# For each destination, compute the total minutes of delay.
# For each flight, compute the proportion of the total delay for its destination

# A4.
# THIS WORKED
flights %>%
  filter(!is.na(arr_delay), arr_delay > 0) %>%  # 1st condition not really needed. Exclude -ve delays
  group_by(dest) %>%
#  mutate(total_delay = sum(arr_delay)) %>%
  summarise(total_delay = sum(arr_delay)) %>%
  select(dest, total_delay)

# THIS DIDN'T WORK. (See a working solution below, a reply to my request for help)
# I could do the first part in isolation. But the way I picture grouping might be a bit shaky, so I’m
# struggling with rolling up (and when to use ungroup(), etc etc), and I seem to be at the point of ‘throwing
# code, to see what sticks’, and lost. Can anyone give me pointers towards a solution?
flights %>%
  filter(!is.na(arr_delay), arr_delay > 0) %>%  # 133,004 x 19
  group_by(dest, flight) %>% # 133,004 x 19. Groups: dest, flight [8,505]
  mutate(total_delay = sum(arr_delay),
         prop_delay = arr_delay / total_delay) %>% # 133,004 x 21. Groups: dest, flight [8,505]
# First I want total_delay for each flight within each dest. But how will I access total delay per dest, for proportion calc?
  summarise(total_delay = sum(arr_delay),
            prop_delay = arr_delay / total_delay) %>% # error : Column `prop_delay` must be length 1 (a summary value), not 52
  select(dest, total_delay, flight, prop_delay)
# THIS DIDN'T WORK. (See a working solution below, a reply to my request for help)


--------------------------
# Comment & code from @jmoran in (R4DS Slack) board=03_week on 21/9/17 13:10
# And for part 2, I did the following, which I think gets us the answer. It’s likely more steps than are needed.
# EDIT: I see the question was for `flight` and not `tailnum`; however, I think the logic does not change
# if you sub in `flight` in the following code

# MDAB has edited this code, from 'tailnum' to 'flight'. And to include filter(arr_delay > 0)
# PS. left_join() isn't a function we've met yet
  
# Create a table of total delays by destination
total_delay <- flights %>%
  filter(arr_delay >= 0) %>% # MDAB added
  group_by(dest) %>%
  dplyr::summarise(total_delay = sum(arr_delay, na.rm= TRUE))

# Create a table of total delays by FLIGHT for each destination. [MDAB: flight means 'Flight number', not an individual trip. Could be to multiple destinations]
flight_delays <- flights %>%
  filter(arr_delay >= 0) %>% # MDAB added
  group_by(flight, dest) %>%
  dplyr::summarise(delay_per = sum(arr_delay, na.rm = TRUE))

# Join the two tables (on 'dest') and create a proportion delay column
flight_delays <- flight_delays %>%
  left_join(total_delay,by = "dest") %>%
  mutate(prop_delay = delay_per / total_delay) %>%
  arrange(dest, flight) # MDAB added, to sort by 'dest' first, to see that each dest total adds to 1.0

flight_delays # 8620 x 5
# What would I change, to have all the columns (not just the 'necessary' 5)?
--------------------------


# Q5.
# Delays are typically temporally correlated: even once the problem that caused the initial delay
# has been resolved, later flights are delayed to allow earlier flights to leave.
# Using lag() explore how the delay of a flight is related to the delay of the immediately preceding flight
?lag # See s5.5.1


# A5.
# This relates to departures from each location, so use 'dep_delay' and 'origin'
# Want to compare flights from the same origin, not simply at consecutive times
# Avoid comparing 05:00 flight with 23:59 flight. Grouping by day makes each 1st lag an NA (?) and can filter()
# Filter out NA's before and after calculating the lag_delay

flights %>%
  group_by(year, month, day, origin) %>%
  arrange(year, month, day, hour, minute) %>%
  filter(!is.na(dep_delay)) %>%
  mutate(lag_delay = lag(dep_delay)) %>%
  filter(!is.na(lag_delay)) %>%
  ggplot(aes(x = lag_delay, y = dep_delay)) +
  geom_point() +
  geom_smooth()


# Q6.
# Q6.1 Look at each destination. Can you find flights that are suspiciously fast?
# (i.e. flights that represent a potential data entry error).
# Q6.2 Compute the air time of a flight relative to the shortest flight to that destination.
# Which flights were most delayed in the air?

# A6.1
# Surely we can't just compare air_time to the median value for a destination - what about the fact
# that flights also have different 'origin'/distance ?
# Well, the dataset is "dataset on flights departing New York City in 2013", so it's probably ok
flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest) %>%
  mutate(med_time = median(air_time),
         fast = (air_time - med_time) / med_time) %>%
  arrange(fast) %>%
  select(dest, origin, year, month, day, carrier, flight, air_time, med_time, fast) %>%
  head(20)
# Shorter flights might be disproportionately affected by delays of a few minutes (eg. circling above
# destination, waiting for permission to land, good/bad weather/wind?)
# The flights at the top of the 'fast' list have ~40% time savings, which is significant
# Are all of the numbers entered (v's calculated)? I don't see (eg) transposition errors as indication
# that data entry is a problem


# A6.2
# What does "relative to the shortest flight to that destination" mean? Are we supposed to ignore that
# flights also have different 'origin'/distance? - it would give misleading 'delayed in the air' values.
# Well, the dataset is "dataset on flights departing New York City in 2013", so it's probably ok
flights %>%
  filter(!is.na(air_time)) %>%
  group_by(dest) %>%
  mutate(air_time_relative = air_time - min(air_time)) %>%
  arrange(desc(air_time_relative)) %>%
  select(dest, origin, year, month, day, carrier, flight, air_time, air_time_relative)
# The 28/7 DL flight into SFO was most delayed. carrier=DL into SFO and LAX shows up several times
# near the top of the 'most delayed' list (but flight numbers differ)
# Is this what the question meant, or did the last part intend an average per flight?


# Q7.
# Find all destinations that are flown by at least two carriers.
# Use that information to rank the carriers

# A7.
# cf. A5.2 : flights %>% group_by(dest) %>% summarise(unique = n_distinct(carrier)) %>% arrange(desc(unique))
# Rank the carriers according to number of destinations they fly to. (But filtering out some destinations)
flights %>% # 336,776 x 19
  group_by(dest) %>% # 336,776 x 19
  filter(n_distinct(carrier)>=2) %>% # 325,397 x 19
  group_by(carrier) %>% # 325,397 x 19. THIS group_by REPLACES the previous one (?)
  summarise(carrier_dests = n_distinct(dest)) %>% # 16 x 2 ...carrier, carrier_dests
  arrange(desc(carrier_dests)) # 16 x 2 ...carrier, carrier_dests

# This gives same answer. But I don't know how the count() works, nor why 2 of them are needed (but they are)
flights %>% # 336,776 x 19
  group_by(dest) %>% # 336,776 x 19
  filter(n_distinct(carrier)>=2) %>% # 325,397 x 19
  count(carrier) %>% # 285 x 3 ...dest, carrier, n. THIS did the job of a summarise() ?
  group_by(carrier) %>% # 285 x 3 ...dest, carrier, n
  count(sort = TRUE) # 16 x 2 ...carrier, nn


# Q8. For each plane, count the number of flights before the first delay of greater than 1 hour
# [This was previously s5.6.7 Exercises Q6]

# A8. [3 snippets & comments (not mine), giving same 3748x2 answer. I don't follow any - all use unfamiliar functions]
# XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX The comments below are not by MDAB
flights %>%
  group_by(tailnum) %>%
  mutate(row_num = row_number()) %>%
  filter(arr_delay > 60) %>%
  summarize(first_hour_delay = first(row_num) - 1)
# This uses a grouped summary operation. First I group by plane (tailnum), then I create a variable
# that defines the row number within each plane. I then filter the data to only include flights with
# delays longer than an hour, and use summarize() in conjunction with first() to find for each plane
# the row_num of the first flight with an 1+ hour delay. I subtract 1 from that value to count the
# number of flights before the first delay, rather than including the first flight with the hour or more delay


# I think this requires grouped mutate (but I may be wrong):
flights %>%
  arrange(tailnum, year, month, day) %>%
  group_by(tailnum) %>%
  mutate(delay_1hr = arr_delay > 60) %>%
  mutate(before_1stdelay = cumsum(delay_1hr)) %>%
  filter(before_1stdelay < 1) %>%
  count(sort = TRUE)


flights %>%
  mutate(dep_date = as.Date(time_hour)) %>%
  group_by(tailnum) %>%
  arrange(dep_date) %>%
  filter(!cumany(arr_delay > 60)) %>%
  tally(sort = TRUE)
