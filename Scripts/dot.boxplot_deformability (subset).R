library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)

theme_set(theme_light())

all_Data <- read.xlsx("LoRRca_deformability.xlsx")

use_Data1 <- subset(
  all_Data, shear < 1
)

# use_Data2 <- subset(
#   all_Data, shear > 1 & shear < 6)

# use_Data3 <- subset(
#   all_Data, shear > 6)

f_sample <- factor(
  use_Data1$sample, level = c("blank", "CDNB")
)

ggplot(data = use_Data1,
  aes(x = f_sample, y = EI)
) +

  geom_boxplot(show.legend = FALSE, aes(fill = factor(sample, level = c("blank", "CDNB")))) +
  scale_fill_manual(values = c("#d1d1d1", "#bf0202"), name = "") +
  facet_wrap(~factor(
    shear,
    level = c(0.3, 0.53, 0.95),
    labels = c("0.3 Pa", "0.53 Pa", "0.95 Pa")
  )) +
  
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
    title = ("RBC deformability (low shear stress)"), 
    x="", 
    y="") +
  
  theme(
    strip.text = element_text(size = 12),
    plot.title = element_text(hjust=0.5)
  ) +
  
  stat_compare_means(comparisons = list(c("blank","CDNB")),
                     label = "p.signif", method = "wilcox.test")


ggsave("result_deformability(xyz).tiff",
       path = "~/GitHub/R-graphs/Graphs and figures",
       units = "in",
       dpi = 300,
       compression = "lzw",
       width = 5,
       height = 5)
