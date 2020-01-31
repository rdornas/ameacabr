## code to prepare `DATASET` dataset goes here

ameaca <- read.csv("data-raw/ameaca.csv")

usethis::use_data(ameaca, overwrite = TRUE)
