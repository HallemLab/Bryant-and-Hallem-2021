# Strongyloides Codon Adapter
Preprocessing and analysis related to the *Strongyloides* Codon Adapter app, a web-based Shiny app for automatic codon optimzation and analysis based on *Strongyloides* codon usage.  

## Table of Contents  
1. [General Information](#general-information)
2. [App Preprocessing](#app-preprocessing)
3. [Analysis Code](#analysis-code)
4. [References](#references)
5. [Sources](#sources)
6. [License](#license)
7. [Authors](#authors)

## General Information
This repository contains the preprocessing scripts for generating necessary inputs for the *Strongloides* Codon Adapter app. It also contains analysis code used to generate results discussed in Bryant and Hallem (2021). 

## App Preprocessing
This subfolder contains preprocessing scripts for the *Strongylodies* Codon Adapter App. Specifically, the code calculats codon usage rules for both *Strongyloides* and *C. elegans* based on previously published codon count data. For *Strongyloides*, codon occurrence values are from highly expressed S. ratti transcripts [1]. For *C. elegans*, values are from genes with the highest bias toward translationally optimal codons [2].
  
## Analysis Code  
This subfolder contains  scripts (in an RMarkdown file) that generate analyses and plots included in Bryant and Hallem (2021). Specifically, these analyses seek to assess genome-wide codon bias patterns in *Strongyloides* species versus *C. elegans.* In brief, FASTA files containing all coding sequences (CDS) for *S. stercoralis*, *S. ratti*, *S. papillosus*, *S. venezuelensis*, and *C. elegans* were downloaded from Wormbase ParaSite (WBPS15) and analyzed using the *Strongyloides* Codon Adapter app. Results are located in the Data folder. Within the RMarkdown file, distributions of GC ratio and codon adaptation index values across species are plotted and statistically compared [3,4]. Then, results for each species are filtered to identify the following 6 functional subsets for each species: 2% with highest and lowest *Str*-CAI values, 2% with highest and lowest GC ratio, and 2% with highest and lowest *Ce*-CAI values. GO analyses of functional subsets are performed using the gprofiler2 package v0.1.9, with a false discovery rate (FDR)-corrected p-value < 0.05. Commonly enriched GO terms in each subset are defined as GO terms that were enriched in all *Strongyloides* species with an FDR-corrected p-value of < 0.001.
            
## References
1. [Mitreva *et al* (2006). Codon usage patterns in Nematoda: analysis based on over 25 million codons in thirty-two species. *Genome Biology* 7: R75](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1779591/). 
2. [Sharp and Bradnam (1997). Appendix 3: Codon Usage in *C. elegans*. In: *C. elegans* II. 2nd edition; Eds: Riddle, Blumenthal, Meyer *et al*. Cold Spring Harbor Laboratory Press.](https://www.ncbi.nlm.nih.gov/books/NBK20194/).
3. [Sharp and Li (1987). The Codon Adaptation Index: a measure of directional synonymous codon usage bias, and its potential applications. *Nucleic Acids Research* 15: 1281-95](https://pubmed.ncbi.nlm.nih.gov/3547335/). 
4. [Jansen *et al* (2003). Revisiting the codon adaptation index from a whole-genome perspective: analyzing the relationship between gene expression and codon occurrence in yeast using a variety of models. *Nucleic Acids Research* 31: 2242-51](http://www.ncbi.nlm.nih.gov/pubmed/12682375). 

## Sources  
* [Shiny](https://shiny.rstudio.com/) - UI framework
* [WormbaseParasite](https://parasite.wormbase.org/index.html) - GeneIDs and cDNA sequences
* [Seqinr](https://www.rdocumentation.org/packages/seqinr/versions/3.6-1) - Utilities for calculating Codon Adaptation Index
* Codon Usage Patterns:  
  - *Strongyloides spp*: [Mitreva *et al* 2006](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1779591/)
  - *C. elegans*: [Sharp and Bradnam, 1997](https://www.ncbi.nlm.nih.gov/books/NBK20194/)

## License  
This project is licensed under the MIT License. 

## Authors  
* [Astra Bryant, PhD](https://github.com/astrasb)
* Elissa Hallem, PhD
