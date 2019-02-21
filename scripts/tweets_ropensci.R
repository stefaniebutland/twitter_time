# load packages -----
library(tidyverse)
library(here)
library(usethis)
library(visdat)
library(ggbeeswarm)

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

glimpse(metrics)

# turn one column into 2 using separate


# create new column by uniting 2 other columns using unite
metrics %>% unite(month_year, month:year, remove = FALSE)

# calculate a new column using mutate
# this example gets difference in number of followers each month
followersgrowth <- metrics %>% mutate(followersdiff = followers - lag(followers))

# count number of observations in each year; expect 12
metrics %>%
  group_by(year) %>%
  summarise(obs = n())

# try jitter instead of point
# in this case of only 12 obs per year, jitter isn't needed
ggplot(data = metrics, aes(x=year, y=mentions)) +
  geom_jitter()

ggplot(data = metrics, aes(x=year, y=mentions)) +
  geom_jitter()

# trying beeswarm, but again, not needed for this data
ggplot(data = metrics, aes(x=year, y=mentions)) +
  geom_beeswarm()

# left off at https://rladiessydney.org/post/2018/12/20/vizwhiz-1/ "1.2 Using colour to plot bug levels by site"

