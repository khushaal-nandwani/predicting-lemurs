#### Preamble ####
# Purpose: Creates prediction dataset to use in the Results section of the paper
# Author: Kaavya Kalani
# Date: 18 April 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 04-data-analysis.r

## Workspace setup ##
library(tidyverse)
library(arrow)

# Prediction datasets
analysis_data <- read_csv("data/analysis_data/wild.csv")

# Load models
wild_model <- readRDS("models/wild_model.rds")
captive_model <- readRDS("models/captive_model.rds")

# creating prediction dataset
species_ <- unique(analysis_data$species)
sex_ <- unique(analysis_data$sex)
month_born_ <- unique(analysis_data$month_born)
genus_ <- unique(analysis_data$genus)

prediction_data <- expand.grid(
    species = species_,
    sex = sex_,
    month_born = month_born_,
    genus = genus_
)

# predict age based on these variables
predictions_wild <- predict(wild_model, newdata = prediction_data, type = "response")
predictions_captive <- predict(captive_model, newdata = prediction_data, type = "response")


predictions_df <- data.frame(
    species = prediction_data$species,
    sex = prediction_data$sex,
    month_born = prediction_data$month_born,
    genus = prediction_data$genus,
    predicted_age_wild = predictions_wild,
    predicted_age_captive = predictions_captive
)

# save the predictions
write_csv(predictions_df, "data/predictions/predictions.csv")

