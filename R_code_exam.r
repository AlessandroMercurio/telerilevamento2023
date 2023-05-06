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

#### 1. Preparation of spatial data through different Sentinel-2 bands stacking ####
### First of all I cropped Sentinel-2 free images, avaiable on copernicus portal, using Qgis
# to focus on Almendra Reservoir area and saved the single bands of interest per year. 

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



# plotting the images with a chosen color palette to have a first look 
cl <- colorRampPalette(c("#FFFFCC","#C7E9B4","#7FCDBB","#40B6C4","#2C7FB8" ,"#253494")) (100)
plot(TP1987, col=cl, main="1987")
plot(TP2021, col=cl, main="2021")
# to close the window
dev.off()

# save plots
jpeg("P1999_peyto.jpg", 900, 900)
plot(P1999, col=cl)
dev.off()

jpeg("P2021_peyto.jpg", 900, 900)
plot(P2021, col=cl, main="Peyto glacier 2021")
dev.off()

# multiframe of the images to visualize them both in the same plot 

cl <- colorRampPalette(c("#FFFFCC","#C7E9B4","#7FCDBB","#40B6C4","#2C7FB8" ,"#253494")) (100)
par(mfrow=c(1,2))
plot(TP1987, main="1999")
plot(TP2021, main="2021")
dev.off()

# visualize the images with RGB colors 
# red = band 1
# green = band 2 
# blue= band 3

g1 <- ggRGB (TP1987, r =1, g = 2, b = 3, stretch = "lin")

g2 <- ggRGB (TP2021, r =1, g = 2, b = 3, stretch = "lin")

# plot both in the same page 
g1+g2
dev.off()

# save plot
jpeg("g1+g2.jpg", 900, 900)
plot(g1+g2, col=cl, main="RGB")
dev.off()


###### 2. Semiquantitative calculation of the water surface loss using unsupervised classification ######
TP1987_pca <- rasterPCA(TP1987)

# Visualize the importance of components 
summary(TP1987_pca$model)

#Importance of components:
#Comp.1      Comp.2      Comp.3
#Standard deviation     112.849604 15.52086859 3.920285709
#Proportion of Variance   0.980274  0.01854298 0.001182995
#Cumulative Proportion    0.980274  0.99881701 1.000000000

# plot a pca map (the PC1 component has 98,02% of variance)
plot(P1999_pca$map)
dev.off()

# assign a name for all the pca components
pc1_1999 <- P1999_pca$map$PC1
pc2_1999 <- P1999_pca$map$PC2
pc3_1999 <- P1999_pca$map$PC3

# plot of the components with viridis 
g1 <- ggplot() + 
  geom_raster(P1999_pca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC1")


g2 <- ggplot() + 
  geom_raster(P1999_pca$map, mapping=aes(x=x, y=y, fill=PC2)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC2")

g3 <- ggplot() + 
  geom_raster(P1999_pca$map, mapping=aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC3")

# all the components in the same plot 
g1+g2+g3
dev.off()

# save plot
jpeg("PC_1999.jpg", 900, 300)
plot(g1+g2+g3, col=cl, main="Principal component analysis")
dev.off()

#Principal component analysis to extract data with many 
#variables and create visualizations to display that data (PCA)
#for 2021 image 
P2021_pca <- rasterPCA(P2021)

# Visualize the importance of components 
summary(P2021_pca$model)
#Importance of components:
#Comp.1      Comp.2      Comp.3
#Standard deviation     95.1994343 16.48198595 3.859144962
#Proportion of Variance  0.9693514  0.02905572 0.001592923
#Cumulative Proportion   0.9693514  0.99840708 1.000000000

# plot a pca map (the PC1 component has 96,93% of variance)
plot(P2021_pca$map)
dev.off()
#assign a name for all the pca components
pc1_2021 <- P2021_pca$map$PC1
pc2_2021 <- P2021_pca$map$PC2
pc3_2021 <- P2021_pca$map$PC3

# plot of the components with viridis
im1 <- ggplot() + 
  geom_raster(P2021_pca$map, mapping=aes(x=x, y=y, fill=PC1)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC1")

im2 <- ggplot() + 
  geom_raster(P2021_pca$map, mapping=aes(x=x, y=y, fill=PC2)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC2")

im3 <- ggplot() + 
  geom_raster(P2021_pca$map, mapping=aes(x=x, y=y, fill=PC3)) + 
  scale_fill_viridis(option = "mako") +
  ggtitle("PC3")

# all the components in the same plot
im1+im2+im3
dev.off()

# save plot
jpeg("PC_2021.jpg", 900, 300)
plot(im1+im2+im3, col=cl, main="Principal component analysis")
dev.off()

####### Calculate the difference between the first components#######
diff <- pc1_1999 - pc1_2021

# assign a color palette 
cl <- colorRampPalette(c("purple", "yellow","orange","red")) (100)

# plot the difference between the first and the second component
plot(diff, col=cl, main = "Ice mass variation")
dev.off()

# save plot
jpeg("difference.jpg", 900, 900)
plot(diff, col=cl, main="Difference")
dev.off()


##### 3. Qualitative evaluation of drought impact on vegetation health through NDVI time series analysis #####
# calculate heterogeneity in a 3x3 window for more definition
sd3 <- focal(diff, matrix(1/9, 3, 3), fun=sd)
sd3

# plot a map so we can see all the areas with the highest heterogeneity
cl <- colorRampPalette(c("magenta", "yellow", "green", "blue")) (100)
plot(sd3, col=cl, main = "Standard deviation")
dev.off()

# save plot
jpeg("sd3.jpg", 900, 900)
plot(sd3, col=cl, main="Standard deviation")
dev.off()