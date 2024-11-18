#### Preamble ####
# Purpose: Install the required packages for the analysis
# Author: Khushaal Nandwani
# Date: 18 November 2024
# Contact: khushaal.nandwani@mail.utoronto.ca
# License: MIT
# Pre-requisites: None

# List of packages to install
packages <- c(
  "tidyverse",
  "dplyr",
  "knitr",
  "ggplot2",
)

# Install packages if they are not already installed
for (package in packages) {
  if (!requireNamespace(package, quietly = TRUE)) {
    install.packages(package, dependencies = TRUE)
  }
}