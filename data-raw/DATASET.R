## code to prepare `DATASET` dataset goes here
library(dplyr)

ameaca <- read.csv("data-raw/ameacabr.csv") %>%
  as_tibble(.)

usethis::use_data(ameaca, overwrite = TRUE)
