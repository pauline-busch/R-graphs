library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)

theme_set(theme_light())

PS <- read.xlsx("Patient.xlsx")
# PS_control <- filter(PS, treatment == "control")
# PS_CDNB <- filter(PS, treatment == "CDNB")

ggplot(PS, aes(image, EC)) + 
  
  geom_line(
    
    aes(col = factor(sample, levels = c("healthy control", "patient")), 
        linetype = factor(sample, levels = c("healthy control", "patient"))
        )
    
  ) +
  
  geom_point(
    
    aes(col = factor(sample, levels = c("healthy control", "patient"))),
    size = 0.75
    
  ) +
  
  scale_color_manual(
    
    values = c("#bababa", "#bf0202")
    
  ) +
  
  scale_x_continuous(breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13)) +
  
  labs(
    x = "image number", 
    y = "echinocytes [%]"
    
  ) +
  
  theme(legend.title = element_blank())
  

ggsave("pat.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 6, height = 4)