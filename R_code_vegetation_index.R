# Calculating spectral indices
library(raster)

setwd("C:/lab/")

# Exercise: import defor1_.png
l1992 <- brick("defor1_.png")
l2006 <- brick("defor2_.png")
plotRGB(l1992, 1, 2, 3, stretch="Lin")
plotRGB(l2006, 1, 2, 3, stretch="Lin")

# layer 1= NIR
# layer 2 = red
# layer 3 = green

# Exercise: calculate DVI for 1992
# is the difference between NIR and red 

dvi1992= l1992[[1]] - l1992[[2]]
dvi1992
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black')) (100)
plot(dvi1992, col=cl)
