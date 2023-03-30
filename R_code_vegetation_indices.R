# Calculating spectral indices
library(raster)

setwd("C:/lab/")

# Exercise: import defor1_.png and defor2_.png

l1992 <- brick("defor1_.png")
l2006 <- brick("defor2_.png")
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

# layer 1= NIR
# layer 2 = red
# layer 3 = green

# Exercise: plot the image from 1992 ontop of that of 2006
par(mfrow = c(2,1)) 
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Hist")

# Exercise: calculate DVI for 1992 and 2006
# is the difference between NIR and red 

dvi1992 = l1992[[1]] - l1992[[2]]
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black')) (100)
plot(dvi1992, col=cl)

dvi2006 = l2006[[1]] - l2006[[2]]
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black')) (100)
plot(dvi2006, col=cl)

# Multitemporal analysis
difdvi = dvi1992 - dvi2006
cld <- colorRampPalette(c('blue', 'white', 'red')) (100)
plot(difdvi, col=cld)

#--- NDVI 1992

ndvi1992 = dvi1992/ (l1992[[1]] + l1992[[2]])
plot(ndvi1992, col = cl)

#--- NDVI 2006

ndvi2006 = dvi2006/ (l2006[[1]] + l2006[[2]])
plot(ndvi2006, col = cl)

# Difference of NDVI

difndvi = ndvi1992 - ndvi2006
plot(difndvi, col=cld)
































