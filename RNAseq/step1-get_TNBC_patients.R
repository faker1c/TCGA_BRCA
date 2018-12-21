rm(list = ls())
options(stringsAsFactors = F)
a=read.table('TCGA-BRCA.survival.tsv.gz',header = T,sep = '\t')
a=read.table('TCGA-BRCA.GDC_phenotype.tsv.gz',header = T,sep = '\t',quote = '')
(tmp=as.data.frame(colnames(a)))
tmp=a[,grepl('her2',colnames(a))]
table(a$breast_carcinoma_estrogen_receptor_status)
table(a$breast_carcinoma_progesterone_receptor_status)
table(a$lab_proc_her2_neu_immunohistochemistry_receptor_status)
eph=a[,grepl('receptor_status',colnames(a))]
eph=eph[,1:3]
tnbc_s=a[apply(eph,1, function(x) sum(x=='Negative'))==3,1]
tnbc_s
save(tnbc_s,file = 'tnbc_s.Rdata')


