library(clusterProfiler)
df<-read.csv("tns/MYB_id.txt",header=F,stringsAsFactors = F)
head(df)
gene_select<-df$V1
go_rich <- enricher(gene = gene_select,
                    TERM2GENE = go_anno[c('term', 'gene')], 
                    TERM2NAME = go_anno[c('term', 'Description')], 
                    pvalueCutoff = 0.05, 
                    pAdjustMethod = 'BH', 
                    qvalueCutoff = 0.05)

go_rich_result<-merge(go_rich@result,
                      go_class[c('ID','Ontology')],
                      by="ID")
go_rich@result<-go_rich_result
dotplot(go_rich)+
  facet_grid(Ontology~.,scale="free")
barplot(go_rich,split="Ontology")+
  facet_grid(Ontology~.,scale="free")