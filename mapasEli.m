clear all
clc
close all
%% 
useM2014 = imread('/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2014Recortado.tif');
useM2015 = imread('/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2015Recortado.tif');

%% files 2013
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_Landsat2013';
[data13Land]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_MODIS2013';          
[data13MOD]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_STARFM2013';          
[data13STARFM]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_PET2013';          
[data13PET]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_ET_Landsat2014';
[data14Land]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_ET_MODIS2014';          
[data14MOD]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_ET_STARFM2014';          
[data14STARFM]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_PET2014';          
[data14PET]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_ET_Landsat2015';
[data15Land]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_ET_MODIS2015';          
[data15MOD]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_ET_STARFM2015';          
[data15STARFM]=importElimaps(path);
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_PET2015';          
[data15PET]=importElimaps(path);
