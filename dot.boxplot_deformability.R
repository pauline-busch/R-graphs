library(ggplot2)
library(ggpubr)
library(openxlsx)
library(data.table)


def_Data <- data.table(
  read.xlsx("result_deformability.xlsx"))