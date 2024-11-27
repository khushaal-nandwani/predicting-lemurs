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
data <- read.csv("data/raw_data/animals.csv")

# selecting relevant columns
data <- data[ , c("animal_id", "taxonomic_code", "sex", "birth_date", "death_date", "birth_type", "litter_size", "mother_species", "father_species")]

# remove rows where death date is not mentioned
data <- data[!is.na(data$death_date), ]

# make first letter of taxnomic code as Genus
# the rest of the letters as species
data$genus <- substr(data$taxonomic_code, 1, 1)
data$species <- substr(data$taxonomic_code, 2, nchar(data$taxonomic_code))

# remove the taxonomic_code column, as it is no longer needed
data <- data[, -2]

# create a column, which says if mother and father species is same
data$mother_father_same <- ifelse(data$mother_species == data$father_species, 1, 0)

# remove the mother_species and father_species columns, as they are no longer needed
data <- data[, -c(7, 8)]

# create a column for age
data$birth_date <- as.Date(data$birth_date)
data$death_date <- as.Date(data$death_date)
data$age <- as.numeric(difftime(data$death_date, data$birth_date, units = "days"))/365

# remove lemurs with age less than 2
data <- data[data$age >= 1, ]


# create a column for month born
data$month_born <- as.numeric(format(data$birth_date, "%m"))
# convert month_born to name of the months
data$month_born <- month.abb[data$month_born]


# remove birth_date and death_date columns, as they are no longer needed
data <- data[, -c(3, 4)]

# splilt the data into birth_type == captive or wild
data_captive <- data[data$birth_type == "captive", ]
data_wild <- data[data$birth_type == "wild", ]

# since there is no data on the mothr father and litter size of iwld data, we remove these cols
data_wild <- data_wild[, -c(3, 7)]

# drop relevant NA values
data_wild <- data_wild %>% drop_na(sex, species, age, month_born, genus)
# remove litter size
data_wild <- data_wild[, -3]
write.csv(data_wild, "data/analysis_data/wild.csv", row.names = FALSE)
data_captive <- data_captive %>% drop_na(sex, species, age, month_born, genus)
write.csv(data_captive, "data/analysis_data/captive.csv", row.names = FALSE)

