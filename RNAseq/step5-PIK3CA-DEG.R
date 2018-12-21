rm(list = ls())
options(stringsAsFactors = F)
load(file = 'tnbc_paired_exprSet.Rdata')
# https://mp.weixin.qq.com/s/MJLEZPWqzJe4LaKRDtiZQQ
# 挑选出有PIK3CA突变的样本
# 载入下载好的突变信息文件
exprSet[1:4,1:4]
mut <- read.table('../MAF/TCGA-BRCA.mutect2_snv.tsv.gz',
                          header = T,sep = '\t',quote = '')
library(dplyr)
colnames(mut)
mut <- subset(mut,gene=='PIK3CA')
table(mut$effect)
## 取出含有'PIK3CA'信息的行 
PIK3CA_sample <- unique(sort(mut$Sample_ID))
PIK3CA_sample
