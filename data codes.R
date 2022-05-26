library(sf)
library(tidyverse)


pigs <- wildschwein_BE
metapigs <- wildschwein_metadata
pigs <- pigs %>%
  full_join(metapigs, by = "TierID",copy = F)
head(pigs)
write.csv(pigs, file = "pigs.csv")

pigs2 <- read.csv("~/Documents/cma_project/SemesterProject_Lizzy/pigs.csv")

malepigs <- filter(pigs, Sex == "m", E != "NA")
femalepigs <- filter(pigs, Sex == "f", E != "NA")

library(sf)

pigs2 <- st_as_sf(pigs2, 
                          coords = c("E", "N"), 
                          crs = 2056,
                          remove = FALSE)



pigs2grouped <- group_by(pigs2,TierID)
pigs2smry <- summarise(pigs2grouped)

mcp <- st_convex_hull(pigs2smry)
plot(mcp)

areapigs2 <- pigs2smry %>% 
  mutate(area = st_area(geometry))
areapigs2



