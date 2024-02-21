library(ggplot2)
library(ggpubr)
library(ggthemes)
library(openxlsx)
library(data.table)
library(dplyr)

results <- read.xlsx("PIEZO-patient.xlsx")

GSH.results <- results %>% filter(experiment == "ATP")
ATP.results <- results %>% filter(experiment == "GSH")

GSH.graph <- ggplot(GSH.results, aes(sample, value, fill = sample)) + 
  
  geom_col() +
  scale_fill_manual(values = c("#b00000", "#b19999"))

ATP.graph <- ggplot(ATP.results, aes(sample, value, fill = sample)) + 
  
  geom_col() +
  scale_fill_manual(values = c("#b00000", "#b19999"))

print(ATP.graph)