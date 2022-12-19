#===============================================================================
#DATA TRANSFORMATION
#===============================================================================

library(tidyverse)

data <- read_csv("C:/Users/Mantas/Downloads/1-sample_data (1).csv")

select(data, y)

data %>%
  select(y)

additional_features <- read_csv("C:/Users/Mantas/Downloads/3-additional_features (1).csv")

joined_data <- inner_join(data, additional_features, by = "id")


joined_data <- data %>%
  inner_join(additional_features, by = "id")


write_csv(joined_data, "C:/Users/Mantas/Downloads/train_data.csv")
