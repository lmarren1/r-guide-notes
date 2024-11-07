##------------------------------------------------------------------------------
## Book: Analyzing Data Using Linear Models
## Chapter: 2 - Inference about a mean
## Date(s): 10/2 to
##------------------------------------------------------------------------------

##------------------------------------------------------------------------------
## Section 1: Inference about a mean
##------------------------------------------------------------------------------

# We would like to infer from a discrete number of measurements what the mean of the variable is had we measured continuously

# Problem of stat inference is when you want to say something about that complete data set (the population), but you only observe a relatively small portion of the data (the sample)

##------------------------------------------------------------------------------
## Section 2: Sampling distribution of mean and variance
##------------------------------------------------------------------------------

# Sampling distribution of the sample mean - distribution of means of a bunch of samples

# The mean of a sample is on average a good estimate of the pop mean

# We can also have the sampling distribution of the sample variance

# population - all values, both observed and unobserved

##------------------------------------------------------------------------------
## Section 3: The effect of sample size
##------------------------------------------------------------------------------

# e.g.:

# sample mean = unbiased estimator of population mean bc EV = pop mean

# sample var = biased estimator, because values for variances were too low

# central limit theorem: distributions become normal for large sample sizes

# to correct for the sample var bias, we multiply S^2 by n / n - 1

##------------------------------------------------------------------------------
## Section 4: The standard error
##------------------------------------------------------------------------------

# standard deviation of the sample means = standard error (standard error of the mean)

# standard error of the mean is a function of sample size and pop variance
# sqrt of pop variance over sample size

# measure of the uncertainty about the population mean
# measures how close you are to the population mean
# std of the sampling distribution of the sample mean

##------------------------------------------------------------------------------
## Section 5: Confidence Intervals
##------------------------------------------------------------------------------

# z-score for sample means = for a given sample mean, subtract the pop mean and divide by the std of the sample means (the standard error)

# CI formula = pop mean - percent critical value on the standard normal distribution * standard error

# 1.96 (or another critical value) * standard error = margin of error (MoE)

# If you know the pop mean, you can construct an MoE based interval to say where some percent of the sample means will lie
# e.g. pop mean - MoE, pop mean + MoE

# when computing from one sample, it represents 95% of the sample means had the pop mean been equal to the sample mean

##------------------------------------------------------------------------------
## Section 6: The t-statistic
##------------------------------------------------------------------------------

# T-stat dist is "heavy tailed"
# 95% of the observations lie between +/- 3.18
# pop. variance unknown -> use sample variance in SE (sqrt(s^2/n))

##------------------------------------------------------------------------------
## Section 7: Interpreting confidence intervals
##------------------------------------------------------------------------------

# CI is constructed as if you know the pop mean and var - which we don't.

# CORRECT: The 95% interval around the pop. mean contains 95% of the sample means.
# INCORRECT: With 95% prob, the 95% CI contains the pop. mean

# Given you take many independent samples from the pop., you can expect that 95% of the CIs constructed based on the sample means will contain that pop mean

##------------------------------------------------------------------------------
## Section 8: t-distributions and degrees of freedom
##------------------------------------------------------------------------------

# The standardized deviation of a sample mean from a hypothesized population mean has a t-distribution

# Higher the degrees of freedom, the more it resembles the normal distribution

# degrees of freedom: amount of info we have -> dependent on how much data we have
# degrees of freedom = number of values in the final calculation of the statistic that are free to vary
# dfs = number of independent scores that go into the estimate - the number of parameters used as intermediate steps in the estimation of the parameter itself

# once you know the mean of n elephants, you can give imaginary values for the heights of n-1 elephants (degrees of freedom)

# e.g. - sample size = n, pop var = unknown, shape of standarized sample means (t-scores) of fictitious new samples is that of a t-dist with n-1 degrees of freedom

##------------------------------------------------------------------------------
## Section 9: Constructing confidence intervals
##------------------------------------------------------------------------------

# Take test statistic (t-statistic e.g.) and unstandardize (mean +/- test stat * standard error)

# 1 compute sample mean
# 2 estimate pop variance (sum of deviations) / n - 1
# 3 estimate standard error (sqrt(pop var est/n))
# 4 compute degrees of freedom as n-1
# 5 look up t-stat
# 6 compute margin of error (MoE) as t-stat * standard error
# 7 mean +/- MoE

##------------------------------------------------------------------------------
## Section 10: Obtaining a confidence interval for a population mean in R
##------------------------------------------------------------------------------

library(tidyverse)

mtcars$mpg |> mean()

t.test(mtcars$mpg, conf.level = 0.99)$conf.int

# Based on our sample of 32 cars, we found an estimate for the mean mileage in the population of 20.1 miles per gallon (99% CI: 17.2, 23.0).

##------------------------------------------------------------------------------
## Section 11: Null-hypothesis testing
##------------------------------------------------------------------------------

# assume the null-hypothesis is true and then compare the sample data with data that would result if the null-hypothesis were true

# Sampling dist under null hyp:
# pop mean = null mean, pop standard deviation (error) = sqrt(sample variance/n), dfs = sample size minus 1

# define acceptance and rejection regions where 95% of the sample means would fall if the null-hypothesis is true and a rejection region where 5% of the sample means would fall if the null-hyp is true

##------------------------------------------------------------------------------
## Section 12: Null-hypothesis testing with t-values
##------------------------------------------------------------------------------

# standardize the sample mean by subtracting the null mean and dividing by the standard error

# critical value = where the acceptance and rejection regions connect

# 1 estimate the standard error
# 2 calculate the t-statistic
# 3 determine the dfs
# 4 determine the critical values
# 5 If the t-stat is in-between the critical values we're in the acceptance/plausibility region, else we reject

##------------------------------------------------------------------------------
## Section 13: The p-value
##------------------------------------------------------------------------------

# p-value = prob of finding a t-value equal or more extreme than the one found, assuming the null hypothesis is true

# when results show that null-hyp can be rejected -> statistically significant result, else non significant (this says nothing about the importance or size of the results)

##------------------------------------------------------------------------------
## Section 14: Null-hypothesis testing using R
##------------------------------------------------------------------------------

data(lh)

t.test(lh, mu = 2.54) ## Test whether population mean could be 2.54
var(lh) ## sample variance

# p-value > 0.05 -> do not reject
# Omit zero in front of the p-value

# Report: we tested the null-hyp that the mean LH level is 2.54. Taking a sample of 48 measurements, we obtained a mean of 2.40. A t-test showed that this sample mean was not significantly different from 2.54, t(47) = -1.758, p = .085.

##------------------------------------------------------------------------------
## Section 15: One-sided versus two-sided testing
##------------------------------------------------------------------------------
