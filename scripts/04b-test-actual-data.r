#### Preamble ####
# Purpose: Tests the analysis data
# Author: Khushaal Nandwani
# Date: 27 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 03-clean_data.r

## Workspace setup ##
library(testthat)
library(tidyverse)
library(arrow)

# Load data
wild_data <- read_parquet("data/analysis_data/wild.parquet")
captive_data <- read_parquet("data/analysis_data/captive.parquet")

# Define valid values for checks
valid_genus <- c("O", "E", "H", "G", "V", "L", "P", "C", "M", "N", "D")
valid_species <- c("GG", "COL", "MOH", "MON", "VV", "UL", "RUB", "CAT", "RUF", "MAC", "FUL", "AR", "COQ", "MED", "MUR", "COU", "TAR", "PYG", "ZAZ", "ALB", "COR", "SAN", "FLA", "MAD", "POT")
valid_months <- month.abb

# Tests
test_that("wild data has no missing values", {
  expect_false(any(is.na(wild_data)), info = "Missing values in wild data")
})

test_that("captive data has no missing values", {
  expect_false(any(is.na(captive_data)), info = "Missing values in captive data")
})

test_that("wild data has correct number of columns", {
  expect_equal(ncol(wild_data), 7, info = "Incorrect number of columns in wild data")
})

test_that("captive data has correct number of columns", {
  expect_equal(ncol(captive_data), 7, info = "Incorrect number of columns in captive data")
})

test_that("wild data age is between 0 and 50", {
  expect_true(all(wild_data$age >= 0 & wild_data$age <= 50), info = "Age values out of range in wild data")
})

test_that("wild data sex is valid", {
  expect_true(all(wild_data$sex %in% c("M", "F")), info = "Invalid sex in wild data")
})

test_that("captive data sex is valid", {
  expect_true(all(captive_data$sex %in% c("M", "F")), info = "Invalid sex in captive data")
})

test_that("wild data birth_type is valid", {
  expect_true(all(wild_data$birth_type %in% c("captive", "wild")), info = "Invalid birth type in wild data")
})

test_that("captive data birth_type is valid", {
  expect_true(all(captive_data$birth_type %in% c("captive", "wild")), info = "Invalid birth type in captive data")
})

test_that("wild data genus is valid", {
  expect_true(all(wild_data$genus %in% valid_genus), info = "Invalid genus in wild data")
})

test_that("captive data genus is valid", {
  expect_true(all(captive_data$genus %in% valid_genus), info = "Invalid genus in captive data")
})

test_that("wild data species is valid", {
  expect_true(all(wild_data$species %in% valid_species), info = "Invalid species in wild data")
})

test_that("captive data species is valid", {
  expect_true(all(captive_data$species %in% valid_species), info = "Invalid species in captive data")
})

test_that("wild data month_born is valid", {
  expect_true(all(wild_data$month_born %in% valid_months), info = "Invalid month born in wild data")
})

test_that("captive data month_born is valid", {
  expect_true(all(captive_data$month_born %in% valid_months), info = "Invalid month born in captive data")
})
