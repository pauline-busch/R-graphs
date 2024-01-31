library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)


all_Data <- data.table(
  read.xlsx("Microscopy_depletion.xlsx"))

type = factor(all_Data$CellType, level = c("Discocyte", "Stomatocyte", "kA"))

ggplot(data = all_Data,
       aes(x = factor(
         sample, 
         level = c("control", "CDNB15","CDNB60")), 
           y = CellPercent)) +
  
  geom_boxplot(show.legend = FALSE, aes(fill = type)) +
  scale_fill_manual(values=c("#f56e6e", "#bf0202", "#d1d1d1"), name ="") +
  
  facet_wrap(~factor(CellType, 
                     level = c("Discocyte", "Stomatocyte", "kA"),
                     labels = c("Discocytes [%]", "Stomatocytes [%]", "Undefined [%]"))) +
  
  geom_point(color = "#000000", size = 2) +
  
  labs(
    # title = (""), 
    x="", 
    y="") +
  
  theme(
    plot.title = element_blank()
  ) +
  
  theme_light() +
  
  stat_compare_means(comparisons = list(c("control","CDNB15"),
                                        c("control","CDNB60"),
                                        c("CDNB15","CDNB60")),
                     label = "p.signif", method = "wilcox.test")


ggsave("result_depletion.tiff", path = "C:/Users/Rickman/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 6)

