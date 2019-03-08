# My go 1#

# Jack playing around scripts 2 #

library(ggpubr)
library(ggplot2)
library(scales)

raw_data <- read.csv("all_mt_vs_wt.csv")

cbcols <- c("WT" = "#0000FF",
            "MT" = "#FF0000")

my_comparisons <- list(c("WT", "MT"))
raw_data$mutation <- factor(raw_data$mutation, levels = c("WT", "MT"))


pdf("./Test_Export/t1.pdf", height = 6, width = 6)
temp_plot <- ggplot(raw_data, aes(x = mutation, y = rorgt)) +
  geom_boxplot(alpha = 0.5, width = 0.2) + 
  geom_violin(trim = F, aes(mutation, fill = mutation),
              scale = "width", alpha = 0.6) +
  geom_dotplot(binaxis = "y", stackdir = "center", 
               dotsize = 0.5, color = "Black", fill = "Black") +
  scale_y_log10(breaks = trans_breaks("log10", function(x) 10^x),
                labels = trans_format("log10", math_format(10^.x))) +
  scale_fill_manual(values = cbcols) +
  labs(x = "Mutational Subtype", y = "Number of RORγT Postive Cells/10,000 Cells") +
  theme_bw() +
  theme(axis.text = element_text(size = 16)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.position = "none") + 
  ggtitle("RORγT Lymphocyte Expression in Mutational Subtypes of NSCLC") +
  theme(plot.title = element_text(hjust = 0.5)) +
  stat_compare_means(comparisons = my_comparisons,
                     label = "p.signif", method = "wilcox.test")
temp_plot
dev.off()