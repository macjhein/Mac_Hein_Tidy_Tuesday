# Tidy Tuesday Submission 1 - Big Tech Stock ----
# 2023-02-14
#   ISO 8601 format: YYYY-MM-DD
# By Mac Hein

# Load Libraries ----

library(tidyverse)
library(here)
library(devtools)
library(ggdist)
# Need to figure out which other libraries to use

# Load Data ----

# Need to ask if I should use the big tech stock data or another data set
#   Can use any posted data set
# Need to figure out how to add a csv file to the Data folder in the project
#   You don't have to, just use the line of code below

big_tech_stock_prices <- readr::read_csv('https://raw.githubusercontent.com/rfordatascience/tidytuesday/master/data/2023/2023-02-07/big_tech_stock_prices.csv')

# Data Analysis ----

View(big_tech_stock_prices)

big_tech_stock_prices %>%
  filter(stock_symbol %in% c("AAPL", "MSFT")) %>%
  ggplot(aes(x = date, y = volume, group = stock_symbol, color = stock_symbol)) +
  geom_line(size = 0.1, alpha = 0.5) +
  geom_smooth() +
  scale_fill_viridis_d(option = "mako")+
  theme_light() +
  labs(title = "Number (volume) of traded Apple and Microsoft shares per day",
       x = "Date", y = "Volume", color = "Company")

