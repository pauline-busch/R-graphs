library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)


all_Data <- data.table(
  read.xlsx("result_repletion.xlsx"))

type = factor(all_Data$CellType, level = c("Discocyte", "Stomatocyte", "kA"))

ggplot(data = all_Data,
       aes(x = factor(
         sample, 
         level = c("control", "CDNB", "DTT", "etGSH")), 
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
  
  stat_compare_means(comparisons = list(c("control","CDNB"),
                                        c("control","DTT"),
                                        c("control","etGSH")),
                                        # c("CDNB","DTT"),
                                        # c("CDNB","etGSH"),
                                        # c("DTT","etGSH")),
                     label = "p.signif", method = "wilcox.test")


ggsave("result_repletion.tiff", path = "C:/Users/miri/OneDrive/Desktop/R/", units = "in", dpi=300, compression = 'lzw', width = 8, height = 6)

