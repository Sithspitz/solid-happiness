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

