
# Two-way ANOVA example
# Daniel review problem C08_17
HFAmp <- read_csv("https://raw.githubusercontent.com/fabarrios/ProbEstad/master/DataSets/ch08_all/REV_C08_17.csv", show_col_types = FALSE)

HFAmp %>% get_summary_stats("AMP", "SMOKE", "VEG")
