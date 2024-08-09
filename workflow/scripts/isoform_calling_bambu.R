# Load libraries
library(bambu)



# Initialize input files
sample.bam <- snakemake@input[["mapped_reads"]]

reference.fa <- snakemake@input[["reference"]]

annotations.gtf <- snakemake@input[["annotations"]]


# Preprare annotations files for bambu
bambuAnnotations <- prepareAnnotations(annotations.gtf)


# Create the SummarizedExperiment objet
se <- bambu(
  reads = sample.bam, 
  annotations = bambuAnnotations, 
  genome = reference.fa, 
  NDR = snakemake@params[["NDR"]]
)


# Save the Project
writeBambuOutput(se, path = snakemake@params[["SummExperiment_output"]])


# FILTERING TABLE

df <- se@rowRanges@elementMetadata@listData


df_formatted <- data.frame(
  TXNAME = df$TXNAME,
  GENEID = df$GENEID,
  NDR = df$NDR,
  novelGene = df$novelGene,
  novelTranscript = df$novelTranscript,
  txClassDescription = df$txClassDescription,
  readCount = df$readCount,
  relReadCount = df$relReadCount,
  relSubsetCount = df$relSubsetCount,
  txid = df$txid
)


# Print the DataFrame

write.table(
  df_formatted, 
  file = snakemake@output[["ndr_table"]],
  sep = "\t", 
  row.names = FALSE
)
