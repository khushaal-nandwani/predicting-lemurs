# Load required libraries
library(ggplot2)
library(dplyr)

# Read data
wild_data <- read.csv("data/analysis_data/wild.csv")
captive_data <- read.csv("data/analysis_data/captive.csv")

# Load required libraries
library(ggplot2)
library(dplyr)
library(forcats)

# Add a source column to differentiate between wild and captive data
wild_data <- wild_data %>%
  mutate(source = "Wild")
captive_data <- captive_data %>%
  mutate(source = "Captive")

# convert animal_id to integer
wild_data$animal_id <- as.integer(wild_data$animal_id)

# Combine datasets
combined_data <- bind_rows(wild_data, captive_data)

# Reusable plot function
create_plot <- function(data, aes_var, fill_var, title, x_label) {
  ggplot(data, aes(x = !!sym(aes_var), fill = !!sym(fill_var))) +
    geom_bar(position = "dodge") +
    labs(title = title, x = x_label, y = "Count", fill = "Source") +
    theme_minimal() +
    theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust = 1))
}

# Modify data for ordering by frequency
combined_data <- combined_data %>%
  mutate(
    species = fct_infreq(species),
    genus = fct_infreq(genus),
    month_born = fct_infreq(as.factor(month_born))
  )

# Generate combined plots
sex_plot <- create_plot(combined_data, "sex", "source", "Sex Distribution", "Sex")
species_plot <- create_plot(combined_data, "species", "source", "Species Distribution", "Species")
genus_plot <- create_plot(combined_data, "genus", "source", "Genus Distribution", "Genus")
month_plot <- create_plot(combined_data, "month_born", "source", "Birth Month Distribution", "Birth Month")

# Display plots
sex_plot
species_plot
genus_plot
month_plot
