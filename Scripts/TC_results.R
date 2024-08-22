library(ggplot2)
library(ggpubr)
library(ggsci)
library(openxlsx)
library(data.table)
library(ggstatsplot)
library(dplyr)
library(car)


Data <- data.table(
  read.xlsx("TC_results.xlsx")
)

Data_summary <- Data %>% 
  group_by(type, sample) %>% 
  summarise_all(c("mean", "sd"))

ggplot(
  data = Data_summary, 
  aes(
    x = type, 
    y = Max.RI_mean, 
    fill = type)
  ) +
  
  geom_boxplot(
    aes(alpha = 0.7)
  ) +
  
  scale_fill_cosmic(
    
  ) +
  
  geom_point(
    
  ) +
  
  geom_line(
    group = Data_summary$sample
  ) +
  
  labs(
    title = "Maximum refractive index",
    x = "",
    y = "Max RI"
  ) +
  
  theme_pubr(
    legend = "none"
  ) +
  
  theme(
    plot.title = element_text(hjust = 0.5, size = 20, face = "bold")
  )

ggsave(
  "MaxRI mean.tiff", 
  path = "C:/Users/miri/OneDrive - Universität Zürich UZH/Documents/Pauline Busch/Experimente/Microscopy/20240820 Tomocube/Analysis graph", 
  units = "in", 
  dpi=300, 
  compression = 'lzw', 
  width = 12, 
  height = 8
  )
