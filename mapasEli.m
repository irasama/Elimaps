clear all
clc
close all
%% 
pathuseM2014 = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2014Recortado.tif';
pathuseM2015 = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2015Recortado.tif';

% 1 Dehesa
% 2 Conifers
% 3 Scrub
% 4 mixed_forest
% 5 Olives
% 6 Water
% 7 urban
% 8 Crops
% 9 Grassland
% 10 Ground
% 11 unclassified

%% files ET Landsat 2013
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_Landsat2013';
[data13Land,name13Land]=importElimaps(path);
name13Land=cellstr(name13Land);
datesName=char(name13Land);
datesName=datesName(:,5:11);
dates=str2num(datesName);
Year=floor(dates/1000);
DOY = floor(rem(dates/1000,1)*1000);
[Month,Day]=askDAY(DOY,Year);
date13Land=datenum(Year,Month,Day,0,0,0);

f1=figure
[n,m,z]=size(data13Land);
for i=1:z
    subplot(ceil(z^(1/2)),ceil(z^(1/2)),i);imagesc(data13Land(:,:,i));xlabel(datesName(i,1:7))
    ylabel(datestr(date13Land(i),'mmm'))
    set(gca, 'XTick', []);set(gca, 'YTick', []);
end

% stats per cover - not standardize
% [std,mean,median,max,min]=statsXcover(class,data,pathuse)
[stdCrop,meanCrop,median,maxCrop,minCrop,fCrop]=statsXcover(8,data13Land,pathuseM2014);
[stdOak,meanOak,median,maxOak,minOak,fOak]=statsXcover(1,data13Land,pathuseM2014);
[stdCon,meanCon,median,maxCon,minCon,fCon]=statsXcover(2,data13Land,pathuseM2014);


f2=figure
errorbar(date13Land,meanCrop,stdCrop,'r-.')
hold on
errorbar(date13Land,meanOak,stdOak,'k-.')
errorbar(date13Land,meanCon,stdCon,'g-.')
legend('Crops','Oak','Conifer')

datetick('x','mmm-yy')

[masked,nameUse]=maskvar(pathuseM2014, data13Land,1);
f3=figure
for i=1:z
    subplot(ceil(z^(1/2)),ceil(z^(1/2)),i);imagesc(masked(:,:,i));xlabel(datesName(i,1:7))
    ylabel(datestr(date13Land(i),'mmm'))
    set(gca, 'XTick', []);set(gca, 'YTick', []);
end
annotation(f3,'textbox',...
    [0.4 0.95 0.26 0.028],...
    'String',{nameUse},...
    'FitBoxToText','on');

%% files ET Landsat 2014

%% Others
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_MODIS2013';          
% [data13MOD]=importElimaps(path);
% [n,m,z]=size(data13MOD);
% for i=1:z
%     figure
%     subplot(ceil(z^(1/2)),ceil(z^(1/2)),i);imagesc(data13MOD(:,:,i))
% end

% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_STARFM2013';          
% [data13STARFM]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_PET2013';          
% [data13PET]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_ET_Landsat2014';
% [data14Land]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_ET_MODIS2014';          
% [data14MOD]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_ET_STARFM2014';          
% [data14STARFM]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2014/ImagenesTIFF_PET2014';          
% [data14PET]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_ET_Landsat2015';
% [data15Land]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_ET_MODIS2015';          
% [data15MOD]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_ET_STARFM2015';          
% [data15STARFM]=importElimaps(path);
% path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2015/ImagenesTIFF_PET2015';          
% [data15PET]=importElimaps(path);
