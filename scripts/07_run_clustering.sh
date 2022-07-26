# @Author: Chenchen Zhu <czhu>
# @Date:   29-10-2019
# @Email:  czhu@me.com
# @Last modified by:   czhu
# @Last modified time: 2021-02-26


## first merge relevant bam files into one
SCRIPTDIR=~/FulQuant/sw
folder=$1
combined_folder=$folder/combined

cd $folder/combined

bash $SCRIPTDIR/run_clustering.sh $combined_folder/all.bam
