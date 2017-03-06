#process the Cufflinks result 
#Author Ancheng Deng
#Date: 2017/3/3

du -ah | cut -f2 | grep -E 'genes.fpkm' | xargs grep ADAR | less -S  
#./gorilla/SRR306809/genes.fpkm_tracking:CUFF.2099       -       -       CUFF.2099       ADAR    -       1:133575255-
#./gorilla/SRR306809/genes.fpkm_tracking:CUFF.3217       -       -       CUFF.3217       ADARB2  -       10:1199724-1
#./gorilla/SRR306809/genes.fpkm_tracking:CUFF.16745      -       -       CUFF.16745      ADARB1  -       21:33817746-

#then process the species and SRR tag
du -ah | cut -f2 | grep -E 'genes.fpkm' | xargs grep ADAR | cut -f1,5,7,10 | less -S
#CUFF.2099       ADAR    1
#CUFF.3217       ADARB2  10
#CUFF.16745      ADARB1  21

###
#make cufflinks value
du -ah | cut -f2 | grep -E 'genes.fpkm' | xargs grep ADAR | cut -f1,5,7,10 | less -S > cufflinks_value.txt

#----------------------------
du -ah | cut -f2 | grep -E 'genes.fpkm' | xargs grep ADAR | cut -f1,5,7,10 | cut -d ':' -f1 | less -S
#./gorilla/SRR306809/genes.fpkm_tracking 
#./gorilla/SRR306809/genes.fpkm_tracking
#./gorilla/SRR306809/genes.fpkm_tracking

###
#make cufflinks index
du -ah | cut -f2 | grep -E 'genes.fpkm' | xargs grep ADAR | cut -f1,5,7,10 | cut -d ':' -f1 | less -S > cufflinks_index.txt

#run shell with python script
bash /share/public2/data/others/dengac2/Code/shell_stringprocess_20170303.sh
