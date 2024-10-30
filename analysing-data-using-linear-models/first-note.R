##------------------------------------------------------------------------------
## Book: Analyzing Data Using Linear Models
## Chapter: 1 - Variables, Variation, and Co-variation
## Sections: 1-
## Date(s): 10/29 to
##------------------------------------------------------------------------------

##------------------------------------------------------------------------------
## Section 1: Units, variables, and the data matrix
##------------------------------------------------------------------------------

# objects/units/observations = rows
# variables/properties = columns

##------------------------------------------------------------------------------
## Section 2: Data matrices in R
##------------------------------------------------------------------------------

library(tidyverse)
studentID <- seq(4132211, 4132215) ## Bound-inclusive
course <- c("Chemistry", "Physics", "Math", "Math", "Chemistry") ## this is one column
grade <- c(4, 6, 3, 6, 8)
shirtsize <- c("medium", "small", "large", "medium", "small")
tibble(studentID, course, shirtsize, grade)

##------------------------------------------------------------------------------
## Section 3: Multiple observations: wide format and long format data matrices
##------------------------------------------------------------------------------

# Long format - each measurement is a separate row, columns are like: ID, var name, value, better for stat analysis, more efficient; required by R
# Most important variable in analysis is stored in only one column

# Wide format - easier to read at a glance; each subject/observation is a single # row, and each variable is a separate column

##------------------------------------------------------------------------------
## Section 4: Wide and long format in R
##------------------------------------------------------------------------------

library(tidyverse)
client <- c(1, 2)
Monday <- c(5, NA)
Tuesday <- c(6, NA)
Wednesday <- c(NA, NA)
Thursday <- c(NA, NA)
Friday <- c(NA, NA)
Saturday <- c(NA, 8)
Sunday <- c(NA, 7)
data_wide <- tibble(client, Monday, Tuesday, Wednesday, Thursday, Friday, Saturday, Sunday)

data_wide |>
  pivot_longer(cols = Monday:Sunday, ## columns that need to be restructured
               names_to = "day", ## name of new variable with old column names
               values_to = "depression", ## name of new variable with values
               values_drop_na = TRUE) ## leave out rows with missing values

client <- c(1, 1, 2, 2, 3, 3)
time <- c("before", "after", "after", "before", "before", "after")
depression <- c(9, 13, 12, 14, 19, 15)
data_long <- tibble(client, time, depression) ## long format

data_long |>
  pivot_wider(names_from = time,
              values_from = depression) ## names_from = name of variable used for new col names
# values_from = name of variable that stores values spread across cols

##------------------------------------------------------------------------------
## Section 5: Measurement level
##------------------------------------------------------------------------------

# data analysis is about variation and co-variation in variables

# numeric variables - discrete or continuous = quantitative variables
# two types - interval and ratio variables
# interval e.g. - is one place twice as warm as another? No! ratio here = meaningless
# ratio variables have a meaningful zero point

# ordinal variables, unlike numeric ones, are not measured in units
# usually discrete, can show order

# categorical variables aren't about quantity at all
# yes/no categories are called "dichotomous" variables
# nominal variables are categorical ones that have to do with names

# ensure categorical variables are treated as such and not mistaken as numeric

# ordinal variables can be treated as either numeric or categorical
# remember: making them numeric means that the diff b/w 1 and 2 is the same as that between 3 and 4

##------------------------------------------------------------------------------
## Section 6: Measurement level in R
##------------------------------------------------------------------------------

studentID <- seq(4132211, 4132215) ## this is a meaningless numeric value
course <- c("Chemistry", "Physics", "Math", "Math", "Chemistry")
grade <- c(4, 6, 3, 6, 8)
shirtsize <- c("medium", "small", "large", "medium", "small") ## stored as a character, yet we want it to be an ordinal variable -> factor
course_results <- tibble(studentID, course, shirtsize, grade)
course_results

course_results$studentID <- course_results$studentID |>
  factor() ## factor makes things ordinal (numeric) or categorical

course_results <- course_results |>
  mutate(course = factor(course))

course_results$studentID ## notice how this has levels to it

course_results <- course_results |>
  mutate(shirtsize = factor(shirtsize,
                            levels = c("small", "medium", "large"),
                            ordered = TRUE)) ## make ordinal factor
course_results$shirtsize

course_results

##------------------------------------------------------------------------------
## Section 7: Frequency tables, frequency plots, and histograms
##------------------------------------------------------------------------------

# frequency plots tell us about the distribution of a variable
# histograms bin together frequency plot data
# great for continuous data and data with many values

##------------------------------------------------------------------------------
## Section 8: Frequencies, proportions, and cumulative frequencies and proportions
##------------------------------------------------------------------------------

# relative frequency - frequency of observations that meet criteria
# cumulative frequency - summing frequencies up to a certain point
# cumulative proportion -
