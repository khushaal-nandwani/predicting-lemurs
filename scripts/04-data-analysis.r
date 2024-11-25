## Preamble ##
# Purpose: Data analysis for the project. Specifically, we will build a model 
#          to predict the age of animals based on various factors.
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

## Workspace setup ##
library(tidyverse)
library(arrow)

# Load data
wild_data <- read.csv("data/analysis_data/wild.csv")
captive_data <- read.csv("data/analysis_data/captive.csv")

# Build models
wild_model <- 
    glm(
        age ~ species + sex + month_born + genus, 
        family = gaussian(), 
        data = wild_data,
        adapt_delta = 0.95,
        prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
        prior_intercept = normal(location = 16, scale = 4, autoscale = TRUE)
    )
captive_model <- 
    glm(
        age ~ species + genus + sex + month_born, 
        family = gaussian(), 
        data = captive_data,
        adapt_delta = 0.95,
        prior = normal(location = 0, scale = 2.5, autoscale = TRUE),
        prior_intercept = normal(location = 26, scale = 4, autoscale = TRUE)
    )

# save models
saveRDS(wild_model, "models/wild_model.rds")
saveRDS(captive_model, "models/captive_model.rds")

