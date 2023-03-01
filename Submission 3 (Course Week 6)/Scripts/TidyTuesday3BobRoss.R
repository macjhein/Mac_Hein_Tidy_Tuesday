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
