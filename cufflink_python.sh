#!/bin/sh
cd /share/public2/data/others/dengac2/cufflinks

i=$(more cufflinks_index.txt)
#print by lines
for var in $i;do echo $var;done > species_fpkmloc.txt

python << END
import re
with open('./species_fpkmloc.txt') as f:
        content=f.readlines()
content = [x.strip() for x in content]
contentTrim=[x[2:len(x)] for x in content]
contentSplit=[x.split('/')[0:2] for x in contentTrim]
print '\n'.join(['\t'.join(i) for i in contentSplit])
with open('species_Splitloc.txt','w') as file:
        file.writelines('\t'.join(i) + '\n' for i in contentSplit)
END

paste  cufflinks_value.txt species_Splitloc.txt > cuff_merge.txt
echo The output are stored in the cuff_merge.txt file
