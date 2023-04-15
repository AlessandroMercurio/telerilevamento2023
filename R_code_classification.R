# Classification of remote sensing data via RStoolbox

library(raster)
setwd("C:/lab/")

so <- brick("Solar_Orbiter_s_first_views_of_the_Sun_pillars.jpg")
plotRGB(so, 1, 2, 3, stretch="lin")

# Classifying the solar data

# 1. Get all the single values
singlenr <- getValues(so)

# 2. Classify
kcluster <- kmeans(singlenr, centers = 3)

# 3. Set values to a raster on the basis of so
soclass <- setValues(so[[1]], kcluster$cluster) # assign new values to a raster object

cl <- colorRampPalette(c('yellow','black','red'))(100)
plot(soclass, col=cl)

# class 2: highest energy level
# class 3: lowest energy level
# class 1: medium energy level

frequencies <- freq(soclass)
tot = 2221440 # Tot pixel

percentages = frequencies * 100 / tot
# class 1: 21.21993
# class 3: 37.33349
# class 2: 41.44658



