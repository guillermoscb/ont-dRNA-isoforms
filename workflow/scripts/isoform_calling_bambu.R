# Load libraries
library(devtools)
library(bambu)
library(ggplot2)


# Initialize input files
sample.bam <- snakemake@input[["mapped_reads"]]

reference.fa <- snakemake@input[["reference"]]

annotations.gtf <- snakemake@input[["annotations"]]


# Preprare annotations files for bambu
bambuAnnotations <- prepareAnnotations(annotations.gtf)


# Create the SummarizedExperiment objet
se <- bambu(reads = sample.bam, annotations = bambuAnnotations, genome = reference.fa)

# Filter by novel transcripts
se.novel = se[mcols(se)$newTxClass != "annotation",]


# Save the Project
saveRDS(bambuAnnotations, snakemake@output[["SummExperiment_rds"]])

writeBambuOutput(se, path = snakemake@output[["SummExperiment_files"]])

writeBambuOutput(se.novel, path = snakemake@output[["novel_transcripts"]])


# Plotting 
annotation.plot <- plotBambu(se, type = "annotation")
ggsave(filename = file.path(snakemake@output[["SummExperiment_plots"]], "annotation.png"), plot = annotation.plot, width = 10, height = 8, dpi = 300)


heatmap.plot <- plotBambu(se, type = "heatmap")
ggsave(filename = file.path(snakemake@output[["SummExperiment_plots"]], "heatmap.png"), plot = heatmap.plot, width = 10, height = 8, dpi = 300)


pca.plot <- plotBambu(se, type = "pca")
ggsave(filename = file.path(snakemake@output[["SummExperiment_plots"]], "pca.png"), plot = pca.plot, width = 10, height = 8, dpi = 300)




