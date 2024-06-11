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


# Filter by novel transcripts
se.novel.transcripts <- se[mcols(se)$novelTranscript,]
se.novel.transcripts.gtf <- rowRanges(se.novel.transcripts)


# Filter by full-length trancripts
se.novel.flen <- se[assays(se)$fullLengthCounts >= 1,]
se.novel.flen.gtf <- rowRanges(se.novel.flen)


# Save the Project
writeBambuOutput(se, path = snakemake@params[["SummExperiment_output"]])

writeToGTF(se.novel.transcripts.gtf, snakemake@output[["se_novel_transcripts"]])

writeToGTF(se.novel.flen.gtf, snakemake@output[["se_novel_flen"]])
