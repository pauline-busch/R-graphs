library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)


all_Data <- data.table(
  read.xlsx("LoRRca_deformability.xlsx"))

use_Data <- subset(
  all_Data, shear == 0.53)

f.sample <- factor(
  use_Data$sample, level = c("blank", "CDNB15","CDNB60"))

ggplot(data = use_Data,
       aes(x = f.sample, y = EI)) +
  
  geom_boxplot(show.legend = FALSE, aes(fill = sample)) +
  scale_fill_manual(values=c("#f56e6e", "#bf0202", "#d1d1d1"), name ="") +
  
  geom_point(color = "#000000", size = 2) +
  
  labs(
    # title = (""), 
    x="", 
    y="") +
  
  theme(
    plot.title = element_blank()
  ) +
  
  theme_light() +
  
  stat_compare_means(comparisons = list(c("CDNB15","CDNB60"),
                                        c("blank","CDNB15"),
                                        c("blank","CDNB60")),
                     label = "p.signif", method = "wilcox.test")


ggsave("result_deformability.tiff", path = "C:/Users/miri/Desktop/R/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 6)
