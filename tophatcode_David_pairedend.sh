#！/bin/sh
PATH=$PATH:/share/public2/data/others/dengac2/App/tophat-2.1.1.Linux_x86_64

cd /share/public2/data/others/dengac2/Data/David

d=$(echo David)

ls *_1.fastq > tag.txt
cut -d '_' -f1 tag.txt > tag0.txt
q=$(cat tag0.txt)

m=$(echo David_pairedend_match.txt)

#there is a match file (David_pairedend_match.txt) for the paired end David data
#match for SRR to species, because we need different gtf files

for var in $q; do
if [[ $(grep $var $m | cut -f1) == "Macaca mulatta" ]];then
g=$(echo Macaca_mulatta.Mmul_8.0.1.87.gtf)
s=$(echo rhesus)
t=$(echo /rhesus/ftp.ensembl.org/pub/release-87/fasta/macaca_mulatta/dna/Macaca_mulatta.Mmul_8.0.1.dna.toplevel)

elif [[ $(grep $var $m | cut -f1) == "Pongo pygmaeus" ]];then
g=$(echo Pongo_pygmaeus.PPYG2.61.gtf)
s=$(echo pongo_pygmaeus)
t=$(echo /pongo_pygmaeus/Pongo_pygmaeus.PPYG2.61.dna.toplevel)

elif [[ $(grep $var $m | cut -f1) == "Gorilla gorilla" ]];then
g=$(echo Gorilla_gorilla.gorGor3.1.87.gtf)
s=$(echo gorilla)
t=$(echo /gorilla/ftp.ensembl.org/pub/release-87/fasta/gorilla_gorilla/dna/Gorilla_gorilla.gorGor3.1.dna.toplevel)

elif [[ $(grep $var $m | cut -f1) == "Pan troglodytes" ]];then
g=$(echo Pan_troglodytes.CHIMP2.1.4.87.gtf)
s=$(echo chimp)
t=$(echo /chimp/ftp.ensembl.org/pub/release-87/fasta/pan_troglodytes/dna/Pan_troglodytes.CHIMP2.1.4.dna.toplevel)
fi

mkdir -p /share/public2/data/others/dengac2/tophat_output/$d/$s/$var
tophat2 --num-threads 8 -G /share/public2/data/others/dengac2/gtf/$g -o /share/public2/data/others/dengac2/tophat_output/$d/$s/$var /share/public2/data/others/dengac2/Genome${t} ${var}_1.fastq ${var}_2.fastq

done