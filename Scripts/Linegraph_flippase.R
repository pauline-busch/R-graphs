library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)

theme_set(theme_light())

PS <- read.xlsx("C:/Users/miri/Documents/GitHub/R-graphs/data_tables/Flow cytometry_Flippase.xlsx")
# PS_control <- filter(PS, treatment == "control")
# PS_CDNB <- filter(PS, treatment == "CDNB")

ggplot(PS, aes(time, FL1)) + 
  
  geom_errorbar(
    
    aes(
      ymin = FL1 - SD, 
      ymax = FL1 + SD,
      width = 0.2,
      alpha = 0.2,
      col = factor(treatment, levels = c("control", "CDNB"))
    )
    
  ) +
  
  geom_line(
    
    aes(col = factor(treatment, levels = c("control", "CDNB")), 
        linetype = factor(treatment, levels = c("control", "CDNB"))
        )
    
  ) +
  
  geom_point(
    
    aes(col = factor(treatment, levels = c("control", "CDNB")))
    
  ) +
  
  scale_color_manual(
    
    values = c("#bababa", "#bf0202")
    
  ) +
  
  labs(
    x = "time [min]", 
    y = "NBD-PS internalized [%]"
    
  ) +
  
  theme(legend.position = "NA")
  

ggsave("flippase.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 6, height = 4)