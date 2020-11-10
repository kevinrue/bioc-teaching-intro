library(here)
library(SummarizedExperiment)
library(org.Hs.eg.db)

se <- readRDS(here::here('rds/se.rds'))

columns(org.Hs.eg.db)
rowData(se)$symbol <- mapIds(org.Hs.eg.db, rownames(se), "SYMBOL", "ENSEMBL")

saveRDS(se, here::here("rds/se.gene_symbol.rds"))
