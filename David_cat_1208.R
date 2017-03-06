#David cat files 
#There are files for the same sample and needs to be merged
#However we don't need to worry about the expression value because it will be normalized 
#by kallisto automatically

fileloc_0<-function(x,y,z){
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
    cat('cat ')
    file_loc=gsub('.sra','.fastq',file_loc)
    str_sub(file_loc,47,66)<-''
    cat(paste(file_loc[-1]),'>>',file_loc[1],'\n\n')
    cat('rm ',paste(file_loc[-1]),'\n\n')
  }
  return(file_loc[1])
}

#----
dataset=match_david
index=david_loc
#----
sink('David_cat_file.sh')
for (i in 1:nrow(dataset)){
  dataset[i,'filelocation']<-fileloc_0(dataset[i,'folder'],index,'David')
}
sink()