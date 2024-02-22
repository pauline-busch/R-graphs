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
  scale_fill_manual(values = c("#91d3ff", "#2870ed")) +
  ylab("GSH [µmol / g Hb]") +
  xlab("") +
  theme(legend.position = "none") +
  geom_text(aes(label = round(value, 1)), vjust = 1.5, colour = "white")

ATP.graph <- ggplot(ATP.results, aes(sample, value, fill = sample)) + 
  
  geom_col() +
  scale_fill_manual(values = c("#91d3ff", "#2870ed")) +
  ylab("ATP [mol / g Hb]") +
  xlab("") +
  theme(legend.position = "none") +
  geom_text(aes(label = round(value, 1)), vjust = 1.5, colour = "white")

print(ggarrange(GSH.graph, ATP.graph))