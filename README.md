# Wild Worm Codon Adapter Preprocessing & Analysis
Preprocessing and analysis related to the Wild Worm Codon Adapter app, a web-based Shiny app for automatic codon optimzation and analysis based on codon usage rules in "wild" non-*Caenorhabditis* nematode species, including: *Strongyloides* species, *Nippostrongylus brasiliensis*, *Brugia malayi*, *Pristionchus pacificus*, as well as *Caenorhabditis elegans*. It also permits codon optimization via user-provided custom optimal codon sets. Furthermore, this tool enables users to perform bulk calculations of codon adaptiveness relative to species-specific codon usage rules.

## Table of Contents  
1. [General Information](#general-information)
2. [App Preprocessing](#app-preprocessing)
3. [Analysis Code](#analysis-code)
4. [Supplemental Files](#supplemental-files)
5. [App Access](#app-access)
6. [Sources](#sources)
7. [License](#license)
8. [Authors](#authors)

## General Information
This repository contains the preprocessing scripts for generating necessary inputs for the Wild Worm Codon Adapter app. It also contains supplemental files and analysis code from Bryant and Hallem (2021). 
## App Preprocessing
This subfolder contains preprocessing scripts for the Wild Worm Codon Adapter App. 

First, the code calculates relative adaptation indeces for all species. For *Strongyloides*, codon occurrence values are from highly expressed S. ratti transcripts [(Mitreva *et al* 2006)](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1779591/). For *C. elegans*, values are from genes with the highest bias toward translationally optimal codons [(Sharp and Bradnam 1997)](https://www.ncbi.nlm.nih.gov/books/NBK20194/). For  *N. brasiliensis*, values are from 10% of genes with highest RNA-seq expression across life stages (expression data downloaded from WormBase ParaSite, see `Nb_gene_expression.Rmd` for script to identify highly expressed genes, fetch coding sequences, and generate codon count data). Codon frequency rates for *B. malayi* and *P. pacificus* are based on codon frequency data from highly expressed genes [Han *et al* 2020](https://www.genetics.org/content/216/4/947). 

The relative adaptiveness values of every possible codon was generated as follows: individual codons were scored by calculating their relative adaptivness: (the frequency that codon "i" encodes amino acid "AA") / (the frequency of the codon most often used for encoding amino acid "AA"). 

Next, optimal codon lookup tables are generated. Optimal codons were defined as the codon with the highest relative adaptiveness value for each amino acid.
  
## Analysis Code  
This subfolder contains scripts (in an RMarkdown file) that generate analyses and plots included in Bryant and Hallem (2021). Specifically, these analyses seek to compare genome-wide codon bias patterns in *Strongyloides* species, *N. brasiliensis*, *B. malayi*, *P. pacificus*, and *C. elegans.* In brief, FASTA files containing all coding sequences (CDS) for all species were downloaded from Wormbase ParaSite (WBPS15) and analyzed using the Wild Worm Codon Adapter app. Results are located in the Data folder. Within the RMarkdown file, distributions of GC ratio and codon adaptation index values across species are plotted and statistically compared [(Sharp and Li 1987](https://pubmed.ncbi.nlm.nih.gov/3547335/) ; [Jansen *et al* 2003)](http://www.ncbi.nlm.nih.gov/pubmed/12682375).  

Then, results are filtered to identify the following 8 functional subsets for each *Strongyloides* species and *C. elegans*: 2% with highest and lowest *Str*-CAI values, 2% with highest and lowest GC ratio, and 2% with highest and lowest *Ce*-CAI values, genes with 2% highest expression in free-living females (based on data from the *Strongyloides* RNA-seq Browser. GO analyses of functional subsets are performed using the gprofiler2 package v0.1.9, with a false discovery rate (FDR)-corrected p-value < 0.05. Commonly enriched GO terms in each subset are defined as GO terms that were enriched in all *Strongyloides* species with an FDR-corrected p-value of < 0.001.

## Supplemental Files 
This subfolder contains supplemental files from Bryant and Hallem (2021). See subfolder README for file details.  

## App Access
To access a stable deployment of the Wild Worm Codon Adapter, please visit: [https://asbryant.shinyapps.io/Wild_Worm_Codon_Adapter/](https://asbryant.shinyapps.io/Wild_Worm_Codon_Adapter/)  

To view full source code for the *Strongyloides* RNAseq Browser, please visit the [app repository](https://github.com/HallemLab/Wild_Worm_Codon_Adapter). 

## Sources  
* [Shiny](https://shiny.rstudio.com/) - UI framework
* [Wormbase ParaSite](https://parasite.wormbase.org/index.html) - GeneIDs and cDNA sequences
* [Seqinr](https://www.rdocumentation.org/packages/seqinr/versions/3.6-1) - Utilities for calculating Codon Adaptation Index
* Codon Usage Patterns:  
  - *Strongyloides spp*: [Mitreva *et al* 2006](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC1779591/)  
  - *Pristionchus spp*: [Han *et al* (2020)](https://www.genetics.org/content/216/4/947)
  - *Brugia malayi*: [Han *et al* (2020)](https://www.genetics.org/content/216/4/947)
  - *Nippostrongylus brasiliensis*: [Wormbase ParaSite](https://parasite.wormbase.org/index.html)  
  - *C. elegans*: [Sharp and Bradnam, 1997](https://www.ncbi.nlm.nih.gov/books/NBK20194/)  
  
## License  
This project is licensed under the MIT License. 

## Authors  
* [Astra Bryant, PhD](https://github.com/astrasb)
* [Elissa Hallem, PhD](https://github.com/ehallem)
