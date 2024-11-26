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

library(brms)
# Load data
wild_data <- read.csv("data/analysis_data/wild.csv")
captive_data <- read.csv("data/analysis_data/captive.csv")

# Build models
wild_model <- brm(
    formula = age ~ species + sex + month_born + genus,
    family = gaussian(),
    data = wild_data,
    prior = c(
        set_prior("normal(0, 2.5)", class = "b"),
        set_prior("normal(16, 4)", class = "Intercept")
    ),
    control = list(adapt_delta = 0.95)
)

# captive_model <- 
#     glm(
#         age ~ species + genus + sex + month_born, 
#         family = gaussian(), 
#         data = captive_data,
#         prior = c(
#             set_prior("normal(0, 2.5)", class = "b"),
#             set_prior("normal(26, 4)", class = "Intercept")
#         ),
#         control = list(adapt_delta = 0.95)
#     )
captive_model <- brm(
    formula = age ~ species + sex + month_born + genus,
    family = gaussian(),
    data = captive_data,
    prior = c(
        set_prior("normal(0, 2.5)", class = "b"),
        set_prior("normal(26, 4)", class = "Intercept")
    ),
    control = list(adapt_delta = 0.95)
)

# save models
saveRDS(wild_model, "models/wild_model.rds")
saveRDS(captive_model, "models/captive_model.rds")
