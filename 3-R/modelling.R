#===============================================================================
#MODELLING
#===============================================================================

library(h2o)
library(tidyverse)
h2o.init()

df <- h2o.importFile("C:/Users/Mantas/Downloads/train_data.csv")
class(df)
summary(df)

y <- "y"
x <- setdiff(names(df), c(y, "id"))
df$y <- as.factor(df$y)
summary(df)


splits <- h2o.splitFrame(df, c(0.98,0.01), seed=123)
train  <- h2o.assign(splits[[1]], "train")
valid  <- h2o.assign(splits[[2]], "valid")
test   <- h2o.assign(splits[[3]], "test")

aml <- h2o.automl(x = x,
                  y = y,
                  training_frame = train,
                  validation_frame = valid,
                  max_runtime_secs = 120)

aml@leaderboard

model980101 <- aml@leader

h2o.performance(model980101, train = TRUE)
perf_valid <- h2o.performance(model980101, valid = TRUE)
h2o.auc(perf_valid)
h2o.performance(model980101, newdata = test)
plot(perf_valid, type = "roc")

### GBM

gbm_params2 <- list(max_depth = c(20),
                    sample_rate = c(0.8, 1.0))

gbm_grid2 <- h2o.grid("gbm", 
                      x = x, 
                      y = y,
                      grid_id = "gbm_grid2",
                      training_frame = train,
                      validation_frame = valid,
                      ntrees = 100,
                      seed = 1,
                      hyper_params = gbm_params2)

# Get the grid results, sorted by validation AUC
gbm_gridperf2 <- h2o.getGrid(grid_id = "gbm_grid2",
                             sort_by = "auc",
                             decreasing = TRUE)
print(gbm_gridperf2)

model_gbm2 <- h2o.getModel("gbm_grid2_model_2")

test_data <- h2o.importFile("C:/Users/Mantas/Downloads/test_data.csv")
h2o.performance(model_gbm2, newdata = test_data)

predictions <- h2o.predict(model_gbm2, test_data)

predictions %>%
  as_tibble() %>%
  mutate(id = row_number(), y = p0) %>%
  select(id, y) %>%
  write_csv("C:/Users/Mantas/Downloads/predictions_model_gbm.csv")

perf_valid2 <- h2o.performance(model_gbm2, valid = TRUE)
h2o.auc(perf_valid2)

h2o.performance(model_gbm2, newdata = test)

h2o.saveModel(model_gbm2, "C:/Users/Mantas/Downloads/", filename = "my_model_gbm2")


h2o.shutdown()
