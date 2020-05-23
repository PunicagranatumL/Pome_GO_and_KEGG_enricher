egg<-read.table("Tunisia_out.emapper.annotations",sep="\t",header=T,fill = T)
egg[egg==""]<-NA
gene2ko <- egg %>%
  dplyr::select(GID = query_name, Ko = KEGG_ko) %>%
  na.omit()
head(gene2ko)
dim(gene2ko)
gene2ko[,2]<-gsub("ko:","",gene2ko[,2])
head(gene2ko)
load(file = "kegg_info.RData")
pathway2gene <- gene2ko %>% left_join(ko2pathway, by = "Ko") %>% 
  dplyr::select(pathway=Pathway,gene=GID) %>%
  na.omit()  
head(pathway2gene)
head(pathway2name)
gene_select
pathway2gene
universe_gene<-pathway2gene[!duplicated(pathway2gene$gene),]$gene
length(universe_gene)
df<-enricher(gene=sample(universe_gene,100),
             universe = universe_gene,
             pvalueCutoff = 1,
             qvalueCutoff = 1,
             pAdjustMethod = "BH",
             TERM2GENE = pathway2gene,
             TERM2NAME = pathway2name)
dotplot(df)
barplot(df)
save(universe_gene,pathway2gene,pathway2name,
     file="Tunisia_KEGG.Rdata")