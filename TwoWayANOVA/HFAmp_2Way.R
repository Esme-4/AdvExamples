
# Two-way ANOVA example
# Daniel review problem C08_17


HRV <- read_csv("https://raw.githubusercontent.com/fabarrios/ProbEstad/master/DataSets/ch08_all/REV_C08_17.csv", show_col_types = FALSE)

HRV %>% get_summary_stats("AMP", "SMOKE")

HRV %>% ggplot(aes(x = VEG, y = AMP, fill = SMOKE)) +
  geom_col()

HRV_aov <- aov(AMP ~ factor(VEG) * factor(SMOKE), data = HRV)
summary(HRV_aov)

HRV_lm <- lm(AMP ~ factor(VEG) * factor(SMOKE), data = HRV)
summary(HRV_lm)

attach(HRV)
  interaction.plot(VEG, SMOKE, AMP)
detach(HRV)
# Altos valores de HRV están asociados con altos consumos de oxígeno, mientras que bajos valores denotan 
# incrementos en la mortalidad y un alto riesgo de patologías cardiacas en pacientes asintomáticos.
  
emmeans(HRV_aov, trt.vs.ctrl ~ VEG + SMOKE)
emmeans(HRV_aov, pairwise ~ VEG + SMOKE)

#  Example One-Way ANOVA
# 
Bilir <- read_csv("https://raw.githubusercontent.com/fabarrios/ProbEstad/master/DataSets/ch08_all/REV_C08_39.csv", show_col_types = FALSE)

