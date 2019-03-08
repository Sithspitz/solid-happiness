## Analysis Script ##


# Change wd and load packages
setwd()

library(ggpubr)
library(ggplot2)
library(scales)


# Mann-Whitney U Test #

# Import CSV created in excel
mt_vs_wt_data <- read.csv("kras_vs_wt.csv")

# Subsetting dependent on if WT or MT
s_wt <- mt_vs_wt_data[mt_vs_wt_data$mutation == "WT", ]
s_mt <- mt_vs_wt_data[mt_vs_wt_data$mutation == "KRAS MT", ]

wt_rorgt <- s_wt$rorgt
mt_rorgt <- s_mt$rorgt

# Running the Mann-Whitney U Test ('wilcox.test')
stat_result <- wilcox.test(wt_rorgt, mt_rorgt)
stat_result
pVal_1 <- wilcox.test(wt_rorgt, mt_rorgt)$p.value
pVal_2 <- format(round(pVal_1, 4), nsmall = 4)
pVal_3 <- paste("p = ", pVal_2, sep = "")


# Violin Plot #

# Violin plot fill colours
cbcols <- c("WT" = "#0000FF",
            "KRAS MT" = "#FF0000")

# Specifying the order of the groups (vs being alphabetised)
## List of comparisons for 'ggpubr' stats
mt_vs_wt_data$mutation <- factor(mt_vs_wt_data$mutation, levels = 
                                   c("WT", "KRAS MT"))
my_comparisons <- list(c("WT", "KRAS MT"))

# Violin plotting, stats and start export
cairo_pdf("./violin_1.pdf")
violin_1 <- ggplot(mt_vs_wt_data, aes(x = mutation, y = rorgt)) +
  geom_boxplot(alpha = 0.5, width = 0.2) + 
  geom_violin(trim = F, aes(mutation, fill = mutation),
              scale = "width", alpha = 0.6) +
  geom_dotplot(binaxis = "y", stackdir = "center", 
               dotsize = 0.5, color = "Black", fill = "Black") +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_fill_manual(values = cbcols) +
  labs(x = "Mutational Subtype", y = "Number of ROR\u03B3T Positive Cells/10,000 Cells") +
  theme_bw() +
  theme(axis.text = element_text(size = 10)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.position = "none") + 
  ggtitle("ROR\u03B3T Lymphocyte Expression in Mutational Subtypes of NSCLC") +
  theme(plot.title = element_text(hjust = 0.5)) +
  stat_compare_means(comparisons = my_comparisons,
                     label = "p.signif", method = "wilcox.test") +
  annotate("text", label = pVal_3, x = 2.4, y = 0.05, size = 4)

# View plot and save
violin_1
dev.off()

