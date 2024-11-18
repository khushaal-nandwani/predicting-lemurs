#### Preamble ####
# Purpose: Cleans the data and keeps only the relevant columns
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: The raw data file should be present in the data/raw_data folder

# Most of the data from raw data was already cleaned by Cook
# However, to conduct our analysis, we will only keep the columns we need

## Workspace Setup ##
library(tidyverse)

w <- read.csv("finalPaper/data/raw_data/weights.csv")

## Data Cleaning ##
# read the data
data <- read.csv("finalPaper/data/raw_data/animals.csv")

# selecting relevant columns
data <- data[, c("animal_id", "species", "sex", "birth_date", "death_date", "birth_type", "litter_size", "mother_species", "father_species")]

# create a column, which says if mother and father species is same
data$mother_father_same <- ifelse(data$mother_species == data$father_species, 1, 0)

# remove the mother_species and father_species columns, as they are no longer needed
data <- data[, -c(8, 9)]

# create a column for age
data$birth_date <- as.Date(data$birth_date)
data$death_date <- as.Date(data$death_date)
data$age <- as.numeric(difftime(data$death_date, data$birth_date, units = "days"))/365

# create a column for month born
data$month_born <- as.numeric(format(data$birth_date, "%m"))

# remove birth_date and death_date columns, as they are no longer needed
data <- data[, -c(4, 5)]

# remove rows with missing values except missing in litter_size and mother_father_same
data <- data %>% drop_na(animal_id, species, sex, birth_type, age, month_born)

# save the cleaned data
write.csv(data, "finalPaper/data/analysis_data/analysis_data.csv", row.names = FALSE)
