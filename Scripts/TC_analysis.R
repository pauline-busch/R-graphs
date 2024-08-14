library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)
library(ggstatsplot)
library(dplyr)
library(car)


Data <- data.table(
  read.xlsx("TC_analysis.xlsx"))

f.type <- factor(
  Data$type, level = c("blank", "CDNB","Diamide", "NEM")
  )

ggplot(
  data = Data,
  aes(x = f.type, y = Data$max_RI)
  ) +
  
  geom_boxplot(
    show.legend = FALSE, aes(fill = type, alpha = 0.5, color = type), width = 0.4
    ) +
  
  stat_summary(
    fun = mean,
    geom = "text",
    aes(label = paste0("Mean: ", round(after_stat(y), 2))),
    vjust = 22,  
    size = 3
  ) +
  
  geom_jitter(color = "#000000", size = 2, width = 0.1, alpha = 0.5) +
  
  
  labs(
    title = ("Maximum refractive index"),
    x="", 
    y="max_RI") +
  
  # ylim(NA, 700) +
  
  theme_classic2() +
  
  theme(
    plot.title = element_text(hjust = 0.5, size = 20, face = "bold"),
  ) 


ggsave("TC_RI.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 8, height = 6)

#preparation for statistical evaluation
grouped_data <- split(Data$`cv(fL)`, Data$type)
shapiro_results <- lapply(grouped_data, shapiro.test)
levene_result <- leveneTest(`cv(fL)` ~ factor(type), data = Data)

#statistical evaluation
ggbetweenstats(
  data = Data,
  x = type,
  y = `cv(fL)`,
  type = "nonparametric",  # Set to nonparametric to use Kruskal-Wallis test
  pairwise.comparisons = TRUE,            # Perform post-hoc pairwise comparisons (Dunn's test)
  pairwise.display = "significant",    # Show only significant comparisons (or "all")
  pairwise.annotation = "p.value",        # Annotate the plot with p-values
  title = "Volume"
)
   ggsave("TCstat_volume2.tiff", path = "C:/Users/miri/Documents/GitHub/R-graphs/Graphs and figures", units = "in", dpi=300, compression = 'lzw', width = 12, height = 8)

