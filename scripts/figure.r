library(ggplot2)
library(dplyr)
WILD_COLOR <- "#FFA500"
CAPTIVE_COLOR <- "#4169E1"

# Load the data
predictions <- read_csv("data/predictions/predictions.csv")
# Summarize the data by month
month_plot_data <- predictions %>%
  group_by(month_born) %>%
  summarise(
    avg_age_wild = mean(predicted_age_wild, na.rm = TRUE),
    avg_age_captive = mean(predicted_age_captive, na.rm = TRUE)
  ) %>%
  pivot_longer(
    cols = c(avg_age_wild, avg_age_captive),
    names_to = "prediction_type",
    values_to = "avg_age"
  )

# Create the bar plot
month_plot <- ggplot(month_plot_data, aes(x = month_born, y = avg_age, fill = prediction_type)) +
  geom_bar(stat = "identity", position = "dodge") +
  scale_fill_manual(
    values = c("avg_age_wild" = WILD_COLOR, "avg_age_captive" = CAPTIVE_COLOR),
    labels = c("Wild Lemurs", "Captive Lemurs")
  ) +
  labs(
    x = "Month Born",
    y = "Average Predicted Age",
    fill = "Type of Lemurs",
    title = "Average Predicted Ages by Month Born"
  ) +
  theme_minimal() +
  theme(axis.text.x = element_text(angle = 45, hjust = 1))

month_plot

# save the plot
ggsave("figures/month_plot.png", month_plot, width = 10, height = 6, units = "in", dpi = 300)