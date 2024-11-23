#### Preamble ####
# Purpose: Cleans the data and keeps only the relevant columns
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: The raw data file should be present in the data/raw_data folde

## Workspace Setup ##
library(tidyverse)

## Load the data ##
# REMOVE: w <- read.csv("data/raw_data/weights.csv")

## Data Cleaning ##
data <- read.csv("data/raw_data/animals.csv")

# get unique values of taxonomic code and number of unique values
unique(data$taxonomic_code)
# species
unique(data$species)

# selecting relevant columns
data <- data[ , c("animal_id", "taxonomic_code", "sex", "birth_date", "death_date", "birth_type", "litter_size", "mother_species", "father_species")]

# make first letter of taxnomic code as Genus
# the rest of the letters as species

data$species <- substr(data$taxonomic_code, 1, 1)
data$genus <- substr(data$taxonomic_code, 2, nchar(data$taxonomic_code))



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
# splilt the data into birth_type == captive or wild
data_captive <- data[data$birth_type == "captive", ]

data_wild <- data[data$birth_type == "wild", ]
# since there is no data on the mothr father and litter size of iwld data, we remove these cols
data_wild <- data_wild[, -c(5, 6)]
head(data_wild)
# remove rows with missing values except missing in litter_size and mother_father_same
# data <- data %>% drop_na(animal_id, species, sex, birth_type, age, month_born)

# drop na
# data <- data %>% drop_na()

# save the cleaned data
write.csv(data_wild, "data/analysis_data/wild.csv", row.names = FALSE)
write.csv(data_captive, "data/analysis_data/captive.csv", row.names = FALSE)
# write.csv(data, "data/analysis_data/analysis_data.csv", row.names = FALSE)

# print number of unique values for each column
print(sapply(data, function(x) length(unique(x))))

