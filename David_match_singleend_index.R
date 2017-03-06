##Name: Match the single file index in David data box
##Author: Ancheng Deng 
##Date: 2017/2/16

setwd('/Users/maximus/Dropbox (个人)/本科毕业设计--生物/Data/Data Match/')
david_single_end_index=read.table('single_end_file_index.txt')
david_match=read.table('text_David1206.txt',skip = 4,sep='\t',stringsAsFactors = F)
david_path=read.table('file_match_David1207.txt')

#first we already have 3 index file: david_match, david_path and david_singleend_index
# from SRR --> SRX --> Species names
library(stringr)
david_single_end_index=transform(david_single_end_index,species_name=NA)
SRR=str_sub(david_single_end_index$V1,1, 9)
for (i in 1:length(SRR)){
    a=david_path[grepl(SRR[i],david_path$V2),'V2']
    b=str_sub(a,3,11)
    c=david_match[which(david_match$V2==b),'V4']
    if (length(c)==0){c=NA}
    else {    david_single_end_index[i,'species_name']=c}
}
write.table(david_single_end_index,file='david_single_end_index_20170216.txt',sep = '\t',col.names = T,row.names = F)