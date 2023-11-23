library(ggplot2)
library(ggpubr)
library(ggthemes)
library(openxlsx)
library(data.table)
library(dplyr)


effect <- data.table(
  read.xlsx(
    "Flow cytometry_depletion.xlsx", 
    sheet = 2))
  
#x1 <- effect[redox == "normal"]$SS.st..Dev
#x2 <- effect[redox == "stress"]$FS.height.st.dev

#p.value <- t.test(x1, x2, alternative = "two.sided", paired = TRUE, exact = TRUE, correct = TRUE)

ggplot(data = effect, 
        aes(as.factor(CDNB), SS)) +
  
    geom_boxplot(
        aes(fill = as.factor(CDNB))) +
  
    geom_point() +
  
    geom_line(group = effect$paired) +
  
    scale_fill_manual(values = c("#bababa", "#bababa")) +
  
    #stat_summary(
        #fun=mean, 
        #geom="point", 
        #shape=17, 
        #size=2, 
        #color="red") +
  
    labs(
        title = (""), 
        x="CDNB [mM]", 
        y="side scatter") +
    
    theme_pubr() +
  
    theme(
        plot.title = element_text(hjust = 0.5, size = 12), 
        axis.title.y = element_text(vjust=1),
        legend.position = "none") +
  
  stat_compare_means(
        paired = T, 
        label = "p.format", #p.signif
        method = "t.test", 
        vjust = -0.5)
 

ggsave("SS.tiff", path = "C:/Users/Rickman/Documents/GitHub/R-graphs/Graphs and figures", units = "in", width = 3, height = 5, dpi=300, compression = 'lzw')