library(raster)
library(ggplot2) # for ggplot graphs
library(patchwork) # multiframe with ggplot2
setwd("C:/lab/")

defor1 <- brick("defor1_.png")
defor2 <- brick("defor2_.png")

par(mfrow=c(2,1))
plotRGB(defor1, 1, 2, 3, stretch="lin")
plotRGB(defor2, 1, 2, 3, stretch="lin")

# unsupervised classification

# --------Classification of the 1992 image
# 1. Get all the single values
singlenr1 <- getValues(defor1)
singlenr1

# 2. Classify
kcluster1 <- kmeans(singlenr1, centers = 2)
kcluster1

# 3. Recreating an image
defor1class <- setValues(defor1[[1]], kcluster1$cluster)
plot(defor1class)

# class 1: bare soil
# class 2: forest

#------- Classification of the 2006 image
# 1. Get all the single values
singlenr2 <- getValues(defor2)
singlenr2

# 2. Classify
kcluster2 <- kmeans(singlenr2, centers = 2)
kcluster2

# 3. Recreating an image
defor2class <- setValues(defor2[[1]], kcluster2$cluster) # assign new values to a raster object
plot(defor2class)

# class 1: forest
# class 2: bare soil

# -----Multiframe

par(mfrow=c(2,1))
plot(defor1class)
plot(defor2class)

# -----Class percentages
frequencies1 <- freq(defor1class)
tot1 = ncell(defor1class)
percentages1 = frequencies1 * 100 /  tot1

# percent forest: 89.75 %
# percent bare soil: 10.25 %

frequencies2 <- freq(defor2class)
tot2 = ncell(defor2class)
percentages2 = frequencies2 * 100 /  tot2

# percent forest: 52.07 %
# percent bare soil: 47.93 %

#--- final table
cover <- c("Forest", "Bare soil")
percent1992 <- c(89.75, 10.25)
percent2006 <- c(52.07, 47.93)

percentages <- data.frame(cover,percent1992, percent2006)
percentages
View(percentages) # to see it as a real table

# let's plot them!
ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity", fill="white")

ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white")

p1 <- ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity", fill="white") +
ggtitle(" Year 1992")

p2 <- ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white")
ggtitle(" Year 2006")
p1+p2

#----same range! Do not lie with stats!

p1 <- ggplot(percentages, aes(x=cover, y=percent1992, color=cover)) + geom_bar(stat="identity", fill="white") +
ggtitle(" Year 1992 ") +
ylim(c(0,100))

p2 <- ggplot(percentages, aes(x=cover, y=percent2006, color=cover)) + geom_bar(stat="identity", fill="white") +
ggtitle(" Year 2006 ") +
ylim(c(0,100))

p1+p2

