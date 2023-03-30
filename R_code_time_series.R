# R code for importing and analysing several images
# Greenland increase of temperature

library(raster)

setwd("C:/lab/greenland")

lst_2000<-raster("lst_2000.tif")
lst_2005<-raster("lst_2005.tif")
lst_2010<-raster("lst_2010.tif")
lst_2015<-raster("lst_2015.tif")

# Create a list of different files with same object
rlist <- list.files(pattern="lst")
rlist

# apply to the created list the function raster
import <- lapply(rlist,raster)
import
