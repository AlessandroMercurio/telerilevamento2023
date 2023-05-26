# 3D in R

setwd("C:/lab/dati")
library(raster) #"Geographic Data Analysis and Modeling"
library(rgdal) #"Geospatial Data Abstraction Library"
library(viridis)
library(ggplot2)
library(patchwork)

# import data
dsm_2013 <- raster("2013Elevation_DigitalElevationModel-0.5m.tif")
dtm_2013 <- raster("2013Elevation_DigitalTerrainModel-0.5m.tif")
dsm_2004 <- raster()
dtm_2004 <- raster(

# create the data frame for ggplot
dsm_2013d <- as.data.frame(dsm_2013, xy=T)
dtm_2013d <- as.data.frame(dtm_2013, xy=T)

ggplot() +
geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalElevationModel.0.5m)) +
scale_fill_viridis() +
ggtitle("dsm 2013")

ggplot() +
geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalTerrainModel.0.5m)) +
scale_fill_viridis(option="magma") +
ggtitle("dtm 2013")

# calculate the height of object between terrain and surface
chm_2013 <- dsm_2013 - dtm_2013
chm_2013d <- as.data.frame(chm_2013, xy=T)
ggplot() +
geom_raster(chm_2013d, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("chm 2013")

p1 <- ggplot() +
geom_raster(dsm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalElevationModel.0.5m)) +
scale_fill_viridis() +
ggtitle("dsm 2013")

p2 <- ggplot() +
geom_raster(dtm_2013d, mapping=aes(x=x, y=y, fill=X2013Elevation_DigitalTerrainModel.0.5m)) +
scale_fill_viridis(option="magma") +
ggtitle("dtm 2013")

p3 <- ggplot() +
geom_raster(chm_2013d, mapping=aes(x=x, y=y, fill=layer)) +
scale_fill_viridis() +
ggtitle("chm 2013")
  
# with patchwork
 p1 + p2 + p3

# complete with 2004 and chm2013-2004







