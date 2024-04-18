library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)

theme_set(theme_light())

PS <- read.xlsx("LoRRca_deformability_2.xlsx")
# PS_control <- filter(PS, treatment == "control")
# PS_CDNB <- filter(PS, treatment == "CDNB")

ggplot(PS, aes(shearstress, EI)) + 
  
  geom_point(
    
    aes(col = factor(sample, levels = c("blank", "CDNB60"))),
    size = 0.75
    
  ) +
  
  scale_color_manual(
    
    values = c("#bababa", "#bf0202"),
    labels = c("blank", "CDNB [2mM]")
    
  ) +
  
  geom_line(
    
    aes(col = factor(sample, levels = c("blank", "CDNB60")), 
        linetype = factor(sample, levels = c("blank", "CDNB60"))
        )
    
  ) +
  
  scale_linetype_manual(
    
    values = c("solid", "dashed"),
    labels = c("blank", "CDNB [2mM]")
    
  ) +
  
  
  labs(
    x = "shear stress [Pa]", 
    y = "Elongation index",
    title = "RBC deformability",
    linetype = "Treatment",
    col = "Treatment"
    
  ) +
  
  theme(plot.title = element_text(hjust=0.5))
  

ggsave("try2.tiff", path = "~/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 6, height = 4)