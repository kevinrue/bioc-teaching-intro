library(here)
library(SummarizedExperiment)
library(tibble)
library(ggplot2)
library(cowplot)
library(dplyr)

se <- readRDS(here::here('rds/se.gene_symbol.rds'))

# Remove bulk and blanks ----

keep <- with(
    colData(se),
    status %in% c("uninfected", "exposed", "infected"))
se <- se[, keep]

# Boxplot of gene expressions ----

plot_data <- tibble(
    value = assay(se)[which(rowData(se)$symbol == "IL12B"), ]
    ) %>%
    bind_cols(as.data.frame(colData(se)))

ggplot(plot_data, aes(time, value, fill = time)) +
    geom_boxplot() +
    facet_grid(infection ~ status) +
    scale_y_log10() +
    cowplot::theme_cowplot() +
    labs(title = "IL12B", y = "counts")

# Density plots of gene expression ----

plot_data <- tibble(
    value = assay(se)[which(rowData(se)$symbol == "IL12B"), ]
    ) %>%
    bind_cols(as.data.frame(colData(se)))

ggplot(plot_data, aes(time, value, fill = time)) +
    geom_violin(draw_quantiles = 0.5) +
    facet_grid(infection ~ status) +
    scale_y_log10() +
    cowplot::theme_cowplot() +
    labs(title = "IL12B", y = "counts")

# Scatter plot gene 1 vs gene 2, showing samples/cells, coloured based on their annotation. ----

plot_data <- tibble(
    IL1B = assay(se)[which(rowData(se)$symbol == "IL1B"), ],
    MARCHF1 = assay(se)[which(rowData(se)$symbol == "MARCHF1"), ]
    ) %>%
    bind_cols(as.data.frame(colData(se)))

ggplot(plot_data, aes(IL1B, MARCHF1, color = time)) +
    geom_point() +
    facet_grid(infection ~ status) +
    scale_y_log10() + scale_x_log10() +
    cowplot::theme_cowplot()

# Lines showing expression of genes over time. ----

# Lines showing expression of genes over time for different variables. ----

# Faceting is very important.  ----
