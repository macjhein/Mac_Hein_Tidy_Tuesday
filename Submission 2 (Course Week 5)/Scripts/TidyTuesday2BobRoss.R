# Tidy Tuesday Submission 1 - Big Tech Stock ----
# Created By: Mac Hein
# Created On: 2023-02-21

# Load Libraries ----

library(tidyverse)
library(here)
library(devtools)
library(ggdist)
library(tidytuesdayR)
library(ggplot2)
library(dplyr)
library(tidyr)
library(BobRossColors)

# Load Data ----

tuesdata <- tidytuesdayR::tt_load('2023-02-21')
tuesdata <- tidytuesdayR::tt_load(2023, week = 8)

bob_ross <- tuesdata$bob_ross

# Data Analysis ----

View(bob_ross)

colors_by_season <- bob_ross %>%
  pivot_longer(cols = Black_Gesso:Alizarin_Crimson,
               names_to = "color",
               values_to = "count") %>%
  filter(count == TRUE) %>%
  group_by(season, color) %>%
  summarize(count = n())%>%
  write_csv(here("Submission 2 (Course Week 5)","Data","colors_by_season.csv"))

View(colors_by_season)

color_palette <- c(Alizarin_Crimson = "#4E1500",
                   Black_Gesso = "#000000",
                   Bright_Red = "#DB0000",
                   Burnt_Umber = "#8A3324",
                   Cadmium_Yellow = "#FFEC00",
                   Dark_Sienna = "#5F2E1F",
                   Indian_Red = "#CD5C5C",
                   Indian_Yellow = "#FFB800",
                   Liquid_Black = "#000000",
                   Liquid_Clear = "#FFFFFF",
                   Midnight_Black = "#000000",
                   Phthalo_Blue = "#0C0040",
                   Phthalo_Green = "#102E3C",
                   Prussian_Blue = "#021E44",
                   Sap_Green = "#0A3410",
                   Titanium_White ="#FFFFFF",
                   Van_Dyke_Brown = "#221B15",
                   Yellow_Ochre = "#C79B00")

ggplot(data = colors_by_season, mapping = aes(fill = color, x = color, y = count))+
  geom_bar(position="dodge", stat="identity") +
  theme_dark() +
  theme(axis.text.x = element_blank(), axis.ticks.x = element_blank(),
        panel.grid.major = element_blank(), panel.grid.minor = element_blank()) +
  facet_wrap(~season, scales = "free") +
  labs(x = "Color", y = "Times Used", fill = "Color", title = "Bob Ross's Use of Color by Season") +
  scale_colour_manual(values = color_palette, aesthetics = c("color", "fill"))
  
ggsave(here("Submission 2 (Course Week 5)","Output","Bob_Ross_Color_By_Season.png"),
       width = 20, height = 10)
