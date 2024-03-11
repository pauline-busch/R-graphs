library(ggplot2)
library(ggthemes)
library(readxl)
library(data.table)
library(ggpubr)

df <- read_xlsx("C:/Users/paubus/OneDrive - Universität Zürich UZH/Documents/GitHub/R-graphs/data_tables/sodium_inhibition.xlsx")


block <- ggplot(df, aes(x = group, y = side_scatter)) +
  geom_bar(aes(fill = factor(treatment, levels = c("blank", "amiloride", "bumetanide","both"))), stat = "identity", position = position_dodge(width = 1)) +
  labs(x = element_blank(), y = "side scatter", title = element_blank()) +
  scale_fill_manual(values = c("grey", "#92e0f7", "#a974d4", "#4d2ae8"), name = "") +
  theme(legend.position = "right") +
  theme_pubclean()

  
ggsave("Na-block.tiff", path = "C:/Users/paubus/OneDrive - Universität Zürich UZH/Documents/GitHub/R-graphs/Graphs and figures", width = 5, height = 5)

