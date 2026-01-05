# Load required libraries
library(ptestr)
library(lmerTest)
library(stats)
library(readr)

setwd('~/Downloads/PhD/Analysis/Tianeptine/Static_FC/Jupyter_test_notebook/Analysis/Mean_wDC/')

### Baseline ###
hyper_wDC_df <- read.csv("hyper_LMM.csv")
hyper_wDC_df <- hyper_wDC_df[, -1]

hyper_wDC_df_baseline <- subset(hyper_wDC_df, drug == 0)
hyper_wDC_df_baseline <- hyper_wDC_df_baseline[, -which(names(hyper_wDC_df_baseline) == "drug")]
hyper_wDC_df_baseline <- hyper_wDC_df_baseline[, -which(names(hyper_wDC_df_baseline) == "ID")]

hyper_wDC_df_baseline.permuted <- grouped_perm_glm(hyper_wDC_df_baseline, formla = wDC ~ group + mFD, var_to_perm='wDC', permNum = 5000, seed = 42)

###############
hypo_wDC_df <- read.csv("hypo_LMM.csv")
hypo_wDC_df <- hypo_wDC_df[, -1]

hypo_wDC_df_baseline <- subset(hypo_wDC_df, drug == 0)
hypo_wDC_df_baseline <- hypo_wDC_df_baseline[, -which(names(hypo_wDC_df_baseline) == "drug")]
hypo_wDC_df_baseline <- hypo_wDC_df_baseline[, -which(names(hypo_wDC_df_baseline) == "ID")]

hypo_wDC_df_baseline.permuted <- grouped_perm_glm(hypo_wDC_df_baseline, formla = wDC ~ group + mFD, var_to_perm='wDC', permNum = 5000, seed = 42)

########################################################

### Comprehensive models ###
hyper_wDC_df <- read.csv("hyper_LMM.csv")
hyper_wDC_df <- hyper_wDC_df[, -1]

hyper_wDC.permuted <- grouped_perm_glmm(hyper_wDC_df, formla = wDC ~ group * drug + mFD + (1|ID), var_to_perm='wDC', permNum = 5000, seed = 42)

write_csv(hyper_wDC.permuted, "hyper_model_output.csv")
###############
hypo_wDC_df <- read.csv("hypo_LMM.csv")
hypo_wDC_df <- hypo_wDC_df[, -1]

hypo_wDC.permuted <- grouped_perm_glmm(hypo_wDC_df, formla = wDC ~ group * drug + mFD + (1|ID), var_to_perm='wDC', permNum = 5000, seed = 42)

write_csv(hypo_wDC.permuted, "hypo_model_output.csv")

########################################################

### Within-group Models ###
# Filter rows where group = 0
hyper_wDC_df_NT <- subset(hyper_wDC_df, group == 0)

# Remove the group column
hyper_wDC_df_NT <- hyper_wDC_df_NT[, -which(names(hyper_wDC_df_NT) == "group")]

# Alternatively, you can remove the column by column index
# hyper_wDC_df_NT <- hyper_wDC_df_NT[, -2]

hyper_wDC_NT.permuted <- grouped_perm_glmm(hyper_wDC_df_NT, formla = wDC ~ drug + mFD + (1|ID), var_to_perm='wDC', permNum = 5000, seed = 42)

write_csv(hyper_wDC_NT.permuted, "hyper_NT_model_output.csv")
###############
# Filter rows where group = 1
hyper_wDC_df_A <- subset(hyper_wDC_df, group == 1)

# Remove the group column
hyper_wDC_df_A <- hyper_wDC_df_A[, -which(names(hyper_wDC_df_A) == "group")]

# Alternatively, you can remove the column by column index
# hyper_wDC_df_A <- hyper_wDC_df_A[, -2]

hyper_wDC_A.permuted <- grouped_perm_glmm(hyper_wDC_df_A, formla = wDC ~ drug + mFD + (1|ID), var_to_perm='wDC', permNum = 5000, seed = 42)

write_csv(hyper_wDC_A.permuted, "hyper_A_model_output.csv")
###############
# Filter rows where group = 0
hypo_wDC_df_NT <- subset(hypo_wDC_df, group == 0)

# Remove the group column
hypo_wDC_df_NT <- hypo_wDC_df_NT[, -which(names(hypo_wDC_df_NT) == "group")]

# Alternatively, you can remove the column by column index
# hypo_wDC_df_NT <- hypo_wDC_df_NT[, -2]

hypo_wDC_NT.permuted <- grouped_perm_glmm(hypo_wDC_df_NT, formla = wDC ~ drug + mFD + (1|ID), var_to_perm='wDC', permNum = 5000, seed = 42)

write_csv(hypo_wDC_NT.permuted, "hypo_NT_model_output.csv")
###############
# Filter rows where group = 1
hypo_wDC_df_A <- subset(hypo_wDC_df, group == 1)

# Remove the group column
hypo_wDC_df_A <- hypo_wDC_df_A[, -which(names(hypo_wDC_df_A) == "group")]

# Alternatively, you can remove the column by column index
# hypo_wDC_df_A <- hypo_wDC_df_A[, -2]

hypo_wDC_A.permuted <- grouped_perm_glmm(hypo_wDC_df_A, formla = wDC ~ drug + mFD + (1|ID), var_to_perm='wDC', permNum = 5000, seed = 42)

write_csv(hypo_wDC_A.permuted, "hypo_A_model_output.csv")

########################################################
### FDR correction ###
corr_p_vals <- p.adjust(c(0.043, 0.099, 0.335, 0.017, 0.980, 0.872, 0.052, 0.002), method = "BY")
corr_p_vals

########################################################
### DoF estimation ###

## Interactions ##
# Frontoparietal
hyper_wDC.get_DoF <- lmer(
  wDC ~ group * drug + mFD + (1|ID),
  data = hyper_wDC_df
)
summary(hyper_wDC.get_DoF)

# Sensorimotor
hypo_wDC.get_DoF <- lmer(
  wDC ~ group * drug + mFD + (1|ID),
  data = hypo_wDC_df
)
summary(hypo_wDC.get_DoF)

## Within-A ##
# Frontoparietal
hyper_wDC_A.get_DoF <- lmer(
  wDC ~ drug + mFD + (1|ID),
  data = hyper_wDC_df_A
)
summary(hyper_wDC_A.get_DoF)

# Sensorimotor
hypo_wDC_A.get_DoF <- lmer(
  wDC ~ drug + mFD + (1|ID),
  data = hypo_wDC_df_A
)
summary(hypo_wDC_A.get_DoF)
