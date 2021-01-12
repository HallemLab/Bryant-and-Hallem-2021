# This script generates lookup tables for optimal codons in different
# worm species, including:
# *Strongyloides spp.*  
# *C. elegans*
# *Pristionchus pacificus*
# *Brugia spp*

# First, species-specific counts of codon occurances are used to calculate 
# the frequency each codon "i" encodes amino acid "AA"
# These values are passed to the quantification of relative adaptiveness, 
# the first step for calculating codon adaptation index.
# These relative adaptiveness values are filtered to find the codon with the 
# highest value per amino acid, and those "optimal" codons are saved in a .csv
# file for use in the Wild Worm Codon Adaptor App

library(tidyverse)
library(magrittr)
library(seqinr)


# Strongyloides ----
# Load S. ratti count data
# Source: Mitreva et al 2006; counts taken from 50 most common expressed sequence tag clusters (putative genes)
Sr.dat <- read_csv('../Data/Sr_top50_usage_counts.csv',
                   quote = "",
                   col_types = 'fcd')

Sr.codon.freq <- Sr.dat %>%
    dplyr::mutate(AA = seqinr::a(AA)) %>%
    dplyr::arrange(AA, Codon) %>%
    dplyr::mutate(AA = factor(AA)) %>%
    group_by(AA) %>%
    dplyr::mutate (Frequency = Count / sum(Count)) %>%
    dplyr::mutate (Frequency = Frequency *100) %>%
    dplyr::mutate (Frequency = signif(Frequency, digits = 9)) %>%
    dplyr::rename("Sr_optimal" = "Frequency") %>%
    dplyr::select(!Count)

# C. elegans ----
# Load C. elegans count data
# Soruce: Sharp and Bradnam, 1997; https://www.ncbi.nlm.nih.gov/books/NBK20194/
Ce.dat <- read_csv('../Data/Ce_usage_counts.csv', 
                   quote = "", 
                   col_types = 'ccd'
)

Ce.codon.freq <- Ce.dat %>%
    dplyr::mutate(AA = seqinr::a(AA)) %>%
    dplyr::arrange(AA, Codon) %>%
    dplyr::mutate(AA = factor(AA)) %>%
    group_by(AA) %>%
    dplyr::mutate (Frequency = Count / sum(Count)) %>%
    dplyr::mutate (Frequency = Frequency *100) %>%
    dplyr::mutate (Frequency = signif(Frequency, digits = 9)) %>%
    dplyr::rename("Ce_optimal" = "Frequency") %>%
    dplyr::select(!Count)

# B. malayi ----
# Load B. malayi count data
# Source: http://big.icp.ucl.ac.be/~opperd/private/C_U_B_%20Table.html
Bm.dat <- read_csv('../Data/Bm_optimal_usage_counts.csv', 
                   quote = "", 
                   col_types = 'ccd'
)

Bm.codon.freq <- Bm.dat %>%
    dplyr::mutate(AA = seqinr::a(AA)) %>%
    dplyr::arrange(AA, Codon) %>%
    dplyr::mutate(AA = factor(AA)) %>%
    group_by(AA) %>%
    dplyr::mutate (Frequency = Count / sum(Count)) %>%
    dplyr::mutate (Frequency = Frequency *100) %>%
    dplyr::mutate (Frequency = signif(Frequency, digits = 9)) %>%
    dplyr::rename("Bm_optimal" = "Frequency") %>%
    dplyr::select(!Count)


# Merge species ----
codon_usage_chart <- dplyr::full_join(Sr.codon.freq, 
                                      Ce.codon.freq,
                                      by = c("AA", "Codon") 
)%>%
    dplyr::full_join(Bm.codon.freq,
                     by = c("AA", "Codon"))

# Generate Relative Adaptiveness Charts for each species ----
## Calculate the relative adaptiveness of each codon for each species. 
## Note: this computation is done by the Strongyloides
## Codon Adapter App - it is replicated here so users can easily access the 
## relative adaptiveness values.
Sr_codonChart <- Sr.codon.freq %>%
    dplyr::select(AA, Codon, Sr_optimal) %>%
    dplyr::mutate(Codon = tolower(Codon)) %>%
    group_by(AA) %>%
    dplyr::mutate (Sr_relAdapt = Sr_optimal / max(Sr_optimal))

Ce_codonChart <- Ce.codon.freq %>%
    dplyr::select(AA, Codon, Ce_optimal) %>%
    dplyr::mutate(Codon = tolower(Codon)) %>%
    group_by(AA) %>%
    dplyr::mutate (Ce_relAdapt = Ce_optimal / max(Ce_optimal))

Bm_codonChart <- Bm.codon.freq %>%
    dplyr::select(AA, Codon, Bm_optimal) %>%
    dplyr::mutate(Codon = tolower(Codon)) %>%
    group_by(AA) %>%
    dplyr::mutate (Bm_relAdapt = Bm_optimal / max(Bm_optimal))

rel_adaptiveness_chart <- dplyr::full_join(Sr_codonChart, Ce_codonChart,
                                      by = c("AA", "Codon")) %>%
    dplyr::full_join(Bm_codonChart, by = c("AA", "Codon")) %>%
    dplyr::mutate(Codon = tolower(Codon))

write_csv(rel_adaptiveness_chart,
          path = "../Outputs/rel_adaptiveness_chart.csv")

# Generate Lookup Tables for each species ----

## For each species, filter the relative adaptiveness chart
## to generate a lookup table with the "optimal" codon

### Strongyloides
Sr_codonLut <- Sr_codonChart %>%
    dplyr::filter(Sr_relAdapt == 1) %>%
    dplyr::select(c(AA, Codon)) %>%
    dplyr::rename(Codon.Sr = Codon) %>%
    ungroup() 

### C. elegans
Ce_codonLut <- Ce_codonChart %>%
    dplyr::filter(Ce_relAdapt == 1) %>%
    dplyr::select(c(AA, Codon)) %>%
    dplyr::rename(Codon.Ce = Codon) %>%
    ungroup() 

### B. malayi 
Bm_codonLut <- Bm_codonChart %>%
    dplyr::filter(Bm_relAdapt == 1) %>%
    dplyr::select(c(AA, Codon)) %>%
    dplyr::rename(Codon.Bm = Codon) %>%
    ungroup() 

### P. pacificus
#### P. pacificus data already comes as a list of the optimal codons
#### Load P. pacificus list of codons used in 3% highly expressed genes
#### Source: Han *et al* 2020 https://www.genetics.org/content/216/4/947
Pp_codonLut <- read_csv('../Data/Pp_optimal_codons.csv', 
                          quote = "", 
                          col_types = 'fc'
)%>%
    dplyr::mutate(Codon = tolower(Codon)) %>%
    dplyr::rename(Codon.Pp = Codon)

codon_lookup_tbl <- dplyr::full_join(Sr_codonLut, Ce_codonLut,
                                      by = "AA") %>%
    dplyr::left_join(Bm_codonLut, by = "AA") %>%
    dplyr::left_join(Pp_codonLut, by = "AA")

write_csv(codon_lookup_tbl,
          path = "../Outputs/codon_lut.csv")
