library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)

theme_set(theme_light())

PS <- read.xlsx("Flow cytometry_Flippase.xlsx")
PS2 <- PS[1:10,]
# PS_control <- filter(PS, treatment == "control")
# PS_CDNB <- filter(PS, treatment == "CDNB")

ggplot(PS2, aes(time, meanx)) + 
  
  geom_errorbar(
    
    aes(
      ymin = meanx - SD, 
      ymax = meanx + SD,
      width = 0.2,
      col = factor(treatment, levels = c("control", "CDNB"))
    ),
    
    alpha = 0.2
    
  ) +
  
  geom_line(
    
    aes(col = factor(treatment, levels = c("control", "CDNB")), 
        linetype = factor(treatment, levels = c("control", "CDNB"))
        )
    
  ) +
  
  scale_linetype_manual(
    
    values = c("solid", "dashed"),
    labels = c("blank", "CDNB [2mM]")
    
  ) +
  
  geom_point(
    
    aes(col = factor(treatment, levels = c("control", "CDNB")))
    
  ) +
  
  scale_color_manual(
    
    values = c("#bababa", "#bf0202"),
    labels = c("blank", "CDNB [2mM]")
    
  ) +
  
  labs(
    x = "NBD-PS incubation time [min]", 
    y = "NBD-PS internalized [%]",
    title = "Flippase activity",
    linetype = "Treatment",
    col = "Treatment"
    
  ) +
  
  theme(plot.title = element_text(hjust=0.5))
  

ggsave("flippase2.tiff", path = "~/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 6, height = 4)