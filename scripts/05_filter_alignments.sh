# @Author: Chenchen Zhu <czhu>
# @Date:   31-10-2019
# @Email:  czhu@me.com
# @Last modified by:   czhu
# @Last modified time: 2021-02-26
SCRIPTDIR="."
folder=$1
indir=$folder/alignments
outdir1=$folder/alignments_no_supp/
outdir2=$folder/alignments_supp/
outdir3=$folder/alignments_unspliced
mkdir -p $outdir1
mkdir -p $outdir2
mkdir -p $outdir3
ncpu=10
### filter reads with supplementary
cd $folder
find $indir -name "*bam" | xargs -n 1 -P $ncpu -I% bash -c 'python ~/FulQuant/sw/filter_reads_for_clustering.py % alignments_no_supp/$(basename %) alignments_supp/$(basename %) alignments_unspliced/$(basename %)'
