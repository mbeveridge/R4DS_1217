library(tidyverse)
library(forcats)

----------
# 15. "Factors" [Chapter 12 hardcopy]
# 15.3.1 Exercises

# Q1.
# Explore the distribution of 'rincome' (reported income).
# What makes the default bar chart hard to understand?
# How could you improve the plot?

# A1.
?gss_cat    # It’s a sample of data from the General Social Survey, which is a long-running US survey -- s15.3

forcats::gss_cat %>%
  ggplot(aes(x = rincome)) +
  geom_bar()

# I think "hard to understand" is referring to the x-axis labels being squashed/overlapping/unreadable
# Usual way to overcome this (unless bars have to be vertical) is to make bars horizontal :
forcats::gss_cat %>%
  ggplot(aes(rincome)) +
  geom_bar() +
  coord_flip()

# Other improvements : descending values (re. reading down list), consistent bin size (but we can't affect that)
# ...and maybe to group together some of the 'no answer' categories, if no values can be got from them


# Q2. What is the most common 'relig' in this survey? What’s the most common 'partyid'?

# A2.
forcats::gss_cat %>%
  count(relig) %>%
  arrange(desc(n))                 # P.50 of hardcopy
# Most common 'relig' is Protestant

forcats::gss_cat %>%
  count(partyid) %>%
  arrange(desc(n))
# Most common 'partyid' is Independent


# Q3.
# Which 'relig' does 'denom' (denomination) apply to? How can you find out with a table?
# How can you find out with a visualisation?

# A3.
forcats::gss_cat$denom             # This listed values for the first 1000 rows. Answer appears to be Protestant
levels(forcats::gss_cat$denom)     # Shows that there are only 30 different values in total. Answer is Protestant

forcats::gss_cat %>%
  ggplot(aes(relig, denom)) +
  geom_point() +
  coord_flip()                     # Incl/exclude this, to read labels on one axis, then other. (Q tells only 1 answer)

# Answer from https://jrnold.github.io/e4qf/factors.html#exercises-35 includes quantities as size, but its most useful
# feature is the rotation of labels on the x-axis :
gss_cat %>%
  count(relig, denom) %>%
  ggplot(aes(x = relig, y = denom, size = n)) +
  geom_point() +
  theme(axis.text.x = element_text(angle = 90))


----------
# 15. "Factors" [Chapter 12 hardcopy]
# 15.4.1 Exercises
  
# Q1. There are some suspiciously high numbers in 'tvhours'. Is the mean a good summary?
# A1.
forcats::gss_cat %>%
  ggplot(aes(x = tvhours)) +
  geom_histogram(binwidth = 1)
# Warning message: Removed 10146 rows containing non-finite values (stat_bin)

# Answer from https://jrnold.github.io/e4qf/factors.html#exercises-36 :
gss_cat %>%
  filter(!is.na(tvhours)) %>%      # extra line means no 'Warning message' (but same chart)
  ggplot(aes(x = tvhours)) +
  geom_histogram(binwidth = 1)

# The distribution has a long tail to the right, but most results are <6 hrs, and nothing >24 hrs
# Median might be a 'better' summary, but also 'it depends' (on the reason for wanting a summary)


# Q2. For each factor in 'gss_cat' identify whether the order of the levels is arbitrary or principled.
# A2.
XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# https://jrnold.github.io/e4qf/factors.html#exercises-36


# Q3. Why did moving “Not applicable” to the front of the levels move it to the bottom of the plot?
# A3.
# The question is referring to the last geom_point() chart in s15.4
# Order of the levels in the rincome() factor can be seen with 'levels(gss_cat$rincome)' or 'gss_cat %>% count(rincome)'
# R assigns integers to each level, based on the order. So "1" to the 1st level, "2" to the 2nd level, etc
# When plotting 'rincome' on the y-axis, the level nearest the '0' will be that with integer "1", etc

?fct_relevel
# Using 'fct_relevel' to move "Not applicable" to 1st level gives it integer "1" (and "move it the bottom of the plot")


----------
# 15. "Factors" [Chapter 12 hardcopy]
# 15.5.1 Exercises

# Q1.
# How have the proportions of people identifying as Democrat, Republican, and Independent changed over time?

# A1.
forcats::gss_cat %>% 
  count(year, partyid) %>%                         # Without this, 'year' and 'partyid' not recognised in ggplot(). Not sure why
  group_by(year) %>%
  mutate(proportion = n / sum(n)) %>%
  ggplot(aes(year, proportion, colour = partyid)) +
  geom_line()

# Answer from https://jrnold.github.io/e4qf/factors.html#exercises-37 also :
# Grouped the many 'partyid' values into a succinct Democrat/ Republican/ Independent/ Other ...with fct_collapse()
# And reordered the Legend                                                                   ...with fct_reorder2()
# And showed each year's datapoints                                                          ...with geom_point()
# And renamed the Legend from 'partyid' to "Party ID."                                       ...with labs()
gss_cat %>% 
  mutate(partyid = 
           fct_collapse(partyid,
                        other = c("No answer", "Don't know", "Other party"),
                        rep = c("Strong republican", "Not str republican"),
                        ind = c("Ind,near rep", "Independent", "Ind,near dem"),
                        dem = c("Not str democrat", "Strong democrat"))) %>%
  count(year, partyid)  %>%
  group_by(year) %>%
  mutate(p = n / sum(n)) %>%
  ggplot(aes(x = year, y = p,
             colour = fct_reorder2(partyid, year, p))) +
  geom_point() +
  geom_line() +
  labs(colour = "Party ID.")


# Q2.
# How could you collapse rincome into a small set of categories?
forcats::gss_cat$rincome           # This listed values for the first 1000 rows
levels(forcats::gss_cat$rincome)   # Shows that there are only 16 different values in total

# A2.
# Group 'non-responses' together into one category
forcats::gss_cat %>%
  mutate(rincome = fct_collapse(rincome,
                                  `Unknown` = c("No answer", "Don't know", "Refused", "Not applicable"))) %>%
  ggplot(aes(x = rincome)) +
  geom_bar() + 
  coord_flip()

# Answer from https://jrnold.github.io/e4qf/factors.html#exercises-37 [below] also created 'consistent bin size'
# (re. 15.3.1 Exercises Q1) ...with fct_collapse() after using str_c()
library("stringr")
gss_cat %>%
  mutate(rincome = 
           fct_collapse(
             rincome,
             `Unknown` = c("No answer", "Don't know", "Refused", "Not applicable"),
             `Lt $5000` = c("Lt $1000", str_c("$", c("1000", "3000", "4000"),
                                              " to ", c("2999", "3999", "4999"))),
             `$5000 to 10000` = str_c("$", c("5000", "6000", "7000", "8000"),
                                      " to ", c("5999", "6999", "7999", "9999"))
           )) %>%
  ggplot(aes(x = rincome)) +
  geom_bar() + 
  coord_flip()

XXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXXX
# (re. Answer above.) I don't follow how piecing together a heading with str_c() will 'grab' the records it relates to.
# So, this answer [below] also works to create 'consistent bin size', and makes sense to me :
library("stringr")
gss_cat %>%
  mutate(rincome = 
           fct_collapse(rincome,
             `Unknown` = c("No answer", "Don't know", "Refused", "Not applicable"),
             `Lt $5000` = c("Lt $1000", "$1000 to 2999", "$3000 to 3999", "$4000 to 4999"),
             `$5000 to 10000` = c("$5000 to 5999", "$6000 to 6999", "$7000 to 7999", "$8000 to 9999")
           )) %>%
  ggplot(aes(x = rincome)) +
  geom_bar() + 
  coord_flip()


