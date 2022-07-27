#!/bin/bash

# Runs through the fulquant pipeline
#folder=/home/yangs/full_ONT_data/ONT/NGS4416/R8143
# folder=/home/yangs/full_ONT_data/ONT/NGS4416/R8144
# folder=/home/yangs/test_fastq_data/fulquant_fastq_data
folder=/home/yangs/ONT_comparisons/Dopa_Motor

echo "Starting script"
echo "Running on $folder"
# echo "01_identify_ispcr"
# Rscript scripts/01_identify_ispcr.R $folder
# echo "02_get_trim_table"
# Rscript scripts/02_get_trim_table.R $folder
# echo "03_do_trimming"
# Rscript scripts/03_do_trimming.R $folder
# echo "04_alignment"
# bash scripts/04_alignment.sh $folder
# echo "05_filter_alignments"
# bash scripts/05_filter_alignments.sh $folder
echo "06_merge_bamfiles"
sh scripts/06_merge_bamfiles.sh $folder
echo "07_run_clustering"
bash scripts/07_run_clustering.sh $folder
echo "07_run_filter_stats"
bash scripts/07_run_filter_stats.sh $folder
echo "08_filter_clustering"
Rscript scripts/08_filter_clustering.R $folder
echo "09_txCluster_annotation"
Rscript scripts/09_txCluster_annotation.R $folder
echo "10_tx_classification"
Rscript scripts/10_tx_classification.R $folder
echo "11_assemble_final_human_tx"
Rscript scripts/11_assemble_final_human_tx.R $folder
echo "12_tx_quantification"
Rscript scripts/12_tx_quantification.R $folder
echo "done"
