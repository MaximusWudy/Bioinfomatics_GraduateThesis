Cufflink use
#-----------------
#-----------------

#!/bin/sh
export PATH=$PATH:/share/public2/data/others/dengac2/App/cufflinks-2.2.1.Linux_x86_64

s='orangutan' #should be the same as the Genome folder name
g='Pongo_abelii.PPYG2.87'
a=$(echo "SRR306791 SRR306793 SRR306794 SRR306795 SRR306796 SRR306797 SRR306798 SRR306799" | tr ' ' '\n')

for var in $a
do
mkdir -p /share/public2/data/others/dengac2/cufflinks/$s/$var
cufflinks -p 8 -g /share/public2/data/others/dengac2/gtf/$g.gtf -o /share/public2/data/others/dengac2/cufflinks/$s/$var /share/public2/data/others/dengac2/tophat_output/$s/$var/accepted_hits.bam
done


#---------------
#---------------
#!/bin/sh
export PATH=$PATH:/share/public2/data/others/dengac2/App/cufflinks-2.2.1.Linux_x86_64

s='chimp' #should be the same as the Genome folder name
g='Pan_troglodytes.CHIMP2.1.4.87' #the gtf file name
a=$(echo "SRR306811 SRR306817 SRR306818 SRR306819 SRR306820 SRR306821 SRR306822 SRR306823 SRR306824 SRR306825")

for var in $a
do
mkdir -p /share/public2/data/others/dengac2/cufflinks/$s/$var
cufflinks -p 8 -g /share/public2/data/others/dengac2/gtf/$g.gtf -o /share/public2/data/others/dengac2/cufflinks/$s/$var /share/public2/data/others/dengac2/tophat_output/$s/$var/accepted_hits.bam
done

#---------------
#---------------
#!/bin/sh
export PATH=$PATH:/share/public2/data/others/dengac2/App/cufflinks-2.2.1.Linux_x86_64

s='rhesus' #should be the same as the Genome folder name
g='Macaca_mulatta.Mmul_8.0.1.87'
a=$(echo "SRR306777 SRR306778 SRR306780 SRR306781 SRR306782 SRR306783 SRR306784 SRR306785 SRR306786 SRR306787 SRR306789 SRR306790")

for var in $a
do
mkdir -p /share/public2/data/others/dengac2/cufflinks/$s/$var
cufflinks -p 8 -g /share/public2/data/others/dengac2/gtf/$g.gtf -o /share/public2/data/others/dengac2/cufflinks/$s/$var /share/public2/data/others/dengac2/tophat_output/$s/$var/accepted_hits.bam
done

#---------------
#---------------

#!/bin/sh
export PATH=$PATH:/share/public2/data/others/dengac2/App/cufflinks-2.2.1.Linux_x86_64

s='gorilla' #should be the same as the Genome folder name
g='Gorilla_gorilla.gorGor3.1.87'

a=$(echo "SRR306800 SRR306802 SRR306803 SRR306804 SRR306805 SRR306806 SRR306807 SRR306808 SRR306809 SRR306810")

for var in $a
do
mkdir -p /share/public2/data/others/dengac2/cufflinks/$s/$var
cufflinks -p 8 -g /share/public2/data/others/dengac2/gtf/$g.gtf -o /share/public2/data/others/dengac2/cufflinks/$s/$var /share/public2/data/others/dengac2/tophat_output/$s/$var/accepted_hits.bam
done

#---------------
#---------------

#!/bin/sh
export PATH=$PATH:/share/public2/data/others/dengac2/App/cufflinks-2.2.1.Linux_x86_64

s='opossum' #should be the same as the Genome folder name
g='Monodelphis_domestica.BROADO5.87'

a=$(echo "SRR306742 SRR306744 SRR306745 SRR306746 SRR306748 SRR306750 SRR306751 SRR306752 SRR306753 SRR306754 SRR306755 SRR306756")

for var in $a
do
mkdir -p /share/public2/data/others/dengac2/cufflinks/$s/$var
cufflinks -p 8 -g /share/public2/data/others/dengac2/gtf/$g.gtf -o /share/public2/data/others/dengac2/cufflinks/$s/$var /share/public2/data/others/dengac2/tophat_output/$s/$var/accepted_hits.bam
done

#---------------
#---------------