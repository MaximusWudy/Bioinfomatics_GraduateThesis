#read in the metadata with the link to download (human tissue fastq files)
metadata=read.table('Human_tissue_metadata.txt',sep='\t',header = T,stringsAsFactors = F)
link=metadata$Comment.FASTQ_URI.
head(link)
writeLink<-function(link,fileName){
fileConn<-file(fileName)
writeLines(paste0('wget ',link),fileConn)
close(fileConn)
}
writeLink(link,'linktoHumanTissue.txt')