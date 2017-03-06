Tophat Chicken + Platypus
#----------------
#----------------
#!/bin/bash
export PATH=$PATH:/share/public2/data/others/dengac2/App/bowtie2-2.3.0:/share/public2/data/others/dengac2/App/tophat-2.1.1.Linux_x86_64

s='chicken' #should be the same as the Genome folder name
g='Gallus_gallus.Gallus_gallus-5.0.87'
l='chicken/ftp.ensembl.org/pub/release-87/fasta/gallus_gallus/dna'
n='Gallus_gallus.Gallus_gallus-5.0.dna.toplevel'

a=$(echo "SRR306710 SRR306711 SRR306712 SRR306713 SRR306714 SRR306715 SRR306716 SRR306717 SRR306718 SRR306720 SRR306722 SRR306723")

for var in $a
do
mkdir -p /share/public2/data/others/dengac2/tophat_output/$s/$var
tophat --num-threads 8 -G /share/public2/data/others/dengac2/gtf/$g.gtf -o /share/public2/data/others/dengac2/tophat_output/$s/$var /share/public2/data/others/dengac2/Genome/$l/$n /share/public2/data/others/dengac2/Data/David/$var.fastq
done

#----------------
#----------------
#!/bin/bash
export PATH=$PATH:/share/public2/data/others/dengac2/App/bowtie2-2.3.0:/share/public2/data/others/dengac2/App/tophat-2.1.1.Linux_x86_64

s='platypus' #should be the same as the Genome folder name
g='Ornithorhynchus_anatinus.OANA5.87'
l='platypus/ftp.ensembl.org/pub/release-87/fasta/ornithorhynchus_anatinus/dna'
n='Ornithorhynchus_anatinus.OANA5.dna.toplevel'

a=$(echo "SRR306725 SRR306726 SRR306728 SRR306729 SRR306730 SRR306731 SRR306732 SRR306734 SRR306736 SRR306737 SRR306739 SRR306741")

for var in $a
do
mkdir -p /share/public2/data/others/dengac2/tophat_output/$s/$var
tophat --num-threads 8 -G /share/public2/data/others/dengac2/gtf/$g.gtf -o /share/public2/data/others/dengac2/tophat_output/$s/$var /share/public2/data/others/dengac2/Genome/$l/$n /share/public2/data/others/dengac2/Data/David/$var.fastq
done