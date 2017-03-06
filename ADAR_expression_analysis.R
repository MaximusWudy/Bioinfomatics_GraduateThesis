############################
#  ADAR Expression Analysis
#  Author: Ancheng Deng Date:2016/12/19
###########################

#------Nuno/Human-----
#First we'd like to do a example analysis about homo ADAR123 in Nuno data 
#the ADAR gene expression is calculated using Kallisto and 
# only patients using paired end sequencing are calculated to removed technical bias.

# we use the expression file from the dataset
# Summary: in total 16 patients and 32 transcripts for ADAR123
match_ADAR=read.table('ADAR_match_sum.txt',sep=' ',stringsAsFactors =F,header=F)
View(match_ADAR)
homo_paired_exp=read.table('Paired_end_human_ADAR_expression1209.txt',stringsAsFactors = F,header=F)
head(homo_paired_exp)
nrow(homo_paired_exp)/16 #32 transcripts

#----Now sepearate the expression values and create a data frame 
for (i in 1:16) {
  if (i==1){
    k=homo_paired_exp[((i-1)*32+1):(i*32),c(1,5)]
    row.names(k)<-k[,1]
  data=data.frame(t(k));data=data[2,]
  }
  else {
    k=homo_paired_exp[((i-1)*32+1):(i*32),c(1,5)]
    row.names(k)<-k[,1]
    data1=data.frame(t(k));data1=data1[2,]
    data=rbind(data,data1)
  }
}

#remove the original row.names with patientID_tissue_sex
#we should not use the human_loc but the order from the du -ah | grep 'abundance.tsv output
# ./kallisto_ERR030881/abundance.tsv
# ./kallisto_ERR030884/abundance.tsv
# ./kallisto_ERR030886/abundance.tsv
# ./kallisto_ERR030879/abundance.tsv
# ./kallisto_ERR030877/abundance.tsv
# ./kallisto_ERR030876/abundance.tsv
# ./kallisto_ERR030874/abundance.tsv
# ./kallisto_ERR030873/abundance.tsv
# ./kallisto_ERR030887/abundance.tsv
# ./kallisto_ERR030880/abundance.tsv
# ./kallisto_ERR030883/abundance.tsv
# ./kallisto_ERR030872/abundance.tsv
# ./kallisto_ERR030882/abundance.tsv
# ./kallisto_ERR030878/abundance.tsv
# ./kallisto_ERR030875/abundance.tsv
# ./kallisto_ERR030885/abundance.tsv

library(stringr)

tissue_matching<-function(x){
  match_tissue<-match_human[which(match_human$Comment.ENA_RUN.==x),'Characteristics.organism.part.']
  match_tissue<-unique(match_tissue)
  return(match_tissue)
}
#patient_ID
patient_ID=c('ERR030881','ERR030884','ERR030886','ERR030879','ERR030877','ERR030876','ERR030874',
               'ERR030873','ERR030887','ERR030880','ERR030883','ERR030872','ERR030882','ERR030878',
               'ERR030875','ERR030885')


tissue_name=sapply(as.list(patient_ID),tissue_matching)

sex_matching<-function(x){
  match_sex<-match_human[which(match_human$Comment.ENA_RUN.==x),'Characteristics.sex.']
  if (match_sex=='male'){match_sex='m'}
  else if (match_sex=='female'){match_sex='f'}
  else {match_sex='u'}
  match_sex<-unique(match_sex)
  return(match_sex)
}
sex_index=sapply(as.list(patient_ID),sex_matching)

homo_rowname=paste0(patient_ID,'_',tissue_name,'_',sex_index)

row.names(data)=homo_rowname
View(data)
#nice
#barplot

#haeatmap -- human, paired end



#########################
#Jason--mammals 
#The difference between Jason and Nuno/Human is that Jasons datasets contains a lot of 
#animals that first need to be selected by its species--corresponinding genome files.

#in Jason, there are Rhesus; Mouse; Rat; Cow; Chicken (5)
#first we use match_ADAR dataframe to match the species with their specific ADAR transcripts
#
#chicken--> Gallus gallus 
#Cow --> UMD
#Rhesis --> Mmul
#Mouse --> GRCm38    ## Adar
#Homo --> GRCh38     ## Adar
#Rat-->Rnor         ## Adar

#-----
#from the match files choose the specific tissue and their corresponding file location, then use the awk command to output the 
#merged file once and get the correct file order
mouse_rat_Adar=read.table('mouse_rat_Adar_gene1212.txt',sep=' ',header=F,stringsAsFactors = F)
#complete the match_ADAR
match_ADAR<-rbind(match_ADAR,mouse_rat_Adar)
dim(match_ADAR) #99 4
#12/14: now we update the match_ADAR with chicken ADAR annotation
match_ADAR0<-rbind(match_ADAR,data.frame(V1='>ENSGALT00000040721.3',V2='chromosome:Gallus_gallus-5.0:25:1735967:1744372:-1', 
                                         V3='gene:ENSGALG00000021475.4',V4='gene_symbol:ADAR'))
match_ADAR=match_ADAR0

#set working direcotory to sub folder all_kallisto_paired_end
setwd('./all_kallisto_paired_end/')
list.files()
animal_paired_loc=read_lines('gallus_loc1212.txt')
#there being Nuno, Jason and David
animal_ID_nuno=str_sub(animal_paired_loc[1:21],17,26)
nuno_ID=c()
for (i in animal_ID_nuno){
  nuno_id=match_nuno[which(unique(match_nuno$GEOquery)==i),'tissue']
  if(grepl('Chicken',nuno_id)) {nuno_ID=c(nuno_ID,nuno_id)}
}
print(nuno_ID)
#wanings(): for there being paired end, only the first matched file will be used --> command unique is used
# [1] "Chicken_liver_pooled"           "Chicken_heart_pooled"          
# [3] "Chicken_skeletal muscle_pooled" "Chicken_brain_pooled"          
# [5] "Chicken_kidney_pooled"      

#for jason
animal_ID_Jason=str_sub(animal_paired_loc[38:171],18,27)
jason_ID=c()
for (i in animal_ID_Jason){
  jason_id=match_jason[which(unique(match_jason$GEOquery)==i),'tissue']
  if(grepl('chicken',jason_id)) {jason_ID=c(jason_ID,jason_id)}
}
print(jason_ID)

#for David paired files
animal_ID_David=str_sub(animal_paired_loc[172:179],18,26)
david_ID=c()
for (i in animal_ID_David){
  david_id=match_david[which(unique(match_david$folder)==i),c('species','tissue')]
  if(as.character(david_id[1])=='Gallus gallus') {david_ID=c(david_ID,
                                                                   paste0('chicken_',gsub('([[:punct:]])|\\s+','_',
                                                                                                   as.character(david_id[2]))))}
}
print(david_ID)
#None

###################
#----Pipeline----
#Now we should write a function to do this automatically
#given the .tsv location files that we have
#given the match_XXXX files that I've made
#we can write this pipeline to give the correct rownames for each species dataframes

#animal_paired_loc + david_match + nuno_match + jason_match
match_nuno<-unique(match_nuno)

rownames_making<-function(species){
  animal_ID_nuno=str_sub(animal_paired_loc[1:21],17,26)
  nuno_ID=c()
  for (i in animal_ID_nuno){
    index=which(match_nuno$GEOquery==i)
    nuno_id=match_nuno[index,c('species','tissue')]
    if(as.character(nuno_id[1])==species) {nuno_ID=c(nuno_ID,paste(match_nuno[index,'GEOquery'],as.character(nuno_id[2]),sep='_'))}
  }

  animal_ID_Jason=str_sub(animal_paired_loc[38:171],18,27)
  jason_ID=c()
  for (i in animal_ID_Jason){
    index=which(match_jason$GEOquery==i)
    jason_id=match_jason[index,c('species','tissue')]
    if(as.character(jason_id[1])==species) {jason_ID=c(jason_ID,paste(match_jason[index,'GEOquery'],as.character(jason_id[2]),sep='_'))}
  }

  animal_ID_David=str_sub(animal_paired_loc[172:179],18,26)
  david_ID=c()
  for (i in animal_ID_David){
    index=which(match_david$folder==i)
    david_id=match_david[index,c('species','tissue')]
    if(as.character(david_id[1])==species) {david_ID=c(david_ID,
                                                       gsub('([[:punct:]])|\\s+','_',paste0(match_david[index,'GEOquery'],'_',species,'_',as.character(david_id[2]))))}
  }

  animal_ID=c(nuno_ID,jason_ID,david_ID)
  return(animal_ID)
}


#--------------
animal_ID=rownames_making('Gallus gallus')
animal_ID=rownames_making('Macaca mulatta')
animal_ID=rownames_making('Rattus norvegicus')
animal_ID=rownames_making('Mus musculus')
animal_ID=rownames_making('Bos taurus')

#----done!

#----Data frame making
#in this step I used my mac, so the file path would be different
setwd('/Volumes/SUPERPOWER/ZhangLab毕业论文相关/Data Match/all_kallisto_paired_end/')
cow_exp=read.table('cow_value1212.txt',sep='\t',stringsAsFactors = F,header=F)
mouse_exp=read.table('mouse_value1212.txt',sep='\t',stringsAsFactors = F,header=F)
rat_exp=read.table('rat_value1212.txt',sep='\t',stringsAsFactors = F,header=F)
rhesus_exp=read.table('rhesus_value1212.txt',sep='\t',stringsAsFactors = F,header=F)
chicken_exp=read.table('gallus_value1214.txt',sep='\t',stringsAsFactors = F,header=F)#change from 1212 to 1214 (add ADAR)
#cow has 3 ADARS
#mouse --> 26
#rat --> 5
#rhesus --> 9
#chicken --> 7 (previous is 6)

#covert factor dataframe to numeric dataframe
conv_frame<-function(x){
  y<-as.numeric(as.character(x))
  return(y)
}
valueframeMaking<-function(dataset,numoftrans,species){
  numofani=nrow(dataset)/numoftrans
  for (i in 1:numofani) {
    if (i==1){
      k=dataset[((i-1)*numoftrans+1):(i*numoftrans),c(1,5)]
      row.names(k)<-k[,1]
      data=data.frame(t(k));data=data[2,]
    }
    else {
      k=dataset[((i-1)*numoftrans+1):(i*numoftrans),c(1,5)]
      row.names(k)<-k[,1]
      data1=data.frame(t(k));data1=data1[2,]
      data=rbind(data,data1)
    }
  }
    data<-sapply(data,conv_frame)
    row.names(data)=rownames_making(species)
    return(data)
}

cow_ADAR=valueframeMaking(cow_exp,3,'Bos taurus')
mouse_ADAR=valueframeMaking(mouse_exp,26,'Mus musculus')
rat_ADAR=valueframeMaking(rat_exp,5,'Rattus norvegicus')
rhesus_ADAR=valueframeMaking(rhesus_exp,9,'Macaca mulatta')
chicken_ADAR=valueframeMaking(chicken_exp,7,'Gallus gallus')
human_ADAR=data #the first made data object is actually human_ADAR!
#convert character to numerics in human_ADAR
for (i in colnames(human_ADAR)){
    human_ADAR[,i]=conv_frame(human_ADAR[,i])
}
#check classes
apply(human_ADAR,1,class)
#we take ADAR for each species and tissue on the average of corresponding transcripts
#of course first we need to match the column names (transcripts names) with their ADAR symbols
#----take cow for example
colnames(cow_ADAR)
#write a function to merge ADAR, ADARB1 and ADARB2 average
library(stringr)
symbolPairing <- function(exp_matrix){
    for (i in colnames(exp_matrix)){
        gene_symbol=match_ADAR[which(match_ADAR$V1==paste0('>',i)),4]
        if (i == colnames(exp_matrix)[1]){pair=data.frame(i,str_sub(gene_symbol,13,nchar(gene_symbol)))}
        else {pair2=data.frame(i,str_sub(gene_symbol,13,nchar(gene_symbol)));pair=rbind(pair,pair2)}
    }
    colnames(pair)=c('transcript','symbol')
    return(pair)
}
cow_pair=symbolPairing(cow_ADAR)
mouse_pair=symbolPairing(mouse_ADAR)
rat_pair=symbolPairing(rat_ADAR)
rhesus_pair=symbolPairing(rhesus_ADAR)
chicken_pair=symbolPairing(chicken_ADAR)
human_pair=symbolPairing(human_ADAR)

ADARaveraging<-function(exp_matrix,exp_pair){
    exp_pair$symbol=as.character(exp_pair$symbol)
    if (identical(unique(exp_pair$symbol),exp_pair$symbol)){average_matrix=exp_matrix;cat('You can just use the original data frame')}
    else{
    for (i in as.character(unique(exp_pair$symbol))){
        select_column<-as.character(exp_pair[which(exp_pair$symbol==i),'transcript'])
        if (i == as.character(unique(exp_pair$symbol))[1]){
            if (length(select_column)==1) {average_matrix=exp_matrix[,select_column]}
              else{  average_matrix=apply(exp_matrix[,select_column],1,mean)}}
        else {
            if (length(select_column)==1) {average_matrix2=exp_matrix[,select_column];average_matrix=cbind(average_matrix,average_matrix2)}
            else{average_matrix2=apply(exp_matrix[,select_column],1,mean);average_matrix=cbind(average_matrix,average_matrix2)}}
        }
    }
    colnames(average_matrix)<-as.character(unique(exp_pair$symbol))
    return(average_matrix)
}

average_cow=ADARaveraging(cow_ADAR,cow_pair)
#average_cow
average_mouse=ADARaveraging(mouse_ADAR,mouse_pair)
average_rat=ADARaveraging(rat_ADAR,rat_pair)
average_rhesus=ADARaveraging(rhesus_ADAR,rhesus_pair)
average_chicken=ADARaveraging(chicken_ADAR,chicken_pair)
average_human=ADARaveraging(human_ADAR,human_pair)
#done!
#now we have ADAR average TPM for cow, mouse, rat, rhesus, chieken, and human!
