#!/bin/bash

set -eu

INPUT=$1

# Generate manifests
echo "Reading sample accession to read identifier mappings!"
while read -r line;
do
    # Split line on comma into simple accession and read identifier
    IFS=',' read -a myarray <<<  $line
    sample_accession=${myarray[0]}
    read_identifier=${myarray[1]}

# Create a manifest
FILE=${sample_accession}.manifest.txt
cat <<END > $FILE
STUDY PRJXXX
SAMPLE ${sample_accession}
NAME ${read_identifier}
PLATFORM ILLUMINA
INSTRUMENT Illumina Genome Analyzer II
INSERT_SIZE 200
LIBRARY_SOURCE GENOMIC
LIBRARY_SELECTION RANDOM
LIBRARY_STRATEGY WGS
FASTQ ${read_identifier}_1.fastq.gz
FASTQ ${read_identifier}_2.fastq.gz
END

done < $INPUT

set +eu
