library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)

theme_set(theme_light())
all_Data <- data.table(
  read.xlsx("C:/Users/miri/Documents/GitHub/R-graphs/data_tables/Microscopy_repletion.xlsx"))

type = factor(all_Data$CellType, level = c("Discocyte", "Stomatocyte", "kA"))

ggplot(data = all_Data,
       aes(x = factor(
         sample, 
         level = c("control", "CDNB60", "DTT15", "etGSH30")), 
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
    plot.title = element_blank(),
    strip.text = element_text(size = 12)
  )
  
  #stat_compare_means(comparisons = list(c("control","CDNB60"),
                                        #c("control","DTT15"),
                                        #c("control","etGSH30"),
                                        #c("CDNB60","DTT15"),
                                        #c("CDNB60","etGSH30"),
                                        #c("DTT15","etGSH30")),
                     #label = "p.signif", method = "wilcox.test")


ggsave("result_repletion2.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 6)

