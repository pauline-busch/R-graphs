library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)


all_Data <- data.table(
  read.xlsx("LoRRca_deformability.xlsx"))

#use_Data <- subset(
 # all_Data, shear == 0.53)

f.sample <- factor(
  all_Data$sample, level = c("blank", "CDNB15","CDNB60"))

ggplot(data = all_Data,
       aes(x = f.sample, 
           y = EI)) +
  
  geom_boxplot(show.legend = FALSE, aes(fill = sample)) +
  scale_fill_manual(values=c("#f56e6e", "#bf0202", "#d1d1d1"), name ="") +
  
  facet_wrap(~factor(shear,
             level = c(0.3, 0.53, 0.95, 1.69, 3.00, 5.33, 9.49, 16.87, 30),
             labels = c("0.3 Pa", 
                        "0.53 Pa", 
                        "0.95 Pa", 
                        "1.69 Pa", 
                        "3.00 Pa", 
                        "5.33 Pa", 
                        "9.49 Pa", 
                        "16.87 Pa", 
                        "30 Pa")), scales = "free_y") +
  
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


ggsave("result_deformabilityy.tiff", path = "C:/Users/miri/Desktop/R/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 12)
