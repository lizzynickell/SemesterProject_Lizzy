pigs <- wildschwein_BE
metapigs <- wildschwein_metadata
pigs <- pigs %>%
  full_join(metapigs, by = "CollarID")
head(pigs)
malepigs <- filter(pigs, Sex == "m", E != "NA")
femalepigs <- filter(pigs, Sex == "f", E != "NA")

library(sf)

malepigs_sf <- st_as_sf(malepigs, 
                              coords = c("E", "N"), 
                              crs = 2056,
                              remove = FALSE)

femalepigs_sf <- st_as_sf(femalepigs, 
                        coords = c("E", "N"), 
                        crs = 2056,
                        remove = FALSE)