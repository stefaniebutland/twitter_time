# load packages -----
library(tidyverse)
library(here)
library(usethis)
library(visdat)

usethis::use_github()

# load data from csv ------
# metrics is an "object"
# here() starts at /Users/stefaniebutland/R/tweets_ropensci so any files pointed to can be relative to that
# careful: read_csv is tidyverse; read.csv is not
metrics <- read_csv(here("data", "twitter_metrics_monthly_rOpenSci.csv"))

# exploring twitter metrics data -------
# View (metrics) gives preview of data frame. Same can be achieved by clicking in metrics df in the Environment window
View(metrics)

# use visdat pakage to visualize missing data
vis_dat(metrics)

# ggplot2 line plot of tweets vs mentions, year vs mentions or new followers
ggplot(data = metrics, aes(x=year, y=mentions)) +
  geom_point()

ggplot(data = metrics, aes(x=tweets, y=mentions)) +
  geom_point()

ggplot(data = metrics, aes(x=year, y=new_followers)) +
  geom_point()

ggplot(data = metrics, aes(x=year, y=followers)) +
  geom_point()

ggplot(data = metrics, aes(x=new_followers, y=mentions)) +
  geom_point()



#ggplot2 plot of 37 rows of data (= monthly download) with oldest date first vs y
# ideally would do this with month/year labelled on x-axis
ggplot(data = metrics, aes(x=37:1, y=mentions)) +
  geom_point()
