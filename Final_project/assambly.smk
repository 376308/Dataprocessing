container: "docker://continuumio/miniconda3:4.4.10"
configfile: "config.yaml"
samples = config["SAMPLES"]

rule run_metaspades:
    input:
        reads=expand(["trimmed/{sample}.1.fastq.gz", "trimmed/{sample}.2.fastq.gz"], sample=samples),
    output:
        contigs="assembly/contigs.fasta",
        scaffolds="assembly/scaffolds.fasta",
        dir=directory("assembly/intermediate_files"),
    benchmark:
        "logs/benchmarks/assembly/spades.txt"
    params:
        # all parameters are optional
        k="auto",
        extra="--only-assembler",
    log:
        "log/spades.log",
    threads: 8
    resources:
        mem_mem=250000,
        time=60 * 24,
    wrapper:
        "v4.6.0/bio/spades/metaspades"

