# Load libraries
library(bambu)



# Initialize input files
sample.bam <- snakemake@input[["mapped_reads"]]

reference.fa <- snakemake@input[["reference"]]

annotations.gtf <- snakemake@input[["annotations"]]


# Check if input files exist
if (!file.exists(sample.bam)) stop("Mapped reads file not found: ", sample.bam)
if (!file.exists(reference.fa)) stop("Reference file not found: ", reference.fa)
if (!file.exists(annotations.gtf)) stop("Annotations file not found: ", annotations.gtf)


# Preprare annotations files for bambu
bambuAnnotations <- prepareAnnotations(annotations.gtf)


# Create the SummarizedExperiment objet
se <- bambu(reads = sample.bam, annotations = bambuAnnotations, genome = reference.fa, NDR = snakemake@params[["NDR"]])


# Save the Project
writeBambuOutput(se, path = snakemake@params[["SummExperiment_output"]])

