## Load necessary libraries
library(ggplot2)
library(dplyr)
library(MetBrewer)  # For the 'met.brewer()' color palettes

## Set the default theme for all ggplot2 plots
theme_set(
  theme_bw() +  # Use the black-and-white theme as the base
    theme_bw(base_size = 14,  # Set the base font size to 14 for better readability
             base_family = "Helvetica") +  # Use Helvetica as the default font
    theme(panel.border = element_rect(size = 1.5))  # Increase the border thickness of the plot panel
)

## Load the data
d <- read.csv("Tianeptine_wDC.csv") %>% 
  mutate(Group = factor(Group, levels = c("Neurotypical", "Autistic")),  # Ensure 'Group' is a factor with specific order
         Drug = factor(Drug, levels = c("Placebo", "Tianeptine")))  # Ensure 'Drug' is a factor with specific order

## Create the plot
ggplot(d, aes(x = Drug, y = wDC)) +  
  ## Box plot to show the distribution of data
  geom_boxplot(aes(group = interaction(Drug, Group), colour = Group),  
               fill = NA,  # No fill inside the boxplots
               width = 0.6,  # Control box width
               position = position_dodge(width = 0.8),  # Separate groups within each drug condition
               outliers = FALSE,  # Remove outliers
               show.legend = FALSE) +  # Hide boxplots from the legend
  
  ## Points representing individual data points for each subject
  geom_point(aes(fill = Group, group = interaction(ID, Group)),  
             shape = 21,  # Use filled circles
             colour = "white",  # White outline around points
             alpha = 0.3,  # Make points slightly transparent
             size = 4,  # Set point size
             position = position_dodge(width = 0.8)) +  # Dodge for group separation
  
  ## Lines connecting individual subject points across conditions
  geom_line(aes(group = interaction(ID, Group), color = Group),  
            alpha = 0.4,  # Set transparency for lines
            position = position_dodge(width = 0.8),  # Apply same dodge so lines align with points
            show.legend = FALSE) +  # Remove lines from legend
  
  ## Customize x-axis labels
  scale_x_discrete(labels = c("Placebo", "Tianeptine")) +  
  
  ## Create separate plots for each 'Network' variable
  facet_wrap(~Network) +  
  
  ## Set custom colors for the groups using MetBrewer color palette
  scale_color_manual(values = c(met.brewer("Archambault", 11)[3],  
                                met.brewer("Archambault", 11)[8])) +  
  scale_fill_manual(values = c(met.brewer("Archambault", 11)[3],  
                               met.brewer("Archambault", 11)[8])) +  
  
  ## Override alpha in the legend to ensure full opacity (alpha = 1) for color representation
  guides(
    color = guide_legend(override.aes = list(alpha = 1)),  # Ensure lines are fully visible in the legend
    fill = guide_legend(override.aes = list(alpha = 1))  # Ensure points are fully visible in the legend
  ) +  
  
  ## Apply a clean black-and-white theme
  theme(legend.title = element_blank())  # Remove legend title
