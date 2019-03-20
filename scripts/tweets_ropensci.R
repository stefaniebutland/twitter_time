# load packages -----
library(tidyverse)
library(here)
library(usethis)
library(visdat)
# library(ggbeeswarm)
library(lubridate)

usethis::use_github()

## load data from csv ------
## careful: read_csv is tidyverse; read.csv is not
## metrics is an "object"

# > here::here()
## [1] "/Users/stefaniebutland/GitHub/stefaniebutland/twitter_time"
## here() starts at /Users/stefaniebutland/GitHub/stefaniebutland/twitter_time so any files pointed to can be relative to that



## working with original poorly formatted data file
# metrics <- read_csv(here("data", "twitter_metrics_monthly_rOpenSci.csv"))

## working with 2019-03-02 correctly formatted twitter data csv file
metrics <- read_csv(here::here("data", "2019-03-02_twitter_metrics_monthly_rOpenSci.csv"))


# exploring twitter metrics data -------
# View (metrics) gives preview of data frame. Same can be achieved by clicking in metrics df in the Environment window
View(metrics)

# use visdat pakage to visualize missing data
vis_dat(metrics)

# ggplot2 line plot of tweets vs mentions, date vs mentions or new followers

# followers column is the only one that is not 100% objectve, since it is not archived by twitter analytics the way mentions etc are
ggplot(data = metrics, aes(x=date, y=followers)) +
  geom_point()

ggplot(data = metrics, aes(x=date, y=followers)) +
   geom_line()

ggplot(data = metrics, aes(x=date, y=new_followers)) +
  geom_line()

ggplot(data = metrics, aes(x=date, y=tweets)) +
  geom_line()

ggplot(data = metrics, aes(x=date, y=tweets)) +
  geom_point()

ggplot(data = metrics, aes(x=date, y=tweet_impressions)) +
  geom_line()

ggplot(data = metrics, aes(x=date, y=profile_visits)) +
  geom_line() 

ggplot(data = metrics, aes(x=date, y=mentions)) +
  geom_line()

ggplot(data = metrics, aes(x=tweets, y=mentions)) +
  geom_line()

#ggplot2 plot of 37 rows of data (= monthly download) with oldest date first vs y
# ideally would do this with month/year labelled on x-axis
# ggplot(data = metrics, aes(x=37:1, y=mentions)) +
#  geom_point()

# glimpse(metrics)

# turn one column into 2 using separate


# # create new column by uniting 2 other columns using unite
# metrics_bymonth <- metrics %>% unite(month_year, month:year, remove = FALSE)
# 
# # plot a twitter metric with x = month_year
# # problem is that x-axis is re-ordered alphabetically
# ggplot(data = metrics_bymonth, aes(x=month_year, y=tweet_impressions/1000)) +
#   geom_point()
# 
# ggplot(data = metrics_bymonth, aes(x=month_year, y=followers)) +
#   geom_point()

## this still groups x axis points strangely
# ggplot(data = metrics, aes(x=commit_date, y=followers)) +
#   geom_point()


# use lubridate to make date and plot following https://r4ds.had.co.nz/dates-and-times.html
# create new column with commit date in proper format. This worked!!!
# next, need to look at the actual dates in raw data and see which ones I can label with approx real dates rather than GitHub commit dates that give multiple y-axis points for one GitHub commit date
# test <- metrics %>% 
#   mutate (date = ymd(commit_date))
# 
# ggplot(data = test, aes(x=date, y=followers)) +
#   geom_point()

# calculate a new column using mutate
# this example gets difference in number of followers each month
# followersgrowth <- metrics %>% mutate(followersdiff = followers - lag(followers))

# count number of observations in each year; expect 12
# metrics %>%
#   group_by(year) %>%
#   summarise(obs = n())
# 
# # try jitter instead of point
# # in this case of only 12 obs per year, jitter isn't needed
# ggplot(data = metrics, aes(x=year, y=mentions)) +
#   geom_jitter()

# trying beeswarm, but again, not needed for this data
# ggplot(data = metrics, aes(x=year, y=mentions)) +
#  geom_beeswarm()

# left off at https://rladiessydney.org/post/2018/12/20/vizwhiz-1/ "1.2 Using colour to plot bug levels by site"

