###################
#This file is for GEO sra file name match with server fastq file
#Author: Ancheng Deng
#Last Update: 2016/12/7
###################

#----Section 1---------
#----extract the sra file location from server output
setwd("C:/Users/win/Dropbox/本科毕业设计--生物/Data/")
list.files()
text=read.table('sra_filelocation1130.txt',stringsAsFactors = F)
head(text)
text1=text$V2[grepl('sra',text$V2)]
head(text1)
fileConn<-file('fastqdump_Jason1130.sh')
writeLines(text1,fileConn,sep=' ')
close(fileConn)

#------------------

#----Section 2------
#----Make the match table for 3 paper source
setwd('I:/ZhangLab毕业论文相关/Data Match')
list.files()
#read one for trial
match_david=read.table('text_David1206.txt',sep='\t', skip=4,stringsAsFactors = F)
#create variable names
names(match_david)=c('GEOquery','folder','authornote','species','tissue')

match_nuno=read.table('text_Nuno1206.txt',sep='\t', skip=3,stringsAsFactors = F)
names(match_nuno)=c('GEOquery','folder','authornote','species','tissue')

match_jason=read.table('text_Jason1206.txt',sep='\t', skip=3,stringsAsFactors = F)
names(match_jason)=c('GEOquery','folder','authornote','species','tissue')

#add the file location files
david_loc=read.table('file_match_David1207.txt',stringsAsFactors = F,sep='\t')
jason_loc=read.table('file_match_Jason1207.txt',stringsAsFactors = F,sep='\t')
nuno_loc=read.table('file_match_Nuno1207.txt',stringsAsFactors = F,sep='\t')

#use transform to add a column 
library(stringr)

fileloc<-function(x,y,z){
  str_sub(y[,2],1,1)<-''
  if (z=='David'){
  file_loc=paste0('/share/public2/data/others/dengac2/Data/David',
                 y[grepl(x,y[,2]),2])
  }
  else if (z=='Jason'){
    file_loc=paste0('/share/public2/data/others/dengac2/Data/Jason',
                    y[grepl(x,y[,2]),2])
  }
  else if (z=='Nuno'){
    file_loc=paste0('/share/public2/data/others/dengac2/Data/Nuno',
                    y[grepl(x,y[,2]),2])
  }
  else {print('Please reconsider the name of your datasets...')}
  
  if (length(file_loc)>1){
    cat('The file has more than one match, only return the first one.\n They are:\n')
    cat(paste("folder name:",x),'\n')
    cat("file location:\n",paste(file_loc,sep='\n'),'\n\n')
  }
  return(file_loc[1])
}

#----
dataset=match_david
index=david_loc
#----
for (i in 1:nrow(dataset)){
  dataset[i,'filelocation']<-fileloc(dataset[i,'folder'],index,'David')
}

#generally good but there being multiple files in a single folder
#total 16 folders

match_david$GEOquery[which(match_david$folder=='SRX081906')]
#"gsm752615"
#########################

#----Jason to make the pipeline---
#use the previous written function 'fileloc'
#----
dataset=match_jason
index=jason_loc
#----
library(stringr)
for (i in 1:nrow(dataset)){
  dataset[i,'filelocation']<-fileloc(dataset[i,'folder'],index,'Jason')
}

#check
head(dataset)

#write the fastq file location and the kallisto command
fastq_loc<-function(x){
  str_sub(x$filelocation,47,66)<-''
  x[,'fastqc_loc1']<-paste0(str_sub(x$filelocation,1,55),'_1.fastq')
  x[,'fastqc_loc2']<-paste0(str_sub(x$filelocation,1,55),'_2.fastq')
  return(x)                   
}

dataset=fastq_loc(dataset)

#make the idx files for genome to be used 
#function x is the species input
match_species<-function(x){
  if (x=='Bos taurus'){simplename='cow'}
  else if (x=='Gallus gallus'){simplename='chicken'}
  else if (x=='Macaca mulatta'){simplename='rhesus'}
  else if (x=='Mus musculus'){simplename='mouse'}
  else if (x=='Rattus norvegicus'){simplename='rat'}
  else {print("Sorry, but no species match...");simplename=NA}
  return(simplename)
  
}

a<-sapply(as.list(dataset$species),match_species)
b<-sapply(as.list(levels(factor(dataset$species))),match_species)
#'a' is a set of simple name corresponding with the genome files
#'b' is the levels of simple names
#'d' is the file relative route when in Genome folder
#'
d<-c('./cow/Bos_taurus.UMD3.1.cdna.all.fa.gz','./chicken/Gallus_gallus.Gallus_gallus-5.0.cdna.all.fa.gz',
     './rhesus/Macaca_mulatta.Mmul_8.0.1.cdna.all.fa.gz','./mouse/Mus_musculus.GRCm38.cdna.all.fa.gz',
     './rat/Rattus_norvegicus.Rnor_6.0.cdna.all.fa.gz')
index_command=paste0('kallisto index -i transcripts_',b,'.idx ',d)
quant_command=paste0('kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_',a,'.idx -o kallisto_',dataset$GEOquery,' -b 100 ',
               dataset$fastqc_loc1,' ',dataset$fastqc_loc2)

#write fileConn for index command
getwd()
fileConn<-file('Jason_index_command1207.sh')
writeLines(index_command,con=fileConn)
close(fileConn)

#write fileConn for quant command
getwd()
fileConn<-file('Jason_quant_command1207.sh')
writeLines(quant_command,con=fileConn)
close(fileConn)
#this command file should be put under Jason root folder

#########
#----Nuno that part for Animals----
head(match_nuno)
#----
dataset=match_nuno
index=nuno_loc
#----
library(stringr)
for (i in 1:nrow(dataset)){
  dataset[i,'filelocation']<-fileloc(dataset[i,'folder'],index,'Nuno')
}

head(dataset)
#use the previous written function 'fastq_loc', just change the character index
fastq_loc_nuno<-function(x){
  x[,'fastqc_loc1']<-paste0(str_sub(x$filelocation,1,54),'_1.fastq')
  x[,'fastqc_loc2']<-paste0(str_sub(x$filelocation,1,54),'_2.fastq')
  return(x)                   
}

dataset=fastq_loc_nuno(dataset)

#function x is the species input
#we already have  'Gallus gallus' 'Mus musculus' 
match_species_nuno<-function(x){
  if (x=='Anolis carolinensis'){simplename='lizard'}
  else if (x=='Gallus gallus'){simplename='chicken'}
  else if (x=='Tetraodon nigroviridis'){simplename='pufferfish'}
  else if (x=='Mus musculus'){simplename='mouse'}
  else if (x=='Xenopus tropicalis'){simplename='frog'}
  else {print("Sorry, but no species match...");simplename=NA}
  return(simplename)
  
}
a<-sapply(as.list(dataset$species),match_species_nuno)
b<-sapply(as.list(levels(factor(dataset$species))),match_species_nuno)
#since we only is 3 of them
b<-b[c(1,4,5)]
#'a' is a set of simple name corresponding with the genome files
#'b' is the levels of simple names
#'d' is the file relative route when in Genome folder
# right now we only need to fill the 'Tetraodon nigroviridis' 
#'Xenopus tropicalis' 'Anolis carolinensis'
d<-c('./lizard/Anolis_carolinensis.AnoCar2.0.cdna.all.fa.gz','./Xenopus_tropicalis.JGI_4.2.cdna.all.fa.gz','./Tetraodon_nigroviridis.TETRAODON8.cdna.all.fa.gz')

index_command=paste0('kallisto index -i transcripts_',b,'.idx ',d)
quant_command=paste0('kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_',a,'.idx -o kallisto_',dataset$GEOquery,' -b 100 ',
                     dataset$fastqc_loc1,' ',dataset$fastqc_loc2)

#write fileConn for index command
getwd()
fileConn<-file('Nuno_index_command1207.sh')
writeLines(index_command,con=fileConn)
close(fileConn)

#write fileConn for quant command
getwd()
fileConn<-file('Nuno_quant_command1207.sh')
writeLines(quant_command,con=fileConn)
close(fileConn)
#this command file should be put under Jason root folder

#######################
#----Human: we are only concerned about their tissues
# we managed to retrieve a file concerning all the related files
match_human=read.table('E-MTAB-513.sdrf.txt',header=T,stringsAsFactors = F,sep='\t')
head(match_human)
#tidy up the original data
match_human=subset(match_human,select=c('Characteristics.age.','Characteristics.organism.part.',
                                        'Characteristics.sex.','Characteristics.ethnic.group.',
                                        'Comment.LIBRARY_LAYOUT.','Comment.FASTQ_URI.',
                                        'Comment.ENA_RUN.'))

#we get our files from 'Comment.ENA_RUN.'
#during the kallisto running we are able to draw some decriptive analysis figure and think about 
#the ADAR tissue expression visualization stuff...
library(readr)
human_loc=read_lines('human_loc.txt')
human_loc=data.frame(human_loc, filelocation=paste0('/share/public2/data/others/dengac2/Data/Nuno/Human/',human_loc))
names(human_loc)=c('loc','filelocation')
#undo factor
human_loc$loc=as.character(human_loc$loc);human_loc$filelocation=as.character(human_loc$filelocation)
#for there being single-end and paired-end mRNA-seq files in the dataset we should let 
# R to decide which to run
#first we'd like to start from paired-end
index=which(nchar(human_loc$loc)==20);index
#num=sapply(as.list(human_loc$loc),nchar)

a=human_loc[which(index%%2==1),]$loc;b=human_loc[which(index%%2==0),]$loc
pair_human=data.frame(a,b)
pair_write=paste(paste0('/share/public2/data/others/dengac2/Data/Nuno/Human/',pair_human$a),
                 paste0('/share/public2/data/others/dengac2/Data/Nuno/Human/',pair_human$b))
pair_write=paste0('kallisto quant -i /share/public2/data/others/dengac2/Genome/transcripts_homo.idx -o kallisto_',str_sub(a,1,9),' -b 100 ',
                 pair_write)

pair_write[1:3]

#save
fileConn<-file('Human_quant_command1208.sh')
writeLines(pair_write,con=fileConn)
close(fileConn)

###################
#David after cat merge
#now we can use the merged file to do the same for Jason folder
#use the previous written function 'fileloc'
#----there is no Pongo pygmaeus & Pan paniscus
dataset=match_david[-which(match_david$species=='Pongo pygmaeus' | match_david$species== 'Pan paniscus'),] 
index=david_loc
#----
library(stringr)
for (i in 1:nrow(dataset)){
  dataset[i,'filelocation']<-fileloc(dataset[i,'folder'],index,'David')
}
head(dataset)

#there are only a few which is paired-end sequenced 
#SRR306779_1.fastq
# SRR306792_1.fastq
# SRR306801_1.fastq
# SRR306812_1.fastq
# SRR306813_1.fastq
# SRR306814_1.fastq
# SRR306815_1.fastq
# SRR306816_1.fastq
# SRR306826_1.fastq
# SRR306840_1.fastq
# SRR306842_1.fastq

#for this files we just need to search for thier species and find proper folder names for them
search_index=list('SRR306779','SRR306792','SRR306801','SRR306812','SRR306813','SRR306814','SRR306815','SRR306816',
                  'SRR306826','SRR306840','SRR306842')
search_return<-function(x,y,z){
  k=y[grepl(x,y[,2]),2]
  p=str_sub(k,3,11)
  q=z[which(z$folder==p),c('folder','authornote','species','tissue')]
  return(q)
}
result=t(as.data.frame(sapply(search_index,search_return,david_loc,dataset)));row.names(result)<-NULL
View(result)
#character(0) means the match is unfound in the dataset (meaning it's of a species we don't have the cooresponding genome)
#if you want to check the whole file, you should replace the 'dataset' with 'match_david'





