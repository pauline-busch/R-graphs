library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)


line_graph <- data.table(
  read.xlsx("GSH_depletion.xlsx", sheet = "table"))

SEM <- data.table(
  read.xlsx("GSH_depletion.xlsx", sheet = "SEM"))

ltit <- ""

ggplot(data = line_graph,
       aes(x = incubation, 
           y = mean)
       ) +
  
  geom_line(col = "grey", lty = "twodash", size = 0.8) +
  
  geom_point(size = 2) +
  
  scale_shape_discrete(name  ="") +
  
  geom_errorbar(aes(
    ymin = line_graph$mean-SEM$SEM, 
    ymax = line_graph$mean+SEM$SEM,
    width=0.035), color = "black") +
  
  labs(
    # title = (""), 
    x="CDNB [mM]", 
    y="GSH [μmol/g Hb]") +
  
  scale_x_continuous(breaks = c(0, 0.25, 0.5, 0.75, 1, 1.25, 1.5, 1.75, 2)) +
  
  theme(
    plot.title = element_blank()
  ) +
  
  theme_classic2()

ggsave("GSH depletion.tiff", path = "C:/Users/Rickman/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 5)