## #########
# LDS LSADATA, chap 8 Daniel ANOVA
#
# Refer to the serum lipid-bound sialic acid data on 1400 subjects (LSADATA). We wish to conduct a study to determine 
# if the measurement of serum lipid-bound sialic acid (LSA) might be of use in the detection of breast cancer. The LSA 
# measurements (mg/dl) are for four populations of subjects: normal controls, A; patients with benign breast disease, 
# B; patients with primary breast cancer, C; and patients with recurrent metastatic breast cancer, D. Select a simple 
# random sample of size 10 from each population and perform an appropriate analysis to determine if we may conclude that 
# the four population means are different. 
# Let α = .05 and determine the p value. 
# Test all possible pairs of sample means for significance. What conclusions can one draw from the analysis?

library(tidyverse)

#
LSAdata <- read_csv("~/DropBox/GitHub/ProbEstad/DataSets/ch08_all/LDS_C08_LSADATA.csv", show_col_types = FALSE)
LSAdata
# Now change the column names according to the LDS descriptiom: Subject#:Col1, Controls:Col2
# patients with benign breast disease (BBD):Col3, patients with primary breast cancer (PBC):Col4
# patients with recurrent metastatic breast cancer (RMBC)
LSAdata <- LSAdata %>% 
  rename(Subj = Col1, Cont = Col2, BBD = Col3, PBC = Col4, RMBC = Col5)
LSAdata

LSAdata_n <- LSAdata %>% 
  select("Cont", "BBD", "PBC", "RMBC")
LSAdata_n

# Make LSAdata long
LSAdata_long <- LSAdata_n %>%
  pivot_longer(cols = everything(), names_to = "Type", values_to = "LSA")
LSAdata_long

# Make the Type of cancer variable a factor and then re-level to group and compare to Cont
LSAdata_long <- LSAdata_long %>% 
  mutate( Type = factor(Type) )
LSAdata_long <- LSAdata_long %>% 
  mutate( Type = Type %>% fct_relevel("Cont","BBD","PBC","RMBC") )

# does it look right? the following boxplot will tell
# boxplot(LSA ~ Type, data = LSAdata_long)
# nicer
LSAdata_long %>% ggplot(aes(x = Type, y = LSA)) +
    geom_boxplot() +
#   geom_violin(draw_quantiles = c(0.25, 0.5, 0.75), scale = "area") +
    geom_jitter(aes(colour = Type), shape = 16, position = position_jitter(seed = 123)) +
    labs(title = "Measurement of serum Lipid-bound Sialic Acid (LSA)") +
    theme_bw()
 
# load the missing libraries
library(car)
library(emmeans)
library(rstatix)

# One Way ANOVA
# running a lm model for the ANOVA
LSAdata_lm <- lm(LSA ~ Type, data = LSAdata_long)
Anova(LSAdata_lm)
LSAdata_aov <- aov(LSA ~ Type, data = LSAdata_long)
Anova(LSAdata_aov)

# and now the emmeans to look for estimating the Tukey and 95% confidence intervals
# first the pairwise comparisons with the Control group and contrasts
# then cancer condition compared to control
emmeans(LSAdata_lm, pairwise ~ Type)
emmeans(LSAdata_lm, trt.vs.ctrl ~ Type)

# Now using the rstatix library (grappers for statistical tests)anova
LSAdata.aov <- LSAdata_long %>% anova_test(LSA ~ Type, effect.size = "ges", detailed = TRUE)
get_anova_table(LSAdata.aov)
# with emmeans
LSAdata_long %>% emmeans_test(LSA ~ Type, p.adjust.method = "fdr", detailed = TRUE)

# Now the same using non-parametric tests. For a one-Way ANOVA we use Kruskal-Wallis
# and effects size and Dunn test all from the rstatix library
res.kruskal <- LSAdata_long %>% kruskal_test(LSA ~ Type)
res.kruskal

# And estimate the Kruskal effect size
LSAdata_long %>% kruskal_effsize(LSA ~ Type)
# To estimate the pairwise corrected by multiple comparisons the Dunn's Test
pc_LSAdata <- LSAdata_long %>% dunn_test(LSA ~ Type, p.adjust.method = "fdr")
pc_LSAdata

# load coin library for estimating permutations
library(coin)
# Permutations, using the coin package
set.seed(1234)
LSAdata_aovp <- oneway_test(LSA ~ Type, data=LSAdata_long,
                  distribution=approximate(nresample=9999))
LSAdata_aovp
statistic(LSAdata_aovp) 
pvalue(LSAdata_aovp, method="global")

# Now a really nice solution with violin plots and corrected comparisons
# Thanks to the really nice library ggstatsplot
library(ggstatsplot)

ggbetweenstats( data = LSAdata_long, 
                x = Type, 
                y = LSA, 
                type = "p", 
                pairwise.display = "s", 
                p.adjust.method = "fdr", 
                outlier.tagging = TRUE, 
                title = "Measurement of serum lipid-bound sialic acid (LSA)" )
