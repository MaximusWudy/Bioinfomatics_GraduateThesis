################################
# ADAR 1,2,3 Draw the Plot
# Author: Ancheng Deng Date:2016/12/13
################################

#now we should have cow_ADAR, mouse_ADAR, rat_ADAR, rhesus_ADAR, human_ADAR and chicken_ADAR
#the next step would be to consider ADAR1/2/3 expression seperately and make a 
#matrix concerning each species (total 6) and their tissues --> matrix 
#and then draw the heatmap plot

#----now we have ADAR average TPM for cow, mouse, rat, rhesus, chieken, and human!
#----with file names average_human, average_mouse ...
#first check with how large a matrix can we make? Species (6) and tissues (?)
rownames(average_chicken)
#chicken: 
#liver  muscle  kidney  testes  brain   skm lung    heart   colon   spleen
rownames(average_cow)
#cow:
#liver          kidney  testes  brain   skm lung    heart   colon   spleen
rownames(average_human)
#!!!!you shoud change the 'testis' to 'testes' in order to use grepl afterwards!!!
rownames(average_human)[8]<-'ERR030873_testes_m'
#human
#liver  muscle  kidney  testis  brain       lung    heart   colon           
#adrenal ovary   adipose    breast  lymphnode  leukocyte   thyroid prostate
rownames(average_mouse)
#mouse
#liver  muscle  kidney  testes  brain   skm lung    heart   colon   spleen
rownames(average_rat)
#liver          kidney  testes  brain   skm lung    heart   colon   spleen
rownames(average_rhesus)
#liver          kidney  testes  brain   skm lung    heart   colon   spleen
#prefrontalcortex

#Summary: tissue(7)--liver kidney testes brain lung heart colon; 5/6--spleen skm
#write a function to choose rows
tissueRowMaking<-function(tissue,average_ADAR){
    ADAR_name=rownames(average_ADAR)[grepl(tissue,rownames(average_ADAR))]
    return(ADAR_name[1]) #on the first trial, only return with the first representative
}

tissueRowMaking_average<-function(average_ADAR){
row_human=sapply(c('liver','kidney','testes','brain','lung','heart','colon'),tissueRowMaking,average_ADAR)
return(row_human)
}


matrix_dist=cbind(tissueRowMaking_average(average_human),tissueRowMaking_average(average_mouse),tissueRowMaking_average(average_rat),
                  tissueRowMaking_average(average_cow),tissueRowMaking_average(average_rhesus),tissueRowMaking_average(average_chicken))
colnames(matrix_dist)=c('human','mouse','rat','cow','rhesus','chicken')
View(matrix_dist)
#First we'd liek to see ADAR1 matrix
#you should conform all the column names before, because for mouse and rat they have different
#other than the other species

#Due to unknown reason, Gallus gallus do not have ADAR1 transcripts, hence we first use
#ADAR2 for a quick start.

#----first change the mouse and rate ADAR names
colnames(average_mouse)=c('ADARB2','ADARB1','ADAR')
colnames(average_rat)=c('ADARB1','ADAR','ADARB2')

#select_ADAR to merge
select_ADAR='ADAR'
p=average_human[as.character(matrix_dist[,1]),select_ADAR]
q=average_mouse[as.character(matrix_dist[,2]),select_ADAR]
q=average_rat[as.character(matrix_dist[,3]),select_ADAR]
q=average_cow[as.character(matrix_dist[,4]),select_ADAR]
q=average_rhesus[as.character(matrix_dist[,5]),select_ADAR]
q=average_chicken[as.character(matrix_dist[,6]),select_ADAR]
#!! use cbind every time
p=cbind(p,q)

colnames(p)=colnames(matrix_dist)
row.names(p)=row.names(matrix_dist)
View(p)#here is the ADARB1 expression matrix!

#save
write.table(p,file='ADAR_expression_6times7_1214.txt',sep='\t')

#----draw the heatmap----
library(gplots);library(RColorBrewer)
#create a own color palette from red to green
my_pallette<-colorRampPalette(c('red','yellow','green'))(n=299)
#(optional) define the color breaks manually for a 'skewed' color transition
col_breaks=c(seq(-1,0,length=100),seq(0.01,0.8,length=100),seq(0.81,1,length=100))

#----png image
#from trial, I think the value should be scaled by species
p=scale(p)#scale the columns (species)
png('Heatmap for ADAR 1214.png',width=5*300,height=5*300,res=300,pointsize=8)
heatmap.2(p,cellnote=round(p,2),main="Heatmap for ADAR Expression",notecol="black",
          density.info = "none",trace="none",margins=c(12,9),col=my_pallette,
          breaks=col_breaks,dendrogram="row",Colv="NA")
dev.off()

#----ADARB2


#----example code
# heatmap.2(mat_data,
#           cellnote = mat_data,  # same data set for cell labels
#           main = "Correlation", # heat map title
#           notecol="black",      # change font color of cell labels to black
#           density.info="none",  # turns off density plot inside color legend
#           trace="none",         # turns off trace lines inside the heat map
#           margins =c(12,9),     # widens margins around plot
#           col=my_palette,       # use on color palette defined earlier
#           breaks=col_breaks,    # enable color transition at specified limits
#           dendrogram="row",     # only draw a row dendrogram
#           Colv="NA")            # turn off column clustering


