# How to produce a multidimensional dataset

library(raster)
library(ggplot2)
library(viridis)
setwd("C:/lab/")

sen <- brick("sentinel.png")
sen
plot(sen)

# Stack the three bands of our interest without the fourth
sen2 <- stack(sen[[1]], sen[[2]], sen[[3]])
plot(sen2)

# How to extract with a single prompt the correlation between the three bands
pairs(sen2)

## PCA (Principal Component Analysis)

# Create a random number of samples from sen2 pixels (can't use directly the image for PCA)
sample <- sampleRandom(sen2, 10000)

# Calculate the PCA
pca <- prcomp(sample)

# variance explained
summary(pca)

# Principal components map
pci <- predict(sen2, pca, index=c(1:2))

plot(pci[[1]])

# ggplot
pcid <- as.data.frame(pci[[1]], xy=T)
pcid

ggplot() +
geom_raster(pcid, mapping = aes(x=x, y=y, fill=PC1)) +
scale_fill_viridis(option="viridis")























