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

ggplot(HERS_nodi, aes(x = BMI, y = LDL)) +
  geom_point(shape = 16, aes(color = exercise)) +
  labs(title = "Measurement of LDL vs. Body Mass Index") +
  theme_bw()

ggplot(HERS_nodi, aes(x = exercise, y = LDL)) +
  geom_boxplot() +
  geom_jitter(aes(color = exercise), shape = 16, height = 0.1, width = 0.1) +
  labs(title = "Measurement of LDL vs. exercise") +
  theme_bw()

HERSnodi_lm01 <- lm(LDL ~ BMI * exercise, data = HERS_nodi)
summary.aov(HERSnodi_lm01)

HERSnodi_lm02 <- lm(LDL ~ exercise * BMI, data = HERS_nodi)
summary.aov(HERSnodi_lm02)

# Estimate the simplest model, the interaction is not significant
# fit different intercepts for exercise ne and yes with the same slope to both graphs
HERSnodi_lm <- lm(LDL ~ exercise + BMI, data = HERS_nodi)
anova(HERSnodi_lm02, HERSnodi_lm)

summary.lm(HERSnodi_lm)

ggplot(HERS_nodi, aes(x = BMI, y = LDL, color = exercise)) +
  geom_point(shape = 20) +
  geom_abline(aes(intercept = 133.05, slope = 0.5181)) +
  geom_abline(aes(intercept = 133.05-4.16, slope = 0.5181)) +
  labs(title = "ANCOVA of LDL vs. Body Mass Index with exercise") +
  theme_bw()

# glucose model
ggplot(HERS_nodi, aes(x = exercise, y = glucose)) +
  geom_boxplot() +
  geom_jitter(aes(color = exercise), shape = 20, height = 0.1, width = 0.1) +
  labs(title = "Measurement of glucose") +
  theme_bw()

HERSnodi_glu <- lm(glucose ~ exercise, data = HERS_nodi)
# Linear model results can be printed with summary
summary(HERSnodi_glu)

