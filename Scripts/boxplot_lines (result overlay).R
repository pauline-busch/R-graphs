library(ggplot2)
library(ggpubr)
library(ggthemes)
library(openxlsx)
library(data.table)
library(dplyr)


effect <- read.xlsx(
    "C:/Users/miri/Documents/GitHub/R-graphs/data_tables/Flow cytometry_depletion.xlsx", 
    sheet = 2)

test <- effect[1:6, 9:17]
  
#x1 <- effect[redox == "normal"]$SS.st..Dev
#x2 <- effect[redox == "stress"]$FS.height.st.dev

ggplot(data = effect, aes(factor(CDNB, levels = c("control", "CDNB")), SS)) +
  
    geom_boxplot(
      
      aes(fill = factor(CDNB)),
      alpha = 0.2,
      
    ) +
  
    scale_fill_manual(
    
      values = c("#bababa", "#bababa")
    
    ) +

    geom_point(
      
      alpha = 0.2
      
    ) +
  
    geom_line(
      
      group = effect$paired,
      alpha = 0.2
      
    ) +
  
    geom_point(
        
      data = test, 
      aes(factor(CDNB_2), SS_2, col = treatment),
      shape = "diamond",
      size = 2
        
    ) +
  
    geom_line(
    
      data = test, 
      aes(factor(CDNB_2), SS_2, col = factor(treatment, levels = c("amiloride", "bumetanide","both")), group = paired_2),
      size = 0.8
    
    ) +
  
    scale_color_manual(
      
      values = c("#ff9191", "#f56e6e", "#bf0202"), 
      name = ""
      
    ) +

    labs(
      
      title = (""), 
      x="", 
      y="side scatter"
      
    ) +
  
    theme_light() +
  
    theme(
      
      plot.title = element_text(hjust = 0.5, size = 12), 
      axis.title.y = element_text(vjust=1),
      legend.position = ""
      
    ) 
 

ggsave("SS_legend.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", width = 3, height = 5, dpi=300, compression = 'lzw')