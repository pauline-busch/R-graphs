library(dplyr)
library(readxl)
library(openxlsx)
library(ggplot2)
library(ggthemes)
library(ggpubr)

# Read in the file that contains the baseline data
baseline_data <- read_xlsx("~/events-Jerone Van1.xlsx")

# Bin data (1 second intervals - median)
baseline_data <- baseline_data %>%
  mutate(TimeBin = floor(Time)) %>%
  group_by(TimeBin) %>%
  summarise(across(where(is.numeric), median, na.rm = TRUE))

# Save the binned data as excel file
write.xlsx(baseline_data, "~/GitHub/R-graphs/Flow cytometry analysis/binned-Jerone Van1.xlsx")

# Define the time interval for the baseline
start_time <- 200
end_time <- 300

baseline_region <- baseline_data %>%
  filter(TimeBin >= start_time & TimeBin <= end_time)

# Calculate the baseline equation
lin_reg <- lm(FL1 ~ TimeBin, data = baseline_region)
lin_eq <- paste(round(coef(lin_reg)[2], 2), "* x", "+", round(coef(lin_reg)[1], 2))
R_squared <- summary(lin_reg)$r.squared

# Plot your data
calcium_baseline <- ggplot(baseline_data, aes(TimeBin, FL1)) +
  geom_line() +
  geom_smooth(data = baseline_region, method = "lm", se = FALSE, color = "red", formula = y ~ x) +
  annotate("text", x = (start_time + end_time) / 2, y = max(baseline_region$FL1), label = lin_eq) +
  labs(title = "Calcium kinetics with regression line",
       x = "Time [seconds]",
       y = "FL1 [RFU]")

# Save your plot as an image
ggsave("FC_data.tiff", path = "~/GitHub/R-graphs/Flow cytometry analysis/graphs", units = "in", dpi=300, compression = 'lzw', width = 7, height = 5)

