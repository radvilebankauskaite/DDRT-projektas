#===============================================================================
#EXPLANATORY ANALYSIS
#===============================================================================

library(tidyverse)
library(knitr)
h2o.init()

df <- h2o.importFile("C:/Users/Mantas/Downloads/train_data.csv")

dim(df)

summary(df[1:6])

summary(df[7:13]) %>%
  kable()

df$loan_purpose <- as.factor(df$loan_purpose)
df$y <- as.factor(df$y)

summary(df$loan_purpose) %>%
  kable()

h2o.shutdown()