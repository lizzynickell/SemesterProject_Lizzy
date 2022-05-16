# Proposal for Semester Project

**Patterns & Trends in Environmental Data / Computational Movement
Analysis Geo 880**

| Semester:      | FS22                              |
|----------------|---------------------------------- |
| **Data:**      | Wild Boar Movement Data           |
| **Title:**     | Sex differences in boar movement  |
| **Student 1:** | He Yelu                           |
| **Student 2:** | Lizzy Nickell                     |

## Abstract 
Wild boars show a distinct physical sexual dimorphism, with males being much larger than the females. Can this difference be seen in other aspects of wild boars? We analyzed the movement patterns of XX boars, X male and X females to compare the amount of movement in the sexes. We predicted that females move less than males, as they must care for the young, and are not responsible for maintaining territory.

## Research Questions
Is there a difference in how much males move vs. females?

## Results / products
We expect that males will move more than females, protecting territory while the females care for the young.

## Data
Provided data, combining the individual data with the sex id from the schreck data.

## Analytical concepts
3.1 Data pre-processing
-   Data cleaning.
-   Data combination to assign sexes to boar id.
-   Assigning scores to movement.

3.2 Data analysis
-   Comparing scores of males and females.
-   Time series analysis of movement pattern.
-   Circannual movement pattern analysis among genders.
-   Circadian movement pattern analysis among genders.
-   Modelling between environmental factors and movement pattern.

3.3 Visualization


## R concepts
library(ggplot)
library(tidyverse)
library(tmap)
library(readr)       
library(dplyr)       
library(ggplot2)     
library(sf)           
library(terra)        
library(lubridate) 
library(zoo)
library(similaritymeasures)

## Risk analysis
Always a risk of data loss and computer crashes. Data and files will be backed up on github and on two computers.

## Questions? 
<!-- Which questions would you like to discuss at the coaching session? -->
