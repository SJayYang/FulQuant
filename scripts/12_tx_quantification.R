## from reads after filtering and cluster info we get the count matrix for each cluster
## we get for each tx cluster couts for all run/sample per row
suppressMessages(library(rtracklayer))
projectFolder = "."
SCRIPTDIR = file.path(projectFolder, "sw")
GENOMEDIR = file.path(projectFolder, "genome")
source(file.path(SCRIPTDIR,"clustering_functions.R"))

ncpu=10

args = commandArgs(trailingOnly=TRUE)
dataFolder = args[1]
infolder = file.path(dataFolder, "combined/")
outfolder = file.path(infolder, "tx_annot")

load(file.path(infolder, "tx_annot/tx_human.rda"))

### Grab the gene list and transcript list
gr <- as.data.frame(finalTx)
gene_list = gr[c('associated_gene', 'associated_tx')]
write.csv(gene_list, file="~/gene_list.csv")

tx = finalTx
load(file.path(infolder, "readsAfterFilter.rda"))

runNames = unique(extract_sampleName_from_qname(readsAfterFilter$name[sample(length(readsAfterFilter), 1000)]))

## XXX 6 samples hardcoded
#stopifnot(length(runNames) == 6)
runNames = sort(runNames)
# clusterTab = thisTxCluster %>% mutate(cl_id=displayName) %>%
#     select(clname,cl_id,flag,associated_gene,associated_tx,is_fixed)

runNamesList = split(extract_sampleName_from_qname(readsAfterFilter$name), readsAfterFilter$clname)

runCountMat = do.call(rbind,mclapply(runNamesList, function(x) table(factor(x, levels=runNames)), mc.cores=ncpu))

sampleNameFactor = sapply( strsplit(colnames(runCountMat),"_"), "[",1 )
print(sampleNameFactor)

# If only two samples
sampleCountMat = do.call(cbind, lapply(unique(sampleNameFactor), function(thisSample) rowSums(runCountMat[, sampleNameFactor == thisSample, drop=FALSE]) ) )
# If multiple samples
# sampleCountMat = do.call(cbind, lapply(unique(sampleNameFactor), function(thisSample) rowSums(runCountMat[, sampleNameFactor == thisSample]) ) )
colnames(sampleCountMat) = unique(sampleNameFactor)

stopifnot( all(tx$clname %in% rownames(runCountMat)) )

txRunCount = runCountMat[tx$clname,]
txSampleCount = sampleCountMat[tx$clname,]

save(runCountMat, sampleCountMat, file=file.path(outfolder, "clusters_quant.rda"))
saveRDS(runCountMat, file=file.path(outfolder, "clusters_quant_runCount.rds"))
saveRDS(sampleCountMat, file=file.path(outfolder, "clusters_quant_sampleCount.rds"))
save(txRunCount, txSampleCount, file=file.path(outfolder, "tx_human_quant.rda"))
saveRDS(txRunCount, file=file.path(outfolder, "tx_human_quant_runCount.rds"))
saveRDS(txSampleCount, file=file.path(outfolder, "tx_human_quant_sampleCount.rds"))
write.table(txRunCount, file.path(outfolder, "tx_human_final_run_quant.txt"), quote=FALSE, sep="\t",row.names=FALSE)
write.table(txSampleCount, file.path(outfolder, "tx_human_final_sample_quant.txt"), quote=FALSE, sep="\t",row.names=FALSE)
