# Hi everyone! this is the code I prepared  for my exam in remote sensing, let's see it.
# This project aim is to display how exceptionally dry spring and summer seasons between 2021 and 2022 impacted on 
# Almendra reservoir capacity. On top of that, since drought is also likely to impact on vegetation health, I tried 
# also to assess its effect on the land cover surrounding the lake.  

# Data from: https://scihub.copernicus.eu/dhus/#/home 
# Project key points:
# 1. Preparation of spatial data through Qgis and different Sentinel-2 bands stacking 
# 2. Semiquantitative calculation of the water surface loss using unsupervised classification
# 3. Qualitative evaluation of drought impact on vegetation health through NDVI time series analysis 
 
## First things first

# Let's set the working directory
setwd("C:/lab/telerilevamento_esame")

# Call all the packages needed for the analysis
library(raster)    # analysis and modeling of spatial data
library(ggplot2)   # for creating graphs
library(patchwork) # combine separate ggplots into the same graph


#######                                                                     ########
#### 1. Preparation of spatial data through different Sentinel-2 bands stacking ####
#######                                                                     ########

### First of all I cropped Sentinel-2 free images, avaiable on copernicus portal, using Qgis
# to focus on Almendra Reservoir area and saved the single bands of interest per year. ####

## 2021 data

# Import red, green, blue and nir bands and stack them in a single object 

data21 <- list.files(pattern="_21")
import21 <- lapply(data21, raster)
al21 <- stack(import21)

# Let's see the avaiable informations
al21

#class      : RasterStack 
#dimensions : 2325, 2363, 5493975, 4  (nrow, ncol, ncell, nlayers)
#resolution : 10, 10  (x, y)
#extent     : 718350, 741980, 4558760, 4582010  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=29 +datum=WGS84 +units=m +no_defs 
#names      : B02_21, B03_21, B04_21, B08_21 


## 2022 data

# Import red, green, blue and nir bands and stack them in a single object 

data22 <- list.files(pattern="_22")
import22 <- lapply(data22, raster)
al22 <- stack(import22)

# Let's see the avaiable informations
al22

#class      : RasterStack 
#dimensions : 2325, 2363, 5493975, 4  (nrow, ncol, ncell, nlayers)
#resolution : 10, 10  (x, y)
#extent     : 718350, 741980, 4558760, 4582010  (xmin, xmax, ymin, ymax)
#crs        : +proj=utm +zone=29 +datum=WGS84 +units=m +no_defs 
#names      : B2_22, B3_22, B4_22, B8_22 

# Let's see the results in natural colours with plotRGB 
plotRGB(al21, 3, 2, 1, stretch="lin")
plotRGB(al22, 3, 2, 1, stretch="lin")

# Saving images
jpeg("RGB21.jpg", 900, 900)  # define extenction and resolution 
plotRGB(al21, 3, 2, 1, stretch="lin")
dev.off()                    # it closes the plot box

jpeg("RGB22.jpg", 900, 900)
plotRGB(al22, 3, 2, 1, stretch="lin")
dev.off()

# Create the images for the following classification (I chose nir, red and green 
# in place of natural colours since those bands helped to differentiate classes) 
plotRGB(al21, 4, 3, 2, stretch="lin")
plotRGB(al22, 4, 3, 2, stretch="lin")

# Saving images
jpeg("lake21.jpg", 900, 900)
plotRGB(al21, 4, 3, 2, stretch="lin")
dev.off()

jpeg("lake22.jpg", 900, 900)
plotRGB(al22, 4, 3, 2, stretch="lin")
dev.off()

########                                                                                       ########
##### 2. Semiquantitative calculation of the water surface loss using unsupervised classification #####
########                                                                                       ########

## 2021 data ##

# Import the created data 
l21 <- brick("lake21.jpg")
l22 <- brick("lake22.jpg")

# 1. Get all the single values
singlenr1 <- getValues(l21)
singlenr1

# 2. Classify
kcluster1 <- kmeans(singlenr1, centers = 5)
kcluster1

# 3. Recreating an image
l21class <- setValues(l21[[1]], kcluster1$cluster)

## 2022 data ##

# 1. Get all the single values
singlenr2 <- getValues(l22)
singlenr2

# 2. Classify
kcluster2 <- kmeans(singlenr2, centers = 5)
kcluster2

# 3. Recreating an image
l22class <- setValues(l22[[1]], kcluster2$cluster)

## Plotting several images in the same plotting space

# Choosing a colorRampPalette for an optimal show off of the classes
cl <- colorRampPalette(c("cornsilk", "aquamarine4", "burlywood", "darkolivegreen3", "chocolate")) (100)

# Multiframe 
par(mfrow=c(1,2))
plot(l21class, col=cl, main="Year 2021")
plot(l22class, col=cl, main="Year 2022") 

# Saving multiframe 
jpeg("class21vs22.jpg", 1400, 1400)
par(mfrow=c(1,2))
plot(l21class, col=cl, main="Year 2021")
plot(l22class, col=cl, main="Year 2022") 
dev.off()

## Let's calculate the number of pixels associated to each class to evaluate the covered area ##

# 2021
frequencies1 <- freq(l21class)
tot1 = ncell(l21class)
percentages1 = frequencies1 * 100 /  tot1 # more user friendly output

# 2022
frequencies2 <- freq(l22class)
tot2 = ncell(l22class)
percentages2 = frequencies2 * 100 /  tot2 # more user friendly output

# Call percentages to see the results. Classes were identified through compairing the two images and 
# using as a support a land cover map powered by esri (copernicus)

percentages1
            value     count
[1,] 0.0001009082 44.230373 # forest
[2,] 0.0002018163  6.991927 # water
[3,] 0.0003027245  5.019173 # sand
[4,] 0.0004036327 33.592936 # agriculture and grass
[5,] 0.0005045409 10.165590 # bare soil and antropic
> percentages2
            value    count
[1,] 0.0001008074 45.54749 # forest
[2,] 0.0002016147  4.37383 # water
[3,] 0.0003024221  5.52253 # sand
[4,] 0.0004032295 33.61129 # agriculture and grass
[5,] 0.0005040368 10.94486 # bare soil and antropic

## Create a dataframe to display the results in a Table ##

cover <- c("Water", "Sand", "Bare soil/antropic", "Agriculture/grass", "Forest")  
percent2021 <- c(6.99, 5.01, 10.17, 33.59, 44.23 )
percent2022 <- c(4.37, 5.52, 10.94, 33.61, 45.54 )
Table1 <- data.frame(cover,percent2021, percent2022)
View(Table1) # to display it as a real table

## Create histograms with ggplot package to clearly see changes between 2021 and 2022 ##

ggplot(Table1, aes(x=cover, y=percent2021, color=cover)) + geom_bar(stat="identity", fill="white")

ggplot(Table1, aes(x=cover, y=percent2022, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(Table1, aes(x=cover, y=percent2021, color=cover)) + geom_bar(stat="identity", fill="white") +
  ggtitle(" Year 2021") +
  ylim(c(0,50))

p2 <- ggplot(Table1, aes(x=cover, y=percent2022, color=cover)) + geom_bar(stat="identity", fill="white")+
  ggtitle(" Year 2022") +
  ylim(c(0,50))

p1+p2

# save plot
jpeg("p1+p2.jpg", 1200, 680)
p1 + p2
dev.off()

## Approximative calculation of water surface lost in km2 
# (note that the 10x10 resolution isn't ideal to do a precise extimation) ##

area21 =  (percent2021[1]*tot1*100)/10^8 
area22 =  (percent2022[1]*tot1*100)/10^8
area_lost = area21 - area22

# Create a dataframe and a table to display results

data <- c("area21", "area22", "area_lost")
calculated_km2<- c(6.92709, 4.33067, 2.59642)
Table2 <- data.frame(data,calculated_km2)
View(Table2) 


########                                                                                              ########
##### 3. Qualitative evaluation of drought impact on vegetation health through NDVI time series analysis #####
########                                                                                              ########

## DVI (Difference Vegetation Index)
# Comparing nir and red bands (almost completely reflected and absorbed by healthy plants respectively) 
# allows to evaluate vegetation health changes by, for example, nutritional or idraulic stress

# Let's calculate it to then calculate the ndvi index
# band 4 = nir
# band 3 = red

dvi21 = al21[[4]] - al21[[3]]
dvi22 = al22[[4]] - al22[[3]]

## NDVI (Normalized Difference Vegetation Index)
# It is a standardize index that can be used both with 8 and 16 bit images

ndvi21 = dvi21/(al21[[4]] + al21[[3]])
ndvi22 = dvi22/(al22[[4]] + al22[[3]])

# plotting the two images in the same plotting space
cls <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black')) (100)
par(mfrow=c(1,2))
plot(ndvi21, col=cls)
plot(ndvi22, col=cls)
dev.off()

# saving it
jpeg("NDVI.jpg", 1400, 1400)
par(mfrow=c(1,2))
plot(ndvi21, col=cls, main="NDVI 2021")
plot(ndvi22, col=cls, main="NDVI 2022") 
dev.off()


## difference of ndvi between 2021 and 2022 (multitemporal analysis)
# to see areas in which vegetation health was most affected by drought

cld <- colorRampPalette(c('blue', 'white', 'red')) (100)
difndvi = ndvi21 - ndvi22
plot(difndvi, col=cld)

# saving it
jpeg("difndvi.jpg", 900, 900)
plot(difndvi, col=cld, main="NDVI difference")
dev.off()

### Thanks for the attention ###






 

 

 


 


