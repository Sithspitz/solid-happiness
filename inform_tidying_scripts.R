## InForm Tidying Scripts ##



# Recursively Write CSV files #
# Based on 'Test3' script from 'experimental_scripts.R'

# 'setwd()' to the directory with files for conversion
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/")

# Create a new CSV export directory
dir.create("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/")

# Get list of files with certain suffix
filelist = list.files(pattern = "*cell_seg_data_summary.txt")

# Read the files in as delimited and export as csv using for loop
## Change the first 'setwd()' to export directory if relevant
### Change the second 'setwd()' back to the directory with files for conversion so the loop works
for (i in 1:length(filelist)){
  input <- filelist[i]
  output <- paste0(gsub("\\.txt$", "", input), ".csv")
  print(paste("Processing the file:", input))
  data = read.delim(input, header = TRUE)   
  setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/")
  write.table(data, file = output, sep=",", col.names=TRUE, row.names=FALSE)
  setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/")
}

# 'setwd()' to the WD you want to continue in
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/R_wd/solid-happiness/")



# Combining CSV files into one/sample #

# 'setwd()' to the directory with files for conversion
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/")

# Define the 'multMerge' function
multMerge = function(mypath){
  filenames = list.files(path = mypath, full.names = TRUE)
  datalist = lapply(filenames, 
                    function(x){read.csv(file = x,
                                         header = TRUE,
                                         stringsAsFactors = FALSE)})
  Reduce(function(x,y) {merge(x, y, all = TRUE)}, datalist)
}

# Run the 'multMerge' function in current WD
merge1 <- multMerge("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/")

# Tidying up the columns 
del1 <- merge1[, -c(1, 5)]
del2 <- del1[, -c(5:36)]

# Create and export to the 'tidy' directory
## Name the 'write.csv' file as Sample_Total_Tidy.csv format
dir.create("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/Tidy")

write.csv(del2, file = "L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/Tidy/S349104_Total_Tidy.csv"
          , row.names = F)



# Getting the total numbers of phenotype data per sample #

# Set WD
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/Tidy")

# Re-load the Sample_Total_Tidy.csv file
sum_base <- read.csv("S349104_Total_Tidy.csv")

# Subsetting the total numbers for each ROI
sub_all <- sum_base[sum_base$Tissue.Category == "All", ]

# Subsetting for each different phenotype category
s_all <- sub_all[sub_all$Phenotype == "All", ]
s_artefact <- sub_all[sub_all$Phenotype == "Artefact", ]
s_other <- sub_all[sub_all$Phenotype == "Other", ]
s_rorgt <- sub_all[sub_all$Phenotype == "RORgT", ]

# Calculating totals for each phenotype
all <- sum(s_all$Total.Cells)
artefact <- sum(s_artefact$Total.Cells)
other <- sum(s_other$Total.Cells)
rorgt <- sum(s_rorgt$Total.Cells)

# Bind these into a table
Sample_Totals <- data.frame(RORgT = rorgt, Other = other, Artefact = artefact, All = all)

# Export as a CSV to 'Tidy' directory
## Change the name to 'Sample_Phenotype_Totals.csv' format
write.csv(Sample_Totals, file = "L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/CSV/Tidy/S349104_Phenotype_Totals.csv"
          , row.names = F)


