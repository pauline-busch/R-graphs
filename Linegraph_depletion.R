library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(dplyr)


line_graph <- data.table(
  read.xlsx("GSH.xlsx", sheet = "table"))

SEM <- data.table(
  read.xlsx("GSH.xlsx", sheet = "SEM"))

ltit <- ""

ggplot(data = line_graph,
       aes(x = factor(incubation, 
                      level = c("Blank", "DMSO", "0.1", "0.25", "1", "2")), 
           y = mean, 
           group = group)
       ) +
  
  
  geom_line(aes(color = factor(group, level = c("healthy", "G6PD"))), size = 0.8) +
  
  scale_color_manual(values=c("#ba5792", "#b09da8"), name ="") +
  
  geom_point(color = "black", size = 2.5, aes(shape = factor(group, level = c("healthy", "G6PD")))) +
  
  scale_shape_discrete(name  ="") +
  
  geom_errorbar(aes(
    ymin = line_graph$mean-SEM$SEM, 
    ymax = line_graph$mean+SEM$SEM,
    width=0.1), color = "black") +
  
  labs(
    # title = (""), 
    x="CDNB [mM]", 
    y="GSH [μmol/g Hb]") +
  
  theme(
    plot.title = element_blank()
  ) +
  
  theme_pubclean()


ggsave("results-Utrecht.tiff", path = "C:/Users/miri/OneDrive/Desktop/R", units = "in", dpi=300, compression = 'lzw', width = 6, height = 4)