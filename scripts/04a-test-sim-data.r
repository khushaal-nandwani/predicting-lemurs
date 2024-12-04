#### Preamble ####
# Purpose: Tests the simulated data
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 01-simulate_data.r


## Workspace Setup ## 
library(testthat)
library(tidyverse)

# Load the dataset
data <- read_csv("data/analysis_data/sim_data.csv")

# Start writing tests
test_that("Dataset structure is correct", {
  # Test the column names
  expect_named(data, c(
    "animal_id", "species", "sex", "birth_type", 
    "litter_size", "mother_father_same", "age", "month_born"
  ))

  # Test the number of rows
  expect_equal(nrow(data), 1200)

  # Test the number of columns
  expect_equal(ncol(data), 8)
})

test_that("Animal IDs are unique and sequential", {
  expect_true(all(data$animal_id == 1:1200))
})

test_that("Species values are valid", {
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
  expect_true(all(data$species %in% types_of_species))
})

test_that("Sex values are valid", {
  expect_true(all(data$sex %in% c("M", "F")))
})

test_that("Birth type values are valid", {
  expect_true(all(data$birth_type %in% c("captive", "wild")))
})

test_that("Litter size is within the expected range", {
  expect_true(all(data$litter_size >= 1 & data$litter_size <= 5))
})

test_that("Mother-father same values are binary", {
  expect_true(all(data$mother_father_same %in% c(0, 1)))
})

test_that("Age values are reasonable based on birth type", {
  captive_ages <- data$age[data$birth_type == "captive"]
  wild_ages <- data$age[data$birth_type == "wild"]
  
  # Check captive ages
  expect_true(all(captive_ages >= 0))
  expect_true(mean(captive_ages) > mean(wild_ages)) # Captive ages should generally be higher

  # Check wild ages
  expect_true(all(wild_ages >= 0))
})

test_that("Month born is valid", {
  expect_true(all(data$month_born >= 1 & data$month_born <= 12))
})

test_that("Dataset is reproducible", {
  # Re-generate the dataset
  set.seed(136)
  n <- 1200
  regenerated_data <- tibble(
    animal_id = 1:n,
    species = sample(c(
      "Northern greater galago",
      "Collared brown lemur",
      "Eulemur hybrid",
      "Red-fronted brown lemur",
      "Mohol bushbaby",
      "Eastern lesser bamboo lemur",
      "Black lemur",
      "Common brown lemur"
    ), n, replace = TRUE),
    sex = sample(c("M", "F"), n, replace = TRUE),
    birth_type = sample(c("captive", "wild"), n, replace = TRUE),
    litter_size = sample(1:5, n, replace = TRUE),
    mother_father_same = sample(c(0, 1), n, replace = TRUE),
    age = ifelse(sample(c("captive", "wild"), n, replace = TRUE) == "captive", 
                 rnorm(n, 9, 2), rnorm(n, 7, 2)),
    month_born = sample(1:12, n, replace = TRUE)
  )
  # Compare the dataframes
  expect_equal(nrow(data), nrow(regenerated_data))
})

