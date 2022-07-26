# @Author: Chenchen Zhu <czhu>
# @Date:   29-10-2019
# @Email:  czhu@me.com
# @Last modified by:   czhu
# @Last modified time: 2021-02-26


## merge bam files for this dataset both long and read reads
folder=$1
indir=$folder/alignments_no_supp/
outdir=$folder/combined/
mkdir -p $outdir
outfile=$outdir/fulquant_combined_no_supp.bam
ncpu=20
samtools merge -u -@ $ncpu - $(ls $indir/*bam) | samtools sort -m 1G -@ $ncpu > $outfile && samtools index -@ $ncpu $outfile

rm -f $outdir/all.bam
rm -f $outdir/all.bam.bai
ln -s $outfile $outdir/all.bam
ln -s $outfile.bai $outdir/all.bam.bai
