#Function: this script is used for scrapping the genome sequence from USCS genome browser based on the gtf file of ADAR 3 types of genes
#Author: ANcheng Deng
#Date: 2017/3/5

import requests
import glob
from bs4 import BeautifulSoup

#----
#read from start codon file and match with the search imput
for file in glob.glob('*startcodon*'):
#file is given the startcodon file names
    species=file.split('.')[0]
    fa_in=open(file,'r')
    counter=1
    for line in fa_in:
        line=line.rstrip()
        line=line.split('\t')
        seq_chr='chr'+line[0]+'%3A'
        #---
        if species=='human':
            head = 'https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=133251999&l=133251999&r=133280861&getDnaPos='
            middle = '&db=hg38&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end = '&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='mouse':
            head ='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=56694975&l=56694975&r=56714605&getDnaPos='
            middle='&db=mm10&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='chicken':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=45985743&l=45985743&r=45991655&getDnaPos='
            middle='&db=galGal5&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='chimp':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=132959917&l=132959917&r=132967918&getDnaPos='
            middle='&db=panTro4&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='cow':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=21592156&l=21592156&r=21596916&getDnaPos='
            middle='&db=bosTau6&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='gorilla':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=114753600&l=114753600&r=114763600&getDnaPos='
            middle='&db=gorGor3&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='opossum':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=14658819&l=14658819&r=14669558&getDnaPos='
            middle='&db=monDom5&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='orangutan':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=152299761&l=152299761&r=152501081&getDnaPos='
            middle='&db=ponAbe2&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='platypus':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=870776&l=870776&r=1056769&getDnaPos='
            middle='&db=ornAna2&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='pongo_pygmaeus':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=152299761&l=152299761&r=152501081&getDnaPos='
            middle='&db=ponAbe2&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='rat':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=80608552&l=80608552&r=80639261&getDnaPos='
            middle='&db=rn6&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        elif species=='rhesus':
            head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=64242279&l=64242279&r=64278013&getDnaPos='
            middle='&db=rheMac8&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
            end='&boolshad.hgSeq.revComp=0&submit=get+DNA'
        #----

        if line[4]=="-":
            seq_rev = 'hgSeq.revComp=on'
            seq_loc = line[3] + '-' +str(int(line[3])+3000) #if antisense, advance 3kb
        else:
            seq_rev=''
            seq_loc = str(int(line[2])-3000) + '-' + line[2] #if model, retract 3kb
        search_link = head + seq_chr + seq_loc + middle + seq_rev + end
        #-----
        #   process the file in the search link and save with name
        r=requests.get(search_link)
        raw_seq=r.text
        soup=BeautifulSoup(raw_seq)
        process_seq=soup.pre.string
        seq_split=process_seq.split('\n')
        seq=''.join(seq_split[2:])
        seq_done=seq_split[1]+'\n'+seq
        print(seq_done)
        file_name=species+'.'+[x.split('"') for x in line[5].split(';')][1][1]+'_'+str(counter)+'.fa'
        fa_out=open(file_name,'w')
        fa_out.write(seq_done)
        fa_out.close()
        print('Saved as',file_name)
        counter+=1


#head='https://genome.ucsc.edu/cgi-bin/hgc?hgsid=582114981_NhtKR6Cickz29t4Yvg3xrOpDyHsn&g=htcGetDna2&table=&i=mixed&o=133251999&l=133251999&r=133280861&getDnaPos='
#seq_chr='chr9%3A'
#seq_loc='133252000-133280861'
#middle='&db=hg38&hgSeq.cdsExon=1&hgSeq.padding5=0&hgSeq.padding3=0&hgSeq.casing=upper&boolshad.hgSeq.maskRepeats=0&hgSeq.repMasking=lower&'
#seq_rev='hgSeq.revComp=on'
#end='&boolshad.hgSeq.revComp=0&submit=get+DNA'


#-----
#process the file in the search link and save with name
#r=requests.get(search_link)
#raw_seq=r.text
#soup=BeautifulSoup(raw_seq)
#process_seq=soup.pre.string
#seq_split=process_seq.split('\n')
#seq=''.join(seq_split[2:])
#seq_done=seq_split[1]+'\n'+seq
#print(seq_done)
#fa_out=open('')

##################
#----