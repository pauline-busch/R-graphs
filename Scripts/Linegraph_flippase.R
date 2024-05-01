library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)

theme_set(theme_light())

PS <- read.xlsx("Flow cytometry_Flippase.xlsx", sheet = "new")
# PS_control <- filter(PS, treatment == "control")
# PS_CDNB <- filter(PS, treatment == "CDNB")

ggplot(PS, aes(time, FL1)) + 
  
  geom_errorbar(
    
    aes(
      ymin = FL1 - SD, 
      ymax = FL1 + SD,
      width = 0.2,
      col = factor(treatment, levels = c("control", "CDNB", "NEM", "CDNB + NEM", "NEM + CDNB"))
    ),
    
    alpha = 0.2
    
  ) +
  
  geom_line(
    
    aes(col = factor(treatment, levels = c("control", "CDNB", "NEM", "CDNB + NEM", "NEM + CDNB")), 
        linetype = factor(treatment, levels = c("control", "CDNB", "NEM", "CDNB + NEM", "NEM + CDNB"))
        )
    
  ) +
  
  scale_linetype_manual(
    
    values = c(1,2,1,2,2),
    labels = c("blank", "CDNB [2mM]", "NEM [5 mM]", "CDNB + NEM", "NEM + CDNB")
    
  ) +
  
  geom_point(
    
    aes(col = factor(treatment, levels = c("control", "CDNB", "NEM", "CDNB + NEM", "NEM + CDNB")))
    
  ) +
  
  scale_color_manual(
    
    values = c("#bababa", "#bf0202",1,"#d4cccb","#d4cccb"),
    labels = c("blank", "CDNB [2mM]", "NEM [5 mM]", "CDNB + NEM", "NEM + CDNB")
    
  ) +
  
  labs(
    x = "NBD-PS incubation time [min]", 
    y = "NBD-PS internalized [%]",
    title = "Flippase activity",
    linetype = "Treatment",
    col = "Treatment"
    
  ) +
  
  theme(plot.title = element_text(hjust=0.5))
  

ggsave("flippaseTEST.tiff", path = "C:/Users/miri/Desktop/R/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 6, height = 4)