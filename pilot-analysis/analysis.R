library(rdrop2)
library(tidyverse)
# read in the dropbox token
token <- readRDS("token.rds")
drop_auth(rdstoken = "token.rds")

## list the files in the learnr_results folder
files <- drop_dir("/D'Agostino McGowan Data Science Lab/learnr_results/")

files <- files %>%
  filter(grepl("assessment_(1|2)", name))

f <- function(path) {
  drop_download(path, local_path = "temp.rds", overwrite = TRUE)
  d <- readRDS("temp.rds")
  d$user_info <- path
  d
}

d <- map_df(files$path_lower, f)

## make this a wider data frame with a column for each question per assessment per user
## In the end, we'd have 1 or two rows per username (depending on whether they completed the second assessment)
## The exploratory analysis could subset to only assessment 1 responses and then only assessment 2 responses by arm (A or B) and see if there is a differece