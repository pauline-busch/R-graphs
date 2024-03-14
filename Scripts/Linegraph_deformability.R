library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)

theme_set(theme_light())

PS <- read.xlsx("C:/Users/miri/Documents/GitHub/R-graphs/data_tables/LoRRca_deformability_2.xlsx")
# PS_control <- filter(PS, treatment == "control")
# PS_CDNB <- filter(PS, treatment == "CDNB")

ggplot(PS, aes(shearstress, EI)) + 
  
  geom_errorbar(
    
    aes(
      ymin = EI - SEM, 
      ymax = EI + SEM,
      width = 0.2,
      alpha = 0.2,
      col = factor(sample, levels = c("blank", "CDNB60"))
    )
    
  ) +
  
  geom_line(
    
    aes(col = factor(sample, levels = c("blank", "CDNB60")), 
        linetype = factor(sample, levels = c("blank", "CDNB60"))
        )
    
  ) +
  
  geom_point(
    
    aes(col = factor(sample, levels = c("blank", "CDNB60"))),
    size = 0.75
    
  ) +
  
  scale_color_manual(
    
    values = c("#bababa", "#bf0202")
    
  ) +
  
  labs(
    x = "shear stress [Pa]", 
    y = "Elongation index"
    
  ) +
  
  theme(legend.position = "NA")
  

ggsave("try1.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 6, height = 4)