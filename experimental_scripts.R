# Experimental Script File #
## Looking at combining the export files into data frames in different ways
### Explore with data from S349104 as only 90 files in directory

# Test1
temp = list.files(pattern="*.txt")
myfiles = lapply(temp, read.delim)
# Nahh, would work with csv but need to convert to txt

# Test2
## This is to convert txt to csv combined in a big export file
temp <- list.files(pattern="*cell_seg_data_summary.txt")
temp2 <- read.delim(temp, sep = ",")
write.table(temp, file="L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/R_wd/solid-happiness/test_export.csv",
            sep = ",", col.names = F, row.names = F)
# Am abandoning as think I have an answer

# Test3
# This script works nicely
## Uses a for loop do each csv processing seperately
### Will take this forward as a solution
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/")
filelist = list.files(pattern = "*cell_seg_data_summary.txt")
for (i in 1:length(filelist)){
  input <- filelist[i]
  output <- paste0(gsub("\\.txt$", "", input), ".csv")
  print(paste("Processing the file:", input))
  data = read.delim(input, header = TRUE)   
  setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/R_wd/solid-happiness/Test_Export/")
  write.table(data, file = output, sep=",", col.names=TRUE, row.names=FALSE)
  setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/S349104/Export/")
}
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/R_wd/solid-happiness/")


# Looks like Test3 works well, onto next problem #
# Which is combining all the information into one big data file and tidying it up #

# Test1 script might actually be useful now
temp = list.files(pattern="*.csv")
myfiles = lapply(temp, read.delim)
df1 <- data.frame(myfiles)

# Test4
## Improvement on Test1 and binds all the csv together but in column order
df2 <- list.files(pattern = "*.csv", full.names = T) %>% lapply(read_csv) %>% bind_rows()

# Test 5
## Using the MultiMerge Function
### Works nicely!
multMerge = function(mypath){
  filenames = list.files(path = mypath, full.names = TRUE)
  datalist = lapply(filenames, 
                    function(x){read.csv(file = x,
                                         header = TRUE,
                                         stringsAsFactors = FALSE)})
  Reduce(function(x,y) {merge(x, y, all = sTRUE)}, datalist)
}
df3 <- multMerge(getwd())

# Clean up the unused columns
del1 <- df3[, -c(1, 5)]
del2 <- del1[, -c(5:36)]

## See the final inform_tidying_script for a good version of all of this, not really working here


# Last thing to do is to combine all of them 
