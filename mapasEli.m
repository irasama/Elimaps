clear all
clc
close all
%% 
%pathuseM2014 = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2014Recortado.tif';
%pathuseM2015 = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2015Recortado.tif';
pathuseM2014 = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2014Recortado.tif';
pathuseM2015 = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2015Recortado.tif';

%2014
% 1 Dehesa
% 2 Conifers
% 3 Scrub
% 4 mixed_forest // coniferous_dehesa,mixed_forest - 2015
% 5 Olives
% 6 Water
% 7 urban
% 8 Crops // Non_irrigated_arable_land,Crops - 2015
% 9 Grassland
% 10 Ground
% 11 unclassified


%% files ET Landsat 2013
%path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_Landsat2013';
path = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_Landsat2013';
[data13Land,name13Land]=importElimaps(path);
name13Land=cellstr(name13Land);
datesName=char(name13Land);
datesName=datesName(:,5:11);
dates=str2num(datesName);
Year=floor(dates/1000);
DOY = floor(rem(dates/1000,1)*1000);
[Month,Day]=askDAY(DOY,Year);
date13Land=datenum(Year,Month,Day,0,0,0);

%% MASK basin
pathmask = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/LimitesCuencaFinales-20190226T204536Z-001/LimitesCuencaFinales/';
maskyear = 'Cuenca2014.tif';
basin = imread([pathmask maskyear]);basin=single(basin);
io=basin==255;basin(io)=NaN;
basin=repmat(basin,[1 1 25]);
data13Land_basin=data13Land.*basin;

%% masked by use
% uses on the basin
use = single(imread(pathuseM2014));
uses_basin=basin(:,:,1).*use;
close all
figure
f3=imagesc(uses_basin)
set(f3,'AlphaData',~isnan(uses_basin))
colorbar('Ticks',[1,2,3,4,5,6,7,8,9,10,11],...
         'TickLabels',{'Dehesa','Conifers','Scrubs','Mix forest','Olives'...
         'Water','Urban','Crops','Grassland','Ground','Unclassified'})

%% crop ??

f1=figure
[n,m,z]=size(data13Land);
for i=1:z
    subplot(ceil(z^(1/2)),ceil(z^(1/2)),i);imagesc(data13Land(:,:,i));xlabel(datesName(i,1:7))
    ylabel(datestr(date13Land(i),'mmm'))
    set(gca, 'XTick', []);set(gca, 'YTick', []);
end

% stats per cover - not standardize
% [std,mean,median,max,min]=statsXcover(class,data,pathuse)
[stdOak,meanOak,median,maxOak,minOak,pixOak,fOak]=statsXcover(1,data13Land_basin,pathuseM2014);
[stdCon,meanCon,median,maxCon,minCon,pixCon,fCon]=statsXcover(2,data13Land_basin,pathuseM2014);
[stdScr,meanScr,median,maxScr,minScr,pixScr,fScr]=statsXcover(3,data13Land_basin,pathuseM2014);
[stdMF,meanMF,median,maxMF,minMF,pixMF,fMF]=statsXcover(4,data13Land_basin,pathuseM2014);
[stdOli,meanOli,median,maxOli,minOli,pixOli,fOli]=statsXcover(5,data13Land_basin,pathuseM2014);
[stdCro,meanCro,median,maxCro,minCro,pixCro,fCro]=statsXcover(8,data13Land_basin,pathuseM2014);
% there is just 2 pixels of crops inside the basin...maybe then it is
%also interesting to don't just present the basin? 
[stdGra,meanGra,median,maxGra,minGra,pixGra,fGra]=statsXcover(9,data13Land_basin,pathuseM2014);
[stdGro,meanGro,median,maxGro,minGro,pixGro,fGro]=statsXcover(10,data13Land_basin,pathuseM2014);
[stdUn,meanUn,median,maxUn,minUn,pixUn,fUn]=statsXcover(11,data13Land_basin,pathuseM2014);
close all
f2=figure
errorbar(date13Land,meanOak,stdOak,'b')
hold on
errorbar(date13Land,meanCon,stdCon,'g')
errorbar(date13Land,meanScr,stdScr,'r')
errorbar(date13Land,meanMF,stdMF,'c')
errorbar(date13Land,meanOli,stdOli,'m')
errorbar(date13Land,meanCro,stdCro,'y')
errorbar(date13Land,meanGra,stdGra,'k')
errorbar(date13Land,meanGro,stdGro,'color',[0.85 0.95 0.25])
errorbar(date13Land,meanUn,stdUn,'color',[0 0.95 0.25],'LineWidth',2.5)
legend('Oak','Conifer','Scrubs','Mix Forest', 'Olives', 'Crops', 'Grassland', 'Ground', 'Unclasif')
datetick('x','mmm-yy')
title('not standard units','FontSize',15)


%%
[masked,nameUse]=maskvar(pathuseM2014, data13Land_basin,8);
f4=figure
for i=1:z
    subplot(ceil(z^(1/2)),ceil(z^(1/2)),i);imagesc(masked(:,:,i));xlabel(datesName(i,1:7))
    ylabel(datestr(date13Land(i),'mmm'))
    set(gca, 'XTick', []);set(gca, 'YTick', []);
end
annotation(f4,'textbox',...
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
