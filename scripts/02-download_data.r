#### Preamble ####
# Purpose: Downloads the data file from the internet
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

url <- "https://raw.githubusercontent.com/tacookson/data/master/duke-lemur-center/animals.txt"

destination_dir <- "data/raw_data"
destination_file <- file.path(destination_dir, "animals.txt")

# Create the destination directory if it doesn't exist
if (!dir.exists(destination_dir)) {
  dir.create(destination_dir, recursive = TRUE)
}

# Download the file
download.file(url, destination_file, mode = "wb")

# Confirm success
if (file.exists(destination_file)) {
  cat("File downloaded and saved to", destination_file, "\n")
} else {
  cat("Failed to download the file.\n")
}

