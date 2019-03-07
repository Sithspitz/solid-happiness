## Analysis Scripts ##



# Creating Violin Plots #
# Just using the data for all MT vs all WT for TRACERx at the moment to develop

# setwd
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/analysis/all_mt_vs_wt")

# Load ggplot2, scales and ggpmisc
library(ggplot2)
library(scales)
library(ggpubr)

# Import CSV created in excel
all_mt_vs_wt <- read.csv("all_mt_vs_wt.csv")

# Re-order the x axis 'WT' and 'MT' from the defult alphabetised
all_mt_vs_wt$mutation <- factor(all_mt_vs_wt$mutation, levels = c("WT", "MT"))

# Violin Plot
## Change the p value - should be a way of automating this but not got time now
plot1 <- ggplot(all_mt_vs_wt, aes(mutation, rorgt)) + geom_violin(trim = F, scale = "count", draw_quantiles = c(0.25, 0.5, 0.75)) + 
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x), 
                labels = trans_format("log10", math_format(10^.x))) + theme_bw() +
  ggtitle("RORγT Lymphocyte Expression in Mutational Subtypes of NSCLC") + theme(plot.title = element_text(hjust = 0.5))

plot2 <- plot1 + xlab("Mutational Subtype") + ylab("Number of RORγT Positive Cells/10,000 Cells") +
   geom_dotplot(binaxis = "y", stackdir = "center", dotsize = 0.5, color = "Black", fill = "Black") +
  annotate("text", label = "p = 0.0149", x = 2.4, y = 0.22, size = 4)
plot2



# Mann-Whitney U Test#

# Import CSV created in excel
## Or use the same dataframe from previous
all_mt_vs_wt <- read.csv("all_mt_vs_wt.csv")

# Subsetting dependent on if WT or MT
s_wt <- all_mt_vs_wt[all_mt_vs_wt$mutation == "WT", ]
s_mt <- all_mt_vs_wt[all_mt_vs_wt$mutation == "MT", ]

wt_rorgt <- s_wt$rorgt
mt_rorgt <- s_mt$rorgt

# Running the Mann-Whitney U Test ('wilcox.test')

result <- wilcox.test(wt_rorgt, mt_rorgt)
result
