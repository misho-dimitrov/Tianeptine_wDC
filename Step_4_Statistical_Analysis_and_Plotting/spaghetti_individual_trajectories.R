library(tidyr)
library(ggplot2)

## Load and arrange the data
d <- read.csv("ASD_Pla_Tia_wDC_Z_hypo.csv", header = FALSE)
d$id <- 1:nrow(d)
colnames(d) <- c("Baseline", "Drug")
d2 <- gather(data = d, key = "Condition", value = "wDC", Baseline, Drug)
colnames(d2) <- c("id", "Condition", "wDC")

shift <- d$Baseline - d$Drug
shift_colours <- ifelse(shift > 0, 'red', 'blue')
shift_colours_all <- c(shift_colours, shift_colours)

# Plot the results
p <- ggplot(d2, aes(x = Condition, y = wDC)) + 
  theme_bw() +
  geom_boxplot(alpha = 0.3,
    fill=c("#808080", "#808080")
    ) + 
  geom_point(aes(group = id), alpha = 0.6, data = d2, na.rm = TRUE)+ 
  geom_line(aes(group = id, col=as.factor(shift_colours_all)), alpha = 0.6, data = d2, na.rm = TRUE)+
  stat_summary(aes(group = 1), fun = median, geom = "point", shape = 18, size = 7, na.rm = TRUE)+
  stat_summary(aes(group = 1), fun = median, geom = "line", size = 2, na.rm = TRUE) +
  scale_color_manual(name = "Direction of Shift", labels = c("increase", "decrease"), values = c("red", "blue")) +
  theme(legend.background = element_rect(colour = 'black', fill = 'white', linetype='solid'))

p + ggtitle("Drug Effect on Mean Sensorimotor Weighted Degree Centrality in Autistic Individuals") + 
  theme(plot.title = element_text(hjust = 0.5)) 
