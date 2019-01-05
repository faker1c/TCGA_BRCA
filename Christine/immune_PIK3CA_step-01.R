if(F){
  library(readxl)
  pan_immune <- read_excel("./raw_data/Pan Immune Feature Matrix of Immune Characteristics.xlsx")
  brca_im <- pan_immune[pan_immune$`TCGA Study`=="BRCA",]
  brca_phe <- read.delim("./raw_data/TCGA-BRCA.GDC_phenotype.tsv.gz", stringsAsFactors=FALSE)
  
  ###提取需要的表型信息
  #表型和免疫共有患者1087个
  phe <- brca_phe[brca_phe$sample_type.samples == "Primary Tumor", ]
  phe$ID <- substr(phe$submitter_id.samples, 1,12)
  phe <- phe[!duplicated(phe$ID),]
  rownames(phe) <- phe$ID
  phe <- phe[brca_im$`TCGA Participant Barcode`,]
  
  ##合并表型与免疫信息
  brca_phe_im <- merge(brca_im, phe, by.x = "TCGA Participant Barcode", by.y = "ID")
  
  save(brca_phe_im, file = "./Rdata/phe_immune.Rdata")
  
  
  
  
  
}
load(file = "./Rdata/phe_immune.Rdata")
#表型和免疫共有患者1087个
brca_phe_im[1:4,1:8]
library(pheatmap)
grep('Macro',colnames(brca_phe_im))
dat=brca_phe_im[,5:64]
dat=apply(dat,2,as.numeric)
pheatmap(dat,show_rownames = F,show_colnames = F) 
dat=scale(dat)
dat[dat>2]=2
dat[dat< -2] = -2 
pheatmap(dat,show_rownames = F,show_colnames = F) 
## 可以看到这些免疫指标分成3类！
im_group=as.data.frame(cutree(hclust(dist(t(dat))),3))
