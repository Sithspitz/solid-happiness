## InForm Tidying Script For Spatial Phenotyping ##
# This script was created using LTX001 but should be changed for each tumour


# Summary of subsets numbers by Tissue Category #

library(ggplot2)
library(ggpubr)
library(scales)
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/LTX001/Export/CSV/Tidy/")
total <- read.csv("LTX001_Total_Tidy.csv")

# Subsetting the total numbers by ROI
# Change for each sample
sub_all <- total[total$Tissue.Category == "All", ]
sub_lymphocyte_agg <- total[total$Tissue.Category == "Lymphocyte Aggregates", ]
sub_necrosis <- total[total$Tissue.Category == "Necrosis", ]
sub_stroma <- total[total$Tissue.Category == "Stroma", ]
sub_tumour <- total[total$Tissue.Category == "Tumour 1", ]
sub_white <- total[total$Tissue.Category == "White Space", ]

# Subsetting for each different phenotype category
# Change for each sample
s_all_all <- sub_all[sub_all$Phenotype == "All", ]
s_all_artefact <- sub_all[sub_all$Phenotype == "Artefact", ]
s_all_other <- sub_all[sub_all$Phenotype == "Other", ]
s_all_rorgt <- sub_all[sub_all$Phenotype == "RORgT", ]

s_lympho_all <- sub_lymphocyte_agg[sub_lymphocyte_agg$Phenotype == "All", ]
s_lympho_artefact <- sub_lymphocyte_agg[sub_lymphocyte_agg$Phenotype == "Artefact", ]
s_lympho_other <- sub_lymphocyte_agg[sub_lymphocyte_agg$Phenotype == "Other", ]
s_lympho_rorgt <- sub_lymphocyte_agg[sub_lymphocyte_agg$Phenotype == "RORgT", ]

s_necrosis_all <- sub_necrosis[sub_necrosis$Phenotype == "All", ]
s_necrosis_artefact <- sub_necrosis[sub_necrosis$Phenotype == "Artefact", ]
s_necrosis_other <- sub_necrosis[sub_necrosis$Phenotype == "Other", ]
s_necrosis_rorgt <- sub_necrosis[sub_necrosis$Phenotype == "RORgT", ]

s_stroma_all <- sub_stroma[sub_stroma$Phenotype == "All", ]
s_stroma_artefact <- sub_stroma[sub_stroma$Phenotype == "Artefact", ]
s_stroma_other <- sub_stroma[sub_stroma$Phenotype == "Other", ]
s_stroma_rorgt <- sub_stroma[sub_stroma$Phenotype == "RORgT", ]

s_tumour_all <- sub_tumour[sub_tumour$Phenotype == "All", ]
s_tumour_artefact <- sub_tumour[sub_tumour$Phenotype == "Artefact", ]
s_tumour_other <- sub_tumour[sub_tumour$Phenotype == "Other", ]
s_tumour_rorgt <- sub_tumour[sub_tumour$Phenotype == "RORgT", ]

s_white_all <- sub_white[sub_white$Phenotype == "All", ]
s_white_artefact <- sub_white[sub_white$Phenotype == "Artefact", ]
s_white_other <- sub_white[sub_white$Phenotype == "Other", ]
s_white_rorgt <- sub_white[sub_white$Phenotype == "RORgT", ]

# Calculating Totals for each Phenotype
all_all <- sum(s_all_all$Total.Cells)
all_artefact <- sum(s_all_artefact$Total.Cells)
all_other <- sum(s_all_other$Total.Cells)
all_rorgt <- sum(s_all_rorgt$Total.Cells)

lympho_all <- sum(s_lympho_all$Total.Cells)
lympho_artefact <- sum(s_lympho_artefact$Total.Cells)
lympho_other <- sum(s_lympho_other$Total.Cells)
lympho_rorgt <- sum(s_lympho_rorgt$Total.Cells)

necrosis_all <- sum(s_necrosis_all$Total.Cells)
necrosis_artefact <- sum(s_necrosis_artefact$Total.Cells)
necrosis_other <- sum(s_necrosis_other$Total.Cells)
necrosis_rorgt <- sum(s_necrosis_rorgt$Total.Cells)

stroma_all <- sum(s_stroma_all$Total.Cells)
stroma_artefact <- sum(s_stroma_artefact$Total.Cells)
stroma_other <- sum(s_stroma_other$Total.Cells)
stroma_rorgt <- sum(s_stroma_rorgt$Total.Cells)

tumour_all <- sum(s_tumour_all$Total.Cells)
tumour_artefact <- sum(s_tumour_artefact$Total.Cells)
tumour_other <- sum(s_tumour_other$Total.Cells)
tumour_rorgt <- sum(s_tumour_rorgt$Total.Cells)

white_all <- sum(s_white_all$Total.Cells)
white_artefact <- sum(s_white_artefact$Total.Cells)
white_other <- sum(s_white_other$Total.Cells)
white_rorgt <- sum(s_white_rorgt$Total.Cells)

# Creating A Data Frame
all_df <- data.frame(ROI = "Total", All = all_all, Artefact = all_artefact, Other = all_other, RORgT = all_rorgt)
lymph_df <-data.frame(ROI = "Lymphocyte Aggregates", All = lympho_all, Artefact = lympho_artefact, Other = lympho_other, RORgT = lympho_rorgt)
necrosis_df <-data.frame(ROI = "Necrosis", All = necrosis_all, Artefact = necrosis_artefact, Other = necrosis_other, RORgT = necrosis_rorgt)
stroma_df <- data.frame(ROI = "Stroma", All = stroma_all, Artefact = stroma_artefact, Other = stroma_other, RORgT = stroma_rorgt)
tumour_df <- data.frame(ROI = "Tumour", All = tumour_all, Artefact = tumour_artefact, Other = tumour_other, RORgT = tumour_rorgt)
white_df <- data.frame(ROI = "White Space", All = white_all, Artefact = white_artefact, Other = white_other, RORgT = white_rorgt)

roi_totals <- rbind(all_df, tumour_df, stroma_df, lymph_df, necrosis_df, white_df)

# Export as a CSV to 'Tidy' directory
## Change the name to 'Sample_ROI_Totals.csv' format
write.csv(roi_totals, file = "L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/LTX001/Export/CSV/Tidy/LTX001_ROI_Totals.csv"
          , row.names = F)



# Calculated Number of RORgT Postive Cells/10,000 Cells # 

Tidy_ROI <- read.csv("LTX001_ROI_Totals.csv")

# Calculate The Quotient
## Firstly Get The Total Number of Cells (aka: "Other" + "RORgT" columns)
### Then divide this value by 10,000 to get the "quotient"
quotient <- Tidy_ROI[1, ]
quotient <- sum(quotient$Other, quotient$RORgT)
quotient <- quotient/10000

# Calculate The Number of RORgT Positive Cells/10,000 Using The "quotient"
roi_names <- c("Total", "Tumour", "Stroma", "Lymphocyte Aggregates", "Necrosis", "White Space")
ROI_per_10k <- data.frame(ROI = roi_names, RORgT_Positive_Cells_per_10k_Cells =  Tidy_ROI$RORgT/quotient)

# Export as a CSV to 'Tidy' directory
## Change the name to 'Sample_ROI_Prevalence.csv' format
write.csv(ROI_per_10k, file = "L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/LTX001/Export/CSV/Tidy/LTX001_ROI_Prevalence.csv"
          , row.names = F)



# Quick Summmary Dotplot #

# Import and Specifiying Order of Groups
ROI_prev <- read.csv("LTX001_ROI_Prevalence.csv")
ROI_prev$ROI <- factor(ROI_prev$ROI, levels = c("Lymphocyte Aggregates", "Tumour", "Stroma", "Total", "Necrosis", "White Space"))

# Dot Plotting, Stats and Start Export
cairo_pdf("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/RORgT_Lymphocyte_Quant_060219/LTX001/Export/CSV/Tidy/LTX001_ROI_Prevalence.pdf")
dot_1 <- ggplot(ROI_prev, aes(x = ROI, y = RORgT_Positive_Cells_per_10k_Cells)) +
  geom_dotplot(binaxis = "y", stackdir = "center", dotsize = 0.5, color = "Black", fill = "Black") +
  labs(x = "Segmented ROI", y = "Number of ROR\u03B3T Positive Cells/10,000 Cells") +
  theme_bw() +
  theme(axis.text = element_text(size = 8)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.position = "none") + 
  ggtitle("ROR\u03B3T Lymphocyte Expression in LTX001 ROIs") +
  theme(plot.title = element_text(hjust = 0.5))

# View plot and save
dot_1
dev.off()



# If I need to change to a log axis then use the below #
# scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),labels = trans_format("log10", math_format(10^.x)))
