## code to prepare `DATASET` dataset goes here

ameaca <- read.csv("data-raw/ameacabr.csv") %>%
  dplyr::as_tibble(.)

usethis::use_data(ameaca, overwrite = TRUE)
