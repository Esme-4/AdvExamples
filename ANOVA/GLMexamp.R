# HERS data examples for Regression course
# loading libraries
library(tidyverse)
library(rstatix)
library(car)

# Direct file load from GitHub
HERS <- read_csv("https://raw.githubusercontent.com/fabarrios/Class2020/master/DataRegressBook/Chap3/hersdata.csv", show_col_types = FALSE)

HERS %>% get_summary_stats("weight", "BMI", "waist", "WHR", "glucose", 
                           "weight1", "BMI1", "waist1", "WHR1", "glucose1")

# HERS data for non-diabetic
HERS_nodi <- filter(HERS, diabetes == "no")
HERS_nodi_lm <- lm(glucose ~ exercise, data = HERS_nodi)
# Linear model results can be printed with summary
summary(HERS_nodi_lm)

ggplot(HERS_nodi, aes(x = exercise, y = glucose)) +
         geom_boxplot() +
         geom_jitter(aes(color = raceth), shape = 16, position = position_jitter(seed = 123)) +
         labs(title = "Measurement of glucose") +
         theme_bw()

anova(HERS_nodi_lm)

