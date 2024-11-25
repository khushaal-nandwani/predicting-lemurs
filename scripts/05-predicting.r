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
wild_analysis_data <- read_csv("data/analysis_data/wild.csv")
captive_analysis_data <- read_csv("data/analysis_data/captive.csv")

# Load models
wild_model <- readRDS("models/wild_model.rds")
captive_model <- readRDS("models/captive_model.rds")

# creating prediction dataset
wild_ages_ <- unique(wild_analysis_data$age)
wild_species_ <- unique(wild_analysis_data$species)
wild_sex_ <- unique(wild_analysis_data$sex)
wild_month_born_ <- unique(wild_analysis_data$month_born)
wild_genus_ <- unique(wild_analysis_data$genus)

captive_ages_ <- unique(captive_analysis_data$age)
captive_species_ <- unique(captive_analysis_data$species)
captive_sex_ <- unique(captive_analysis_data$sex)
captive_month_born_ <- unique(captive_analysis_data$month_born)
captive_genus_ <- unique(captive_analysis_data$genus)

wild_prediction_data <- expand.grid(
    age = wild_ages_,
    species = wild_species_,
    sex = wild_sex_,
    month_born = wild_month_born_,
    genus = wild_genus_
)

captive_prediction_data <- expand.grid(
    age = captive_ages_,
    species = captive_species_,
    sex = captive_sex_,
    month_born = captive_month_born_,
    genus = captive_genus_
)

# predict age based on these variables
predictions_wild <- predict(wild_model, newdata = wild_prediction_data, type = "response")
predictions_captive <- predict(captive_model, newdata = captive_prediction_data, type = "response")


# Save the predictions
write.csv(predictions_wild, "data/predictions/wild_predictions.csv", row.names = FALSE)
write.csv(predictions_captive, "data/predictions/captive_predictions.csv", row.names = FALSE)
