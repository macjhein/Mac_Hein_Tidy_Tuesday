# Tidy Tuesday Submission 1 - Big Tech Stock ----
# Created By: Mac Hein
# Created On: 2023-03-1

# Load Libraries ----

library(tidyverse)
library(here)
library(tidytuesdayR)

# Load Data ----

tuesdata <- tidytuesdayR::tt_load('2023-03-07')
tuesdata <- tidytuesdayR::tt_load(2023, week = 10)

numbats <- tuesdata$numbats

# Data Analysis ----

View(numbats)

# Questions that would be interesting to answer are:
#   
#   Where do you find numbats in Australia?
#   Was the distribution more widespread historically? (You may need to exclude zoo reported observations.)
#   What time of day do numbat sightings occur?
#   Are they more frequent in the summer or winter?
#   Are numbats seen more on sunny and warm days than cloudy, wet, cold days?
#   Do sightings happen more on week days than weekends?

