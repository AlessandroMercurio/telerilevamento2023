# My first code in Git Hub

# Let's install the raster package 
install.packages("raster") # outside R use ""
library(raster) # call package

# setting the working directory
setwd("C:/lab/")

# import and assign data 
l2011 <- brick("p224r63_2011_masked.grd")

# Plotting the data in a savage manner
plot(l2011)

cl <- colorRampPalette(c("red", "orange", "yellow")) (100) # to change colour ramp in the image
plot(l2011, col=cl) 

# plotting one element
plot(l2011[[4]], col=cl)



# Exercise: change the colour gamut for all images
cl <- colorRampPalette(c("cyan", "azure", "darkorchid", "aquamarine")) (100)
plot(l2011, col=cl) 

# Exercise: plot the NIR band
plot(l2011[[4]], col=cl)  # calling the number of the band
plot(l2011$B4_sre, col=cl) # calling the name of the band

# dev.off() # it closes graphs

# Export graphs from R to wd
pdf("myfirstgraph.pdf")  # saves a pdf with that name in the directory (lab)
plot(l2011$B4_sre, col=cl) # add the plot to the pdf
dev.off() # it closes all

# Plotting several bands in a Multiframe 
par(mfrow = c(2,1)) # function that create a window of two rows to place two elements (in this case 2 bands)
plot(l2011[[3]], col=cl) # first row "red"
plot(l2011[[4]], col=cl) # second row "NIR"

# Plotting the first 4 bands each one with a different colour ramp palette
par(mfrow = c(2,2))  

# blue
clb <- colorRampPalette(c("blue4", "blue2", "light blue")) (100)
plot(l2011[[1]], col=clb) 

# green
clg <- colorRampPalette(c("chartreuse4", "chartreuse2", "chartreuse")) (100)
plot(l2011[[2]], col=clg)

# red
clr <- colorRampPalette(c("coral3", "coral1", "coral")) (100)
plot(l2011[[3]], col=clr)

# nir
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011[[4]], col=clnir)



# RGB plotting
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")

# Multiframe with natural and false colours
par(mfrow = c(2,1)) 
plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")

# Histogram stretching
# Multiframe with natural and false colours
par(mfrow = c(2,1)) 
plotRGB(l2011, r=3, g=2, b=1, stretch="Hist")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")

# Linear vs Histogram stretching
par(mfrow = c(2,1)) 
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Hist")



# Exercise: plot the NIR band
clnir <- colorRampPalette(c("red", "orange", "yellow")) (100)
plot(l2011[[4]], col=clnir)

plotRGB(l2011, r=3, g=2, b=1, stretch="Lin")
plotRGB(l2011, r=4, g=3, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=4, b=2, stretch="Lin")
plotRGB(l2011, r=3, g=2, b=4, stretch="Lin")


# Exercise: import the 1988 image
l1988 <- brick("p224r63_1988_masked.grd")

# Exercise: plot in RGB space (natural colours)
plotRGB(l1988, r=3, g=2, b=1, stretch="Lin")
plotRGB(l1988, r=4, g=3, b=2, stretch="Lin")

# multiframe
par(mfrow = c(2,1))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Hist")

# multiframe with 4 images
par(mfrow = c(2,2))
plotRGB(l1988, 4, 3, 2, stretch="Lin")
plotRGB(l2011, 4, 3, 2, stretch="Lin")
plotRGB(l1988, 4, 3, 2, stretch="Hist")
plotRGB(l2011, 4, 3, 2, stretch="Hist")


































