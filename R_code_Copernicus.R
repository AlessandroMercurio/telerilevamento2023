# R code for downloading and visualising Copernicus data

library(raster)
install.packages("ncdf4") # to upload copernicus data
library(ncdf4)
library(ggplot2)
library(viridis)
setwd("C:/lab")

ssoil <- raster("~/Downloads/c_gls_SSM1km_202305090000_CEURO_S1CSAR_V1.2.1.nc")
ssoil
plot(ssoil)

ggplot() +
+ geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture))

# with viridis
ggplot() +
geom_raster(ssoil, mapping=aes(x=x, y=y, fill=Surface.Soil.Moisture)) +
scale_fill_viridis(option="magma")
