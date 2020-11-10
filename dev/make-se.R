library(here)
library(GEOquery)
library(Biobase)
library(edgeR)
library(SummarizedExperiment)

# Read sample metadata ----

x <- GEOquery::getGEO(GEO = "GSE111543")
cd <- Biobase::pData(x$GSE111543_series_matrix.txt.gz)

experiment_design_names <- grep(":ch1$", colnames(cd), value = TRUE)
experiment_design <- cd[, experiment_design_names]
colnames(experiment_design) <- gsub(":ch1", "", colnames(experiment_design))

# Map metadata to data files ----

count_files <- list.files(here::here("GSE111543"), "^GSM")
names(count_files) <- gsub("(GSM[[:digit:]]+)_.*", "\\1", count_files)

experiment_design$files <- count_files[rownames(experiment_design)]

# Import data ----

rg <- edgeR::readDGE(experiment_design, here::here("GSE111543"), c(1, 7), skip = 1)

# Build SummarizedExperiment ----

se <- SummarizedExperiment(
    assays = list(counts = rg$counts),
    colData = experiment_design
)

saveRDS(se, here::here("rds/se.rds"))
