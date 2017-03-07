#！/bin/sh
PATH=$PATH:/share/public2/data/others/dengac2/App/tophat-2.1.1.Linux_x86_64

cd /share/public2/data/others/dengac2/Data/Jason

d=$(echo Jason)

ls *_1.fastq > tag.txt
cut -d '_' -f1 tag.txt > tag0.txt
q=$(cat tag0.txt)

m=$(echo Jason_pairedend_match.txt)

#there is a match file (David_pairedend_match.txt) for the paired end David data
#match for SRR to species, because we need different gtf files

for var in $q; do
if [[ $(grep $var $m | cut -f1) == "Macaca mulatta" ]];then
g=$(echo Macaca_mulatta.Mmul_8.0.1.87.gtf)
s=$(echo rhesus)
t=$(echo /rhesus/ftp.ensembl.org/pub/release-87/fasta/macaca_mulatta/dna/Macaca_mulatta.Mmul_8.0.1.dna.toplevel)

elif [[ $(grep $var $m | cut -f1) == "Mus musculus" ]];then
g=$(echo Mus_musculus.GRCm38.87.gtf)
s=$(echo mouse)
t=$(echo /mouse/ftp.ensembl.org/pub/release-87/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.toplevel)

elif [[ $(grep $var $m | cut -f1) == "Rattus norvegicus" ]];then
g=$(echo Rattus_norvegicus.Rnor_6.0.87.gtf)
s=$(echo rat)
t=$(echo /rat/Rattus_norvegicus.Rnor_6.0.dna.toplevel)

elif [[ $(grep $var $m | cut -f1) == "Bos taurus" ]];then
g=$(echo Bos_taurus.UMD3.1.87.gtf)
s=$(echo cow)
t=$(echo /cow/Bos_taurus.UMD3.1.dna.toplevel)

elif [[ $(grep $var $m | cut -f1) == "Gallus gallus" ]];then
g=$(echo Gallus_gallus.Gallus_gallus-5.0.87.gtf)
s=$(echo chicken)
t=$(echo /chicken/ftp.ensembl.org/pub/release-87/fasta/gallus_gallus/dna/Gallus_gallus.Gallus_gallus-5.0.dna.toplevel)

fi

mkdir -p /share/public2/data/others/dengac2/tophat_output/$d/$s/$var
tophat2 --num-threads 16 -G /share/public2/data/others/dengac2/gtf/$g -o /share/public2/data/others/dengac2/tophat_output/$d/$s/$var /share/public2/data/others/dengac2/Genome${t} ${var}_1.fastq ${var}_2.fastq

done