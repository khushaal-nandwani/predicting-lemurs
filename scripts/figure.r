library(arrow)
# load model
wild_model <- readRDS("models/wild_model.rds")
wild_data <- read_parquet("data/analysis_data/wild.parquet")
captive_model <- readRDS("models/captive_model.rds")

# Residual plots for wild_model
plot(wild_model$fitted.values, residuals(wild_model), main="Residual Plot for Wild Model")
abline(h=0, col="red")

# QQ plot to check normality of residuals
qqnorm(residuals(wild_model))
qqline(residuals(wild_model), col="blue")

# Residual plots for captive_model
wild_model$aic

install.packages("car")
library(car)
vif(wild_model)

wild_predictions <- predict(wild_model, type="response")
plot(wild_data$age, wild_predictions, main="Predicted vs Observed (Wild Model)")
abline(0, 1, col="red")