# Tidy Tuesday Submission 1 - Big Tech Stock ----
# Created By: Mac Hein
# Created On: 2023-02-21

# Load Libraries ----

library(tidyverse)
library(here)
library(devtools)
library(ggdist)
library(tidytuesdayR)
library(BobRossColors)

# Load Data ----

tuesdata <- tidytuesdayR::tt_load('2023-02-21')
tuesdata <- tidytuesdayR::tt_load(2023, week = 8)

bob_ross <- tuesdata$bob_ross

# Data Analysis ----

View(bob_ross)

