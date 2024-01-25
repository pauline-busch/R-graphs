library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)


all_Data <- data.table(
  read.xlsx("LoRRca_deformability.xlsx"))

 use_Data1 <- subset(
   all_Data, shear < 1)

# use_Data2 <- subset(
#   all_Data, shear > 1 & shear < 6)

# use_Data3 <- subset(
#   all_Data, shear > 6)

f.sample <- factor(
  use_Data1$sample, level = c("blank", "CDNB15","CDNB60"))

ggplot(data = use_Data1,
       aes(x = f.sample, 
           y = EI)) +
  
  geom_boxplot(show.legend = FALSE, aes(fill = sample)) +
  scale_fill_manual(values=c("#d1d1d1", "#9ec0f7", "#5897fc"), name ="") +
  
  facet_wrap(~factor(shear,
             level = c(0.3, 0.53, 0.95),
             labels = c("0.3 Pa",
                        "0.53 Pa",
                        "0.95 Pa"))) +
  
  # facet_wrap(~factor(shear,
  #                    level = c(1.69, 3.00, 5.33),
  #                    labels = c("1.69 Pa",
  #                               "3.00 Pa",
  #                               "5.33 Pa"))) +

  # facet_wrap(~factor(shear,
  #                    level = c(9.49, 16.87, 30),
  #                    labels = c("9.49 Pa",
  #                               "16.87 Pa",
  #                               "30 Pa"))) +
  
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
                     label = "p.signif", method = "wilcox.test", paired = TRUE)


ggsave("result_deformability(x).tiff", path = "C:/Users/paubus/OneDrive - Universität Zürich UZH/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 6)
