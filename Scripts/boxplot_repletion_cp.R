library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)


all_Data <- data.table(
  read.xlsx("data_tables/Microscopy_repletion.xlsx"))

type = factor(all_Data$CellType, level = c("Discocyte", "Stomatocyte", "kA"))
samples = factor(all_Data$sample)

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
  
  geom_point(aes(colour = samples),  size = 2, show.legend = F) +
  scale_color_manual(values = c("#ff9a03", "#ffee03", "#03ffea", "#6c03ff")) +
  
  geom_point(shape = 21,  size = 2.1) +
  
  labs(
    # title = (""), 
    x="", 
    y="") +
  
  theme(
    plot.title = element_blank()
  ) +
  
  theme_light() +
  
  stat_compare_means(comparisons = list(c("control","CDNB60"),
                                        c("control","DTT15"),
                                        c("control","etGSH30"),
                                        c("CDNB60","DTT15"),
                                        c("CDNB60","etGSH30"),
                                        c("DTT15","etGSH30")),
                     label = "p.signif", method = "wilcox.test")


ggsave("result_repletion.tiff", path = "C:/Users/Rickman/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 6)

