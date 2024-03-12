library(ggplot2)
library(ggpubr)
library(ggthemes)
library(openxlsx)
library(data.table)
library(dplyr)

theme_set(theme_light())
ion_data <- read.xlsx("C:/Users/miri/Documents/GitHub/R-graphs/data_tables/IonStatus_depletion.xlsx")
# sodium <- filter(ion_data, ion == "sodium")
# potassium <- filter(ion_data, ion == "potassium")

Na <- ggplot(data = ion_data, 
             aes(factor(group, level = c("control", "CDNB")), value)) +
  
  geom_boxplot(
    
    show.legend = FALSE, 
    aes(fill = group),
    width = 0.3
    
  ) +
  
  scale_fill_manual(
    
    values=c("#bababa", "#bababa"), 
    name =""
    
  ) +
  
  facet_wrap(
    
    ~factor(ion, level = c("sodium", "potassium")),
    scales = "free_y"
    
  ) +
  
  geom_point(color = "#000000", size = 2) +
  
  geom_line(
    
    group = ion_data$paired
    
  ) +
  
  labs(
    # title = (""), 
    x="", 
    y="mmol / kg dry weight") +
  
 theme(strip.text =  element_text(size = 12)) +
  
  stat_compare_means(
    paired = T, 
    label = "p.format", #p.signif
    method = "wilcox.test", 
    vjust = 1.5, hjust = -0.5)


ggsave("ion2.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 6, height = 5)

