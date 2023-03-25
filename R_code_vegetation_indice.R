# Calculating spectral indices
library(raster)

setwd("C:/lab/")

# Exercise: import defor1_.png
l1992 <- brick("defor1_.png")
l1992
plotRGB(l1992, 1, 2, 3, stretch="Lin")
# infrarosso è la banda numero 1

# Exercise: calculate DVI for 1992
# calcolo tra ogni pixel tra rosso ed infrarosso
dvi1992= l1992[[1]] - l1992[[2]]
dvi1992
cl <- colorRampPalette(c('darkblue', 'yellow', 'red', 'black')) (100)
plot(dvi1992, col=cl)
