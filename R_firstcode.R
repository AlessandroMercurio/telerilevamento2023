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

cl <- colorRampPalette(c("red", "orange", "yellow")) (100) # to change color ramp in the image
plot(l2011, col=cl) 

# plotting one element
plot(l2011[[4]], col=cl)
