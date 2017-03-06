#run Kallisto
PATH=$PATH:/share/public2/data/others/dengac2/App/kallisto_linux-v0.43.0_4/kallisto_linux-v0.43.0
cd /share/public2/data/others/dengac2/Data/David

kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_rhesus.idx -o kallisto_SRX081924 -b 100 SRR306779_1.fastq SRR306779_2.fastq

kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_gorrila.idx -o kallisto_SRX081945 -b 100 SRR306801_1.fastq SRR306801_2.fastq
kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_chimp.idx -o kallisto_SRX081956 -b 100 SRR306812_1.fastq SRR306812_2.fastq
kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_chimp.idx -o kallisto_SRX081957 -b 100 SRR306813_1.fastq SRR306813_2.fastq
kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_chimp.idx -o kallisto_SRX081958 -b 100 SRR306814_1.fastq SRR306814_2.fastq
kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_chimp.idx -o kallisto_SRX081959 -b 100 SRR306815_1.fastq SRR306815_2.fastq
kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_chimp.idx -o kallisto_SRX081960 -b 100 SRR306816_1.fastq SRR306816_2.fastq

kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_homo.idx -o kallisto_SRX081984 -b 100 SRR306840_1.fastq SRR306840_2.fastq
kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_homo.idx -o kallisto_SRX081986 -b 100 SRR306842_1.fastq SRR306842_2.fastq