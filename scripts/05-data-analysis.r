## Preamble ##
# Purpose: Data analysis for the project. Specifically, we will build a model 
#          to predict the age of animals based on various factors.
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

## Workspace setup ##
library(arrow)

# Load data
wild_data <- read_parquet("data/analysis_data/wild.parquet")
captive_data <- read_parquet("data/analysis_data/captive.parquet")


wild_model <- glm(
    formula = age ~ species + sex + month_born + genus,
    family = gaussian(),
    data = wild_data,
)

my_model <- glm(
    formula = age ~ species + sex + birth_type + month_born + genus,
    family = gaussian(),
    data = data,
)

captive_model <- glm(
    formula = age ~ species + sex + month_born + genus,
    family = gaussian(),
    data = captive_data,
)

# save models
saveRDS(wild_model, "models/wild_model.rds")
saveRDS(captive_model, "models/captive_model.rds")


