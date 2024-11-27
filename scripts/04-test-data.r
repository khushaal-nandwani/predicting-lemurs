#### Preamble ####
# Purpose: Tests the analysis data
# Author: Khushaal Nandwani
# Date: 27 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 03-clean_data.r

## Workspace setup ##
library(tidyverse)
library(arrow)

## Tests ##
print("Testing analysis data for wild and captive lemurs")

wild_data <- read_parquet("data/analysis_data/wild.parquet")
captive_data <- read_parquet("data/analysis_data/captive.parquet")

all_tests_passed = TRUE

# Test 1: Check for any NA values or missing data
if (any(is.na(wild_data))) {
  print("Test 1 failed: Missing values in wild data")
  all_tests_passed = FALSE
}

if (any(is.na(captive_data))) {
  print("Test 1 failed: Missing values in captive data")
  all_tests_passed = FALSE
}

# Test 2: Check number of columns
if (ncol(wild_data) != 7) {
  print("Test 2 failed: Incorrect number of columns in wild data")
  all_tests_passed = FALSE
}

if (ncol(captive_data) != 7) {
  print("Test 2 failed: Incorrect number of columns in captive data")
  all_tests_passed = FALSE
}

# Test 3: Check age is between 0 and 50
if (any(wild_data$age < 0) | any(wild_data$age > 50)) {
  print("Test 3 failed: Age values out of range in wild data")
  all_tests_passed = FALSE
}

# Test 4: Check sex is either M or F
if (any(!(wild_data$sex %in% c("M", "F")))) {
  print("Test 4 failed: Invalid sex in wild data")
    all_tests_passed = FALSE
}

if (any(!(captive_data$sex %in% c("M", "F")))) {
  print("Test 4 failed: Invalid sex in captive data")
    all_tests_passed = FALSE
}

# Test 5: Check birth type is either captive or wild
if (any(!(wild_data$birth_type %in% c("captive", "wild")))) {
  print("Test 5 failed: Invalid birth type in wild data")
  all_tests_passed = FALSE
}

if (any(!(captive_data$birth_type %in% c("captive", "wild")))) {
  print("Test 5 failed: Invalid birth type in captive data")
  all_tests_passed = FALSE
}

# Test 6: Check genus is valid
valid_genus <- c("O", "E", "H", "G", "V", "L", "P", "C", "M", "N", "D")
if (any(!(wild_data$genus %in% valid_genus))) {
  print("Test 6 failed: Invalid genus in wild data")
  all_tests_passed = FALSE
}

if (any(!(captive_data$genus %in% valid_genus))) {
  print("Test 6 failed: Invalid genus in captive data")
  all_tests_passed = FALSE
}

# Test 7: Check species is valid
valid_species <- c("GG", "COL", "MOH", "MON", "VV", "UL", "RUB", "CAT", "RUF", "MAC", "FUL", "AR", "COQ", "MED", "MUR", "COU", "TAR", "PYG", "ZAZ", "ALB", "COR", "SAN", "FLA", "MAD", "POT")

if (any(!(wild_data$species %in% valid_species))) {
  print("Test 7 failed: Invalid species in wild data")
  all_tests_passed = FALSE
}

if (any(!(captive_data$species %in% valid_species))) {
  print("Test 7 failed: Invalid species in captive data")
  all_tests_passed = FALSE
}

# Test 8: Check month_born is valid
valid_months <- month.abb
if (any(!(wild_data$month_born %in% valid_months))) {
  print("Test 8 failed: Invalid month born in wild data")
  all_tests_passed = FALSE
}

if (any(!(captive_data$month_born %in% valid_months))) {
  print("Test 8 failed: Invalid month born in captive data")
  all_tests_passed = FALSE
}

if (all_tests_passed) {
  print("All tests passed successfully")
} else {
  print("Some tests failed")
}
