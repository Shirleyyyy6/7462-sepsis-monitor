library(tidyverse)
library(data.table) ## For the fread function
library(lubridate)
library(tictoc)
library(googledrive)
library(dplyr)
library(gt)
library(knitr)
library(plotly)

source("sepsis_monitor_functions.R")
# 
# tic()
# makeSepsisDataset(50,"fread") #20.07s
# toc()
# tic()
# makeSepsisDataset(50,"read_delim") #20.6s
# toc()
# 
# tic()
# makeSepsisDataset(100,"fread") #32.61s
# toc()
# tic()
# makeSepsisDataset(100,"read_delim") #41.67s
# toc()
# 
# tic()
# makeSepsisDataset(500,"fread") #131.93s
# toc()
# tic()
# makeSepsisDataset(500,"read_delim") #207.16s
# toc()


# df <- makeSepsisDataset()
# 
# # We have to write the file to disk first, then upload it
# df %>% write_csv("sepsis_data_temp.csv")
# 
# # Uploading happens here
# sepsis_file <- drive_put(media = "sepsis_data_temp.csv",
#                          path = "https://drive.google.com/drive/folders/1ONVevrMHbMDlu3YGWlqTPr-Y0b_OC8Kb",
#                          name = "sepsis_data.csv")
# 
# # Set the file permissions so anyone can download this file.
# sepsis_file %>% drive_share_anyone()

## Calling drive_deauth() prevents R from trying to authenticate via a browser
## This is needed to make the GitHub Action work
drive_deauth()
file_link <- "https://drive.google.com/file/d/1vpIM-QAKIFubVQWD_bWBCOcb-489lriP/view?usp=sharing"

## All data up until now
new_data <- updateData(file_link)

## Include only most recent data
most_recent_data <- new_data %>%
  group_by(PatientID) %>%
  filter(obsTime == max(obsTime))

