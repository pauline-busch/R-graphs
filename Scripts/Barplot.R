library(ggplot2)
library(ggthemes)
library(readxl)
library(data.table)
library(ggpubr)

df <- read_xlsx("C:/Users/miri/Documents/GitHub/R-graphs/data_tables/sodium_inhibition.xlsx")


block <- ggplot(df, aes(x = factor(group), y = side_scatter)) +
  
  geom_bar(
    
    aes(fill = factor(treatment, levels = c("control", "amiloride", "bumetanide","both"))), 
    stat = "identity", 
    position = position_dodge2()
    
  ) +
  
  labs(
    
    x = element_blank(), 
    y = "side scatter", 
    title = element_blank()
    
    ) +
  
  scale_fill_manual(values = c("grey", "#ff9191", "#f56e6e", "#bf0202"), name = "") +
  
  theme_light()

  
ggsave("Na-block.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", width = 5, height = 5)


