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

# this function stacks toghether the four images (similar to "par" function but creates a unique file)
TGr <- stack(import)
plot(TGr)

plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

# difference:
dift = TGr[[2]] - TGr[[1]]

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(TGr, col=cl)


#########
### Example 2: NO2 decrease during the lockdownperiod
#########

library(raster)

setwd("C:/lab/en")

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

# this function stacks toghether the four images (similar to "par" function but creates a unique file)
TGr <- stack(import)
plot(TGr)

plotRGB(TGr, 1, 2, 3, stretch="Lin")
plotRGB(TGr, 2, 3, 4, stretch="Lin")
plotRGB(TGr, 4, 3, 2, stretch="Lin")

# difference:
dift = TGr[[2]] - TGr[[1]]

cl <- colorRampPalette(c("blue","light blue","pink","red"))(100)
plot(TGr, col=cl)









