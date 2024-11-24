## Preamble ##
# Purpose: Data analysis for the project. Specifically, we will build a model to predict the age of animals based on various factors.
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

count_na <- function(data) {
    sapply(data, function(x) sum(is.na(x)))
}
## Workspace setup ##
library(tidyverse)

## Modeling ##
# Read the cleaned analysis dataset
# analysis_data <- read.csv("data/analysis_data/analysis_data.csv")

# colnames(analysis_data)

# model <- glm(age ~ species + sex + mother_father_same + month_born + litter_size, family = gaussian(), data = analysis_data)

# summary(model)

wild_data <- read.csv("data/analysis_data/wild.csv")

# give count of na valus in each column
# Extract function to count NA values in each column
# Count NA values in each column of wild_data
count_na(wild_data)
# drop na values in columns sex, species, age, month_born
# create a model for wild animals
wild_model <- glm(age ~ species + sex + month_born + genus, family = gaussian(), data = wild_data)
summary(wild_model)

captive_data <- read.csv("data/analysis_data/captive.csv")
# drop na values in columns sex, species, age, month_born

# create a model for captive animals
captive_model <- glm(age ~ species + genus + sex + month_born, family = gaussian(), data = captive_data)
summary(captive_model)
