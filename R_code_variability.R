How to measure landscape variability with R

library(raster)
library(ggplot2)
library(patchwork)
install.packages("viridis")
library(viridis)

setwd("C:/lab/")

# import the Similaun image
sen <- brick("sentinel.png")

# 1= NIR, 2= red, 3= green
plotRGB(sen, 1,2,3, stretch="lin")

nir <- sen[[1]]
mean3 <- focal(nir, matrix(1/9, 3, 3), fun=mean) # mean function
sd3 <- focal(nir, matrix(1/9, 3, 3), fun=sd) # standard deviation function

# The standard plot isn't clear enough, let's use ggplot2
ggplot() +
geom_raster(sd3, mapping=aes(x=x, y=y, fill=layer)) + 
ggtitle("Standard deviation moving window 3x3")

# ggplot need a dataframe, let's create it
sd3d <- as.data.frame(sd3, xy=TRUE)
sd3d

ggplot() +
geom_raster(sd3d, mapping=aes(x=x, y=y, fill=layer)) + 
ggtitle("Standard deviation moving window 3x3")

## plot with viridis colorRampPalette
# cividis palette
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="cividis") +
ggtitle("Standard deviation by viridis package")

# magma palette
ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="magma") +
ggtitle("Standard deviation by viridis package")

# viridis + patchwork
p1 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option="cividis") +
ggtitle("Standard deviation by viridis package")

p2 <- ggplot() +
geom_raster(sd3d, mapping =aes(x=x, y=y, fill=layer)) +
scale_fill_viridis(option = "magma") +
ggtitle("Standard deviation by viridis package")

p1 + p2


















