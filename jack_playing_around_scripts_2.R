# Jack playing around scripts 2 #

library(ggpubr)
library(ggplot2)

raw_data <- read.csv("all_mt_vs_wt.csv")

cbcols <- c("WT" = "#999999",
            "MT" = "#56B4E9")

my_comparisons <- list(c("WT", "MT"))
raw_data$mutation <- factor(raw_data$mutation, levels = c("WT", "MT"))


pdf("./Test_Export/t1.pdf", height = 6, width = 6)
temp_plot <- ggplot(raw_data, aes(x = mutation, y = rorgt)) +
  geom_boxplot(alpha = 0.5, width = 0.2) + 
  geom_violin(aes(mutation, fill = mutation),
              scale = "width", alpha = 0.8) +
  scale_fill_manual(values = cbcols) +
  labs(x = "what_your_groups_are", y = "rorgt") +
  theme_bw() +
  theme(axis.text = element_text(size = 16)) +
  theme(panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  theme(legend.direction = "horizontal", legend.position = "top") + 
  stat_compare_means(comparisons = my_comparisons,
                     label = "p.signif", method = "wilcox.test")

temp_plot
dev.off()

raw_data$mutation <- as.character(raw_data$mutation)
View(raw_data)
str(raw_data)
DF <- factor(c(WT, MT))
DF <- factor(groups)


