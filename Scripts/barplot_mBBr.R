library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)

theme_set(theme_light())

thiols <- read.xlsx("C:/Users/miri/Documents/GitHub/R-graphs/data_tables/mBBr_fluorescence.xlsx")

P1 <- ggplot(
  data = thiols, 
  aes(y = mBBr)
  ) + 
  
  geom_bar(
    aes(x = factor(treatment, levels = c("control", "CDNB60", "DTT15", "etGSH30"))), 
    stat = "identity", position = position_dodge2(), show.legend = FALSE
    ) +
  
  labs(x = "", y = "mBBr fluorescence")
             
ggsave("mbbr.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 4, height = 3)
             