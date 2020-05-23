library(stringr)
library(dplyr)
egg<-read.table("Tunisia_out.emapper.annotations",sep="\t",header=T,fill = T)
dim(egg)
head(egg)
colnames(egg)
gene_ids <- egg$query_name
eggnog_lines_with_go <- egg$GOs!= ""
eggnog_lines_with_go
eggnog_annoations_go <- str_split(egg[eggnog_lines_with_go,]$GOs, ",")
gene_to_go <- data.frame(gene = rep(gene_ids[eggnog_lines_with_go],
                                    times = sapply(eggnog_annoations_go, length)),
                         term = unlist(eggnog_annoations_go))
head(gene_to_go)
write.table(gene_to_go,file='Tunisia_gene2go.txt',sep="\t",quote=F,row.names = F)

go_class <- read.delim('go_class.txt', header = FALSE, stringsAsFactors = FALSE)
names(go_class) <- c('ID', 'Description', 'Ontology')
head(go_class)
go_anno <- merge(gene_to_go, go_class, by.x="term",by.y = 'ID', all.x = TRUE)
head(go_anno)
dim(go_anno)
write.table(go_anno,file="Tunisia_go_anno.txt",sep="\t",quote=F,row.names = F)