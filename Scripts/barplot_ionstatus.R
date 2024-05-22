library(ggplot2)
library(ggpubr)
library(ggthemes)
library(openxlsx)
library(data.table)
library(dplyr)

library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)

theme_set(theme_light())

ions <- read.xlsx("C:/Users/miri/Documents/GitHub/R-graphs/data_tables/ion_status.xlsx")

ggplot(ions, aes(y = level)) +
  
  geom_bar(aes(x = treatment),
           stat = "identity", position = position_dodge2(), show.legend = FALSE) 
 
  

ggsave("cryo.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 4, height = 3)
