Pome_GO_and_KEGG_enricher

###### 参考文章
http://blog.sciencenet.cn/blog-3406804-1213409.html

###### 遇到的问题

```enricher()```函数中```minGSSize```和```maxGSSize```参数分别起到什么作用呢？

###### KEGG 富集遇到的问题

使用挑选出来的MYB这些蛋白id不指定```universe```这个参数的时候一直遇到

```
No gene set have size > 10 ...
--> return NULL...
```

```
universe_gene<-pathway2gene[!duplicated(pathway2gene$gene),]$gene
```
用```universe_gene```作为```universe```的输入，随机选择100个id,p/q value都设置为1是可以得到结果的，
不太明白。。。。。。

