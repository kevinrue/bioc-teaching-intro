# Data ----
# x <- GEOquery::getGEOSuppFiles(GEO = "GSE111543") # timeout - see geo-download.sh

# Sample metadata ----
# x <- GEOquery::getGEOfile(GEO = "GSE111543")
# dest <- file.path(here::here(), "GSE111543", basename(x))
# file.copy(x, dest)
# x <- GEOquery::parseGEO(fname = dest)
# x <- GEOquery::getGEO(filename = dest)
