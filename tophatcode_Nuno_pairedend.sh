#！/bin/sh
PATH=$PATH:/share/public2/data/others/dengac2/App/tophat-2.1.1.Linux_x86_64

cd /share/public2/data/others/dengac2/Data/Nuno

d=$(echo Nuno)

ls *_1.fastq > tag.txt
cut -d '_' -f1 tag.txt > tag0.txt
q=$(cat tag0.txt)

#there is a match file (Nuno_pairedend_match.txt) for the paired end Nuno data
#match for SRR to species, because we need different gtf files

for var in $q; do
if [[ $(grep $var Nuno_pairedend_match.txt | cut -f1) == "Mus musculus" ]];then
g=$(echo Mus_musculus.GRCm38.87.gtf)
s=$(echo mouse)
t=$(echo /mouse/ftp.ensembl.org/pub/release-87/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.toplevel)

elif [[ $(grep $var Nuno_pairedend_match.txt | cut -f1) == "Gallus gallus" ]];then
g=$(echo Gallus_gallus.Gallus_gallus-5.0.87.gtf)
s=$(echo chicken)
t=$(echo /chicken/ftp.ensembl.org/pub/release-87/fasta/gallus_gallus/dna/Gallus_gallus.Gallus_gallus-5.0.dna.toplevel)

elif [[ $(grep $var Nuno_pairedend_match.txt | cut -f1) == "Anolis carolinensis" ]];then
g=$(echo Anolis_carolinensis.AnoCar2.0.87.gtf)
s=$(echo lizard)
t=$(echo /lizard/Anolis_carolinensis.AnoCar2.0.dna.toplevel)

elif [[ $(grep $var Nuno_pairedend_match.txt | cut -f1) == "Xenopus tropicalis" ]];then
g=$(echo Xenopus_tropicalis.JGI_4.2.87.gtf)
s=$(echo frog)
t=$(echo /frog/Xenopus_tropicalis.JGI_4.2.dna.toplevel)
fi

mkdir -p /share/public2/data/others/dengac2/tophat_output/$d/$s/$var
tophat2 -num-threads 16 -G /share/public2/data/others/dengac2/gtf/$g -o /share/public2/data/others/dengac2/tophat_output/$d/$s/$var /share/public2/data/others/dengac2/Genome${t} ${var}_1.fastq ${var}_2.fastq

done