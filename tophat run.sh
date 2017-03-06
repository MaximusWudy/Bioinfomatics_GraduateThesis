#tophat run 

tophat --num-threads 8 -G /share/public2/data/others/dengac2/gtf/Mus_musculus.GRCm38.87.gtf  -o /share/public2/data/others/dengac2/tophat_output  /share/public2/data/others/dengac2/Genome/mouse/ftp.ensembl.org/pub/release-87/fasta/mus_musculus/dna/Mus_musculus.GRCm38.dna.chromosome.merge /share/public2/data/others/dengac2/Data/David/SRR306757.fastq 


tophat --num-threads 8 -G /share/public2/data/others/dengac2/gtf/Homo_sapiens.GRCh38.87.gtf -o /share/public2/data/others/dengac2/tophat_output /share/public2/data/others/dengac2/Genome/human/human_gennome38 /share/public2/data/others/dengac2/Data/David/SRR306838.fastq

export PATH=$PATH:/share/public2/data/others/dengac2/App/tophat-2.1.1.Linux_x86_64

tophat --num-threads 8 -G /share/public2/data/others/dengac2/gtf/

tophat --num-threads 8 -G /share/public2/data/others/dengac2/Genome/human/Homo_sapiens.GRCh38.87.gtf -o /share/public2/data/others/dengac2/tophat_output/ /share/public2/data/others/dengac2/Genome/human/Homo_sapiens.GRCh38.87 /share/public2/data/others/dengac2/Data/David/SRR306836.fastq 