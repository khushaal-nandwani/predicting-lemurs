#### Preamble ####
# Purpose: Simulated the analysis dataset
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

## Workspace Setup ##
library(tidyverse)

## Simulation ##
# set seed for reproducibility
set.seed(136)

# number of rows in the dataset
n <- 1200

# generate animal ids
animal_id <- 1:n

# generate species
types_of_species <- c(
    "Northern greater galago",
    "Collared brown lemur",
    "Eulemur hybrid",
    "Red-fronted brown lemur",
    "Mohol bushbaby",
    "Eastern lesser bamboo lemur",
    "Black lemur",
    "Common brown lemur"
)
species <- sample(types_of_species, n, replace = TRUE)

# generate sex
sex <- sample(c("M", "F"), n, replace = TRUE)

# generate birth_type
birth_type <- sample(c("captive", "wild"), n, replace = TRUE)

# generate litter_size
litter_size <- sample(1:5, n, replace = TRUE)

# generate mother_father_same
mother_father_same <- sample(c(0, 1), n, replace = TRUE)

# generate age, making it dependent on birth_type
age <- ifelse(birth_type == "captive", rnorm(n, 9, 2), rnorm(n, 7, 2))

# generate month_born
month_born <- sample(1:12, n, replace = TRUE)

# create the dataset
data <- tibble(
    animal_id = animal_id,
    species = species,
    sex = sex,
    birth_type = birth_type,
    litter_size = litter_size,
    mother_father_same = mother_father_same,
    age = age,
    month_born = month_born
)

write.csv(data, "data/analysis_data/sim_data.csv", row.names = FALSE)

# print the first few rows of the dataset
head(data)
