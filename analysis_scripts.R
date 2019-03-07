## Analysis Scripts ##



# Creating Violin Plots #
# Just using the data for all MT vs all WT for TRACERx at the moment to develop

# setwd
setwd("L:/Richard B/Analysis/2019/February 2019/RORgT_IHC_060219/analysis/all_mt_vs_wt")

# Load ggplot2 and plotly
library(ggplot2)

# Import CSV created in excel
all_mt_vs_wt <- read.csv("all_mt_vs_wt.csv")

# Re-order the x axis 'WT' and 'MT' from the defult alphabetised
all_mt_vs_wt$mutation <- factor(all_mt_vs_wt$mutation, levels = c("WT", "MT"))

# Violin Plot
plot1 <- ggplot(all_mt_vs_wt, aes(mutation, rorgt)) + geom_violin(trim = F) +
  scale_y_log10(
    breaks = scales::trans_breaks("log10", function(x) 10^x),
                labels = scales::trans_format("log10", scales::math_format(10^.x))
plot1 + xlab("Mutational Subtype") + ylab("Number of RORγT Positive Cells/10,000 Cells")

