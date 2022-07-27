conda install -c conda-forge r-base=3.5.1
conda install -c conda-forge r-remotes
conda install -c bioconda bioconductor-biostrings
conda install -c bioconda bioconductor-genomicranges
conda install -c conda-forge r-mgcv
conda install -c bioconda bioconductor-shortread
# When you copy dev_4 to another machine, run the commands underneath (genomic features)
conda install -c bioconda bioconductor-genomicfeatures
conda install -c conda-forge r-xml
# When dealing w rtracklayer issues, download from BiocManager insteda
# Install BiocManager v3.8 first
conda install -c bioconda bioconductor-rtracklayer

# Sys.setenv(TAR = "/bin/tar")
# Install remotes::install_github('Czhu/R_nanopore')
# After this, run BiocManager::valid(), and run whatever command they give you

## all of this is allready installed in dev_4
conda install -c r r-domc
conda install -c conda-forge pigz
conda install -c bioconda minimap2
conda install -c bioconda samtools
pip install pysam
conda install -c bioconda bedtools
conda install -c bioconda tabix
conda install -c bioconda java-jdk
pip install htseq

# Install DESeq2
# Install hmisc first throught install.packages
# Instlal locfit through conda
BiocManager::install("DESeq2")


