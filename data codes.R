library(ComputationalMovementAnalysisData)
library(sf)
library(tidyverse)
library(psych)
library(ggpubr)
library(dplyr)
library(tmap)

#load data
pigs <- wildschwein_BE
metapigs <- wildschwein_metadata
pigs <- pigs %>%
  full_join(metapigs, by = "TierID",copy = F)
head(pigs)
write.csv(pigs, file = "pigs.csv")


##Method 1: min/max polygons
  #sort data: min/max E & N
pigs2 <- read.csv("~/Documents/cma_project/SemesterProject_Lizzy/pigs2.csv")

  #Make data sf
pigs2 <- st_as_sf(pigs2, 
                          coords = c("E", "N"), 
                          crs = 2056,
                          remove = FALSE)

pigs2grouped <- group_by(pigs2,TierID)
pigs2smry <- summarise(pigs2grouped)

mcp <- st_convex_hull(pigs2smry)
plot(mcp)

  #Split by sex
malepigs <- filter(pigs2, Sex == "m", E != "NA")
femalepigs <- filter(pigs2, Sex == "f", E != "NA")

malepigsgrouped <- group_by(malepigs, TierID)
femalepigsgrouped <- group_by(femalepigs, TierID)

malepigssmry <- summarise(malepigsgrouped)
femalepigssmry <- summarise(femalepigsgrouped)

malecp <- st_convex_hull(malepigssmry)
femalecp <- st_convex_hull(femalepigssmry)

  #interactive maps
tmap_mode("view")

tm_shape(pig2) +
  tm_polygons(col = "TierID",alpha = 0.4,border.col = "green") +
  tm_facets(by = "TierID") +
  tm_legend(bg.color = "white")

tm_shape(pig1) +
    tm_polygons(col = "TierID",alpha = 0.4,border.col = "red") +
    tm_facets(by = "TierID") +
    tm_legend(bg.color = "white")

  #Calculate area
polypigs2 <- pigs2smry %>% 
  st_cast("POLYGON")
  
areapigs2 <-  polypigs2 %>%
  mutate(area = st_area(geometry))
areapigs2

write.csv(areapigs2, file = "pigareas.csv")

pigareas <- read.csv("~/Documents/cma_project/SemesterProject_Lizzy/pigareas.csv")

describeBy(pigareas, group = "Sex")
group_by(pigareas, Sex) %>%
  summarise(
    count = n(),
    mean = mean(area, na.rm = TRUE),
    sd = sd(area, na.rm = TRUE)
  )

ggboxplot(pigareas, x = "Sex", y = "area", 
          color = "Sex", palette = c("#aff000", "#00cef6"),
          ylab = "Area", xlab = "Sex")

with(pigareas, shapiro.test(area[Sex == "m"]))
with(pigareas, shapiro.test(area[Sex == "f"]))
  #not normal

wilcox.test(area ~ Sex, data = pigareas,
            exact = FALSE)

##Method 2: Bounding Box
st_bbox(pigs2)
pigs3 <- pigs2 %>% 
  mutate(bbox = st_bbox(geometry))
  #Isolate piggies
pig1 <- mcp %>% filter(TierID == 1)
pig2 <- mcp %>% filter(TierID == 2)
pig5 <- mcp %>% filter(TierID == 5)
pig10 <- mcp %>% filter(TierID == 10)
pig11 <- mcp %>% filter(TierID == 11)
pig16 <- mcp %>% filter(TierID == 16)
pig18 <- mcp %>% filter(TierID == 18)
pig22 <- mcp %>% filter(TierID == 22)
pig25 <- mcp %>% filter(TierID == 25)
pig31 <- mcp %>% filter(TierID == 31)
pig36 <- mcp %>% filter(TierID == 36)
pig40 <- mcp %>% filter(TierID == 40)
pig48 <- mcp %>% filter(TierID == 48)
pig60 <- mcp %>% filter(TierID == 60)
pig83 <- mcp %>% filter(TierID == 83)
pig84 <- mcp %>% filter(TierID == 84)
pig86 <- mcp %>% filter(TierID == 86)
pig97 <- mcp %>% filter(TierID == 97)
pig98 <- mcp %>% filter(TierID == 98)
  
  #Calculate bounding boxes
box1 <- st_bbox(pig1)
box2 <- st_bbox(pig2)
box5 <- st_bbox(pig5)
box10 <- st_bbox(pig10)
box11 <- st_bbox(pig11)
box16 <- st_bbox(pig16)
box18 <- st_bbox(pig18)
box22 <- st_bbox(pig22)
box25 <- st_bbox(pig25)
box31 <- st_bbox(pig31)
box36 <- st_bbox(pig36)
box40 <- st_bbox(pig40) 
box48 <- st_bbox(pig48)
box60 <- st_bbox(pig60)
box83 <- st_bbox(pig83)
box84 <- st_bbox(pig84)
box86 <- st_bbox(pig86)
box97 <- st_bbox(pig97)
box98 <- st_bbox(pig98)

  #calculate area of bounding boxes
area1 <- ((box1$ymax-box1$ymin) * (box1$xmax-box1$xmin))
area2 <- ((box2$ymax-box2$ymin) * (box2$xmax-box2$xmin))
area5 <- ((box5$ymax-box5$ymin) * (box5$xmax-box5$xmin))
area10 <- ((box10$ymax-box10$ymin) * (box10$xmax-box10$xmin))
area11 <- ((box11$ymax-box11$ymin) * (box11$xmax-box11$xmin))
area16 <- ((box16$ymax-box16$ymin) * (box16$xmax-box16$xmin))
area18 <- ((box18$ymax-box18$ymin) * (box18$xmax-box18$xmin))
area22 <- ((box22$ymax-box22$ymin) * (box22$xmax-box22$xmin))
area25 <- ((box25$ymax-box25$ymin) * (box25$xmax-box25$xmin))
area31 <- ((box31$ymax-box31$ymin) * (box31$xmax-box31$xmin))
area36 <- ((box36$ymax-box36$ymin) * (box36$xmax-box36$xmin))
area40 <- ((box40$ymax-box40$ymin) * (box40$xmax-box40$xmin))
area48 <- ((box48$ymax-box48$ymin) * (box48$xmax-box48$xmin))
area60 <- ((box60$ymax-box60$ymin) * (box60$xmax-box60$xmin))
area83 <- ((box83$ymax-box83$ymin) * (box83$xmax-box83$xmin))
area84 <- ((box84$ymax-box84$ymin) * (box84$xmax-box84$xmin))
area86 <- ((box86$ymax-box86$ymin) * (box86$xmax-box86$xmin))
area97 <- ((box97$ymax-box97$ymin) * (box97$xmax-box97$xmin))
area98 <- ((box98$ymax-box98$ymin) * (box98$xmax-box98$xmin))

  #Regroup into data frame
areas <- c(area1, area2, area5, area10, area11, area16, area18, area22, area25, area31, area36, area40, area48, area60, area83, area84, area86, area97, area98 )
namareas <- c("area1", "area2", "area5", "area10", "area11", "area16", "area18", "area22", "area25", "area31", "area36", "area40", "area48", "area60", "area83", "area84", "area86", "area97", "area98")

df <- data.frame(namareas, areas)
df

write.csv(df, file = "boxypigs.csv")
pigs3 <- read.csv("~/Documents/cma_project/SemesterProject_Lizzy/pigareas.csv")

  #Calculate differences by sex
describeBy(pigs3, group = "Sex")
group_by(pigs3, Sex) %>%
  summarise(
    count = n(),
    mean = mean(box_areas, na.rm = TRUE),
    sd = sd(box_areas, na.rm = TRUE)
  )

ggboxplot(pigs3, x = "Sex", y = "box_areas", 
          color = "Sex", palette = c("#aff000", "#00cef6"),
          ylab = "Bounding Box Area", xlab = "Sex")
wilcox.test(box_areas ~ Sex, data = pigs3,
            exact = FALSE)

##Method 3: Convex Hulls
