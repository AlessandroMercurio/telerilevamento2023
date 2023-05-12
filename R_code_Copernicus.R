# R code for downloading and visualising Copernicus data

library(raster)
install.packages("ncdf4") # to upload copernicus data
library(ncdf4)
library(ggplot2)
library(viridis)
setwd("C:/lab")

ssoil <- raster("c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")
ssoil
plot(ssoil)

#create a dataframe to better use ggplot
scd <- as.data.frame(ssoil, xy=T)

ggplot() +
geom_raster(scd, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))+
ggtitle("Soil Moisture from Copernicus")

# Cropping an image
ext <- c(23, 30, 62, 68) # define the extention
sc.crop <- crop(ssoil, ext)

# Excercise: plot via ggplot the cropped image
scd.crop <- as.data.frame(sc.crop, xy=T)

ggplot() +
geom_raster(scd.crop, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))+
ggtitle("Soil Moisture cropped")+
scale_fill_viridis(option="cividis")

# head() mostra solo i primi elementi 
# names() mostra il nome di un dataset
# source() per caricare uno script da un file di testo
