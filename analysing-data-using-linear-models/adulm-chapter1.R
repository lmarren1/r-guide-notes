##------------------------------------------------------------------------------
## Book: Analyzing Data Using Linear Models
## Chapter: 1 - Variables, Variation, and Co-variation
## Date(s): 10/29/24 to 11/2/24
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

# Best ways to represent a distribution

# frequency plots tell us about the distribution of a variable
# histograms bin together frequency plot data
# great for continuous data and data with many values

##------------------------------------------------------------------------------
## Section 8: Frequencies, proportions, and cumulative frequencies and proportions
##------------------------------------------------------------------------------

# relative frequency - frequency of observations that meet criteria
# cumulative frequency - summing frequencies up to a certain point
# cumulative proportion - summing proportions relative to the population in question

# 10/30/24

##------------------------------------------------------------------------------
## Section 9: Frequencies and proportions in R
##------------------------------------------------------------------------------

library(tidyverse)
mtcars <- mtcars |> as_tibble()
mtcars

library(janitor)
mtcars |>
  tabyl(cyl) ## how many observations belong to a specific "cyl" col value

# n = frequency, percent = proportion

# cumfreq, cumsum
mtcars |>
  tabyl(cyl) |>
  mutate(proportion = n/sum(n)) |>
  mutate(cumfreq = cumsum(n),
         cumprop = cumsum(proportion)) ## 56% have 6 cylinders or less

# frequency plot
mtcars |>
  ggplot(aes(x = mpg)) +
  geom_freqpoly()

# histogram
mtcars |>
  ggplot(aes(x = mpg)) +
  geom_histogram(breaks = seq(5, 40, 5)) +
  scale_y_continuous(breaks = seq(0, 12, 1), minor_breaks = NULL)

##------------------------------------------------------------------------------
## Section 10: Quartiles, quantiles, and percentiles
##------------------------------------------------------------------------------

# Best brief summarizers of distributions

# quantiles are the values below which 25, 50, or 75% of the data fall
# quartiles are the groups in which they fall

# can find quantiles/quartiles using cumulative proportions/frequencies

# 0.81 quantile = 81st percentile

##------------------------------------------------------------------------------
## Section 11: Quantiles in R
##------------------------------------------------------------------------------

library(tidyverse)

mtcars$mpg |>
  quantile(probs = c(0.25, 0.50, 0.75, 0.90)) ## Selects quantile values @ specific quantiles (the probs)

##------------------------------------------------------------------------------
## Section 12: Measures of central tendency
##------------------------------------------------------------------------------

# Around which value does your distribution tend to cluster?
# See mean, median, and mode.

# Mean = average. Use with pretty symmetric distributions
# Very sensitive to extreme values.

# Median = middle value of an ordered sequence. Use Median for less symmetric distributions.
# More stable than mean.

# Mode = value we see most frequently in a sequence of values.
# Value with largest frequency.
# Unaffected by extremes, used for less symmetric distributions.

##------------------------------------------------------------------------------
## Section 13: Relationship between measures of tendency and measurement level
##------------------------------------------------------------------------------

# numeric values - mean, median, mode are meaningful

# ordinal values - median, mode are meaningful

# categorical values - mode is meaningful

##------------------------------------------------------------------------------
## Section 14: Measures of central tendency in R
##------------------------------------------------------------------------------

library(tidyverse)

# Mean and median.
mtcars |>
  summarise(mean_cyl = mean(cyl),
            median_cyl = median(cyl))

# There's no mode in base R. So here's a get mode function
getmode <- function(variable){
  unique_values <- unique(variable)
  unique_values[
    match(variable, unique_values) |>
      tabulate() |>
      which.max()
  ]
}

mtcars |>
  summarise(mode_cyl = getmode(cyl))

##------------------------------------------------------------------------------
## Section 15: Measures in variation
##------------------------------------------------------------------------------

# How much variation are in variables

# Range = distance between lowest and highest value

# IQR interquartile range = distance between first and 3rd quartile

# sum of squares (of deviations) - makes it so that negative and positive deviations are equal
# Measure of total variation.

# average of the sum of squares = variance (ss/n)
# Average squared deviation from the mean.

# Standard deviation = square root of the variance; how deviant a particular value is from the rest of the values

##------------------------------------------------------------------------------
## Section 16: Variance, std, and standaradisation in R
##------------------------------------------------------------------------------

library(tidyverse)

# Calculate variance, std
mtcars |>
  summarise(var_mpg = var(mpg),
            std_mpg = sd(mpg))

# Above divides sum of squares by n-1, if you want to divide only by n, use below
var_n <- function(variable){
  SS <- (variable - mean(variable))**2 |>
    sum()
  return(SS/length(variable)) # dividing by n
}

mtcars |>
  summarise(var_mpg = var_n(mpg),
            std_mpg = sqrt(var_n(mpg))) # taking the square root

mtcars |>
  mutate(z_mpg = scale(mpg)) |>
  select(mpg, z_mpg)

# scale gives the z-score of the values.

##------------------------------------------------------------------------------
## Section 17: Density Plots
##------------------------------------------------------------------------------

# Density plot - way to show frequency of values distributed across a continuum
# Suited for large amounts of continuous values (1000+)

##------------------------------------------------------------------------------
## Section 18: Density plots in R
##------------------------------------------------------------------------------

# Density plot
mtcars |>
  ggplot(aes(x = mpg)) +
  geom_density()

# Histogram
mtcars |>
  ggplot(aes(x = mpg)) +
  geom_histogram(bins = 8) ## when you want to divide the data into 8 bins

# Density plot with histogram
mtcars |>
  ggplot(aes(x = mpg)) +
  geom_histogram(aes(y = after_stat(density)), bins = 10) +
  geom_density()

##------------------------------------------------------------------------------
## Section 19: The normal distribution
##------------------------------------------------------------------------------

# Empirical distributions sometimes resemble theoretical distributions

# Mean = mode = median
# Each inflexion point is one standard deviation away from the mean

# Standardized values have mean of 0 and an SD of 1 - denoted by z-scores or the like

# 68 - 95 - 99.7 rule (empirical rule)

##------------------------------------------------------------------------------
## Section 20: Obtaining quantiles of the normal distribution using R
##------------------------------------------------------------------------------

# 5% is 75.3 or less, 50% is 100 or less ... etc
qnorm(c(0.05, 0.50, 0.95), mean = 100, sd = 15)

# cumulative proportion of a certain value that is normally distributed
pnorm(-1, mean = 0, sd = 1) ## 15.86% of values are -1 or less

##------------------------------------------------------------------------------
## Section 21: Visualizing numeric variables: the box plot
##------------------------------------------------------------------------------

# IQR = height of the box in a box plot

# Outliers are more than 1.5 times the IQR away from the median

# Visualize in what range the middle half of the values are

##------------------------------------------------------------------------------
## Section 22: Box plots in R
##------------------------------------------------------------------------------

mtcars |>
  ggplot(aes(x = "", y = mpg)) +
  geom_boxplot() +
  xlab("") ## the x-axis is meaningless

##------------------------------------------------------------------------------
## Section 23: Visualizing categorical variables
##------------------------------------------------------------------------------

# Histogram, density plot, and box plot can be used for numeric and ordinal variables that can be treated numerically

# Counts of categorical variables are displayed as bar graphs, pie charts
# Avoid pie charts - replace them with bar graphs because they don't show proportions well and they don't show counts

# Ordinal variables - best visualized with bar graphs

##------------------------------------------------------------------------------
## Section 24: Visualizing categorical and ordinal variables in R
##------------------------------------------------------------------------------

# If categorical is stored as numeric -> factorize

library(tidyverse)

# Geom Bar
mtcars |>
  mutate(cyl = factor(cyl, ordered = TRUE)) |>
  ggplot(aes(x = cyl)) +
  geom_bar()

##------------------------------------------------------------------------------
## Section 25: Visualizing co-varying variables
##------------------------------------------------------------------------------

# categorical by categorical Cross table - nice way to show how categorical variables co-vary

# Categorical by numerical -> box plot
# boxes = categorical, whiskers = numerical

# numeric by numeric - scatter plot

##------------------------------------------------------------------------------
## Section 26: Visualizing variables using R
##------------------------------------------------------------------------------

# scatter plot w geom_point
mtcars |>
  ggplot(aes(x = wt, y = mpg)) +
  geom_point()

# boxplot w categorical and numeric
mtcars |>
  mutate(cyl = factor(cyl)) |>
  ggplot(aes(x = cyl, y = mpg)) +
  geom_boxplot()

# cross table for 2 categorical variables
library(janitor)
mtcars |> tabyl(cyl, gear)

