library(ggpubr)
library(dplyr)

#One way anova
data("PlantGrowth")
summary(PlantGrowth)
head(PlantGrowth)

#order the data in preparation for the anova test
#we want to reshape our data so we have per group, the n, the average weight, and the standard div

#basic grouping with dplyr
group_by(PlantGrowth, group)

#build out more complicated data manipulations using the dplyr syntax
PlantGrowth %>% 
  group_by(group) %>%
  summarise(count = n())

#but we also want the mean weight per group, and the sd of weights per group
group_by(PlantGrowth, group) %>%
  summarise(
    count = n(),
    mean = mean(weight, na.rm = TRUE),
    sd = sd(weight, na.rm = TRUE)
  )

ggboxplot(PlantGrowth, x = "group", y = "weight", 
          color = "group", palette = c("#00AFBB", "#E7B800", "#FC4E07"),
          order = c("ctrl", "trt1", "trt2"),
          ylab = "Weight", xlab = "Treatment")


# Compute the analysis of variance
res.aov <- aov(weight ~ group, data = PlantGrowth)
?aov
# Summary of the analysis
summary(res.aov)
res.aov

### unpaired t-test 
#The unpaired two-samples t-test is used to compare the mean of two independent groups.
#To perform two-samples t-test comparing the means of two independent samples (x & y), 
#the R function t.test() can be used as follow:
#t.test(x, y, alternative = "two.sided", var.equal = FALSE)
#x,y: numeric vectors
#alternative: the alternative hypothesis. Allowed value is one of “two.sided” (default), “greater” or “less”.
#var.equal: a logical variable indicating whether to treat the two variances as being equal. 
#If TRUE then the pooled variance is used to estimate the variance otherwise the Welch test is used.

# Data in two numeric vectors
women_weight <- c(38.9, 61.2, 73.3, 21.8, 63.4, 64.6, 48.4, 48.8, 48.5)
men_weight <- c(67.8, 60, 63.4, 76, 89.4, 73.3, 67.3, 61.3, 62.4) 
# Create a data frame
subject_weights <- data.frame( 
  group = rep(c("Woman", "Man"), each = 9),
  weight = c(women_weight,  men_weight)
)

group_by(subject_weights, group) %>%
  summarise(
    count = n(),
    mean = mean(weight, na.rm = TRUE),
    sd = sd(weight, na.rm = TRUE)
  )

ggboxplot(subject_weights, x = "group", y = "weight", 
          color = "group", palette = c("#00AFBB", "#E7B800"),
          ylab = "Weight", xlab = "Groups")


## Shapiro-Wilk normality test for Men's weights
#with(subject_weights, shapiro.test(weight[group == "Man"]))
## Shapiro-Wilk normality test for Women's weights
#with(subject_weights, shapiro.test(weight[group == "Woman"])) # p = 0.6

#both have p values > 0.5, so they are significant 


# Compute t-test from vectos
t_test_1 <- t.test(women_weight, men_weight)
t_test_1

#compute t-test from dataframe
t_test_2 <- t.test(weight ~ group, data = subject_weights)
t_test_2

#if you want to test whether the average men’s weight is less than the average women’s weight, type this:
t.test(weight ~ group, data = subject_weights,
       var.equal = TRUE, alternative = "less")

#Or, if you want to test whether the average men’s weight is greater than the average women’s weight, type this
t.test(weight ~ group, data = PlantGrowth,
       var.equal = TRUE, alternative = "greater")

#continue to explore stats in R here: http://www.sthda.com/english/wiki/one-way-anova-test-in-r

