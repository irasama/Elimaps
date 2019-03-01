clear all
clc
close all
%% 
pathuseM2014 = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2014Recortado.tif';
pathuseM2015 = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo//Elimapas/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2015Recortado.tif';
%pathuseM2014 = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2014Recortado.tif';
%pathuseM2015 = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/MapasUsos2-20190225T170524Z-001/MapasUsos2/LandCover2015Recortado.tif';

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
path = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_Landsat2013';
%path = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/Mapas Aplicacion ALEXI-DisALEXI/2013/ImagenesTIFF_ET_Landsat2013';
[data13Land,name13Land]=importElimaps(path);
name13Land=cellstr(name13Land);
datesName=char(name13Land);
datesName=datesName(:,5:11);
dates=str2num(datesName);
Year=floor(dates/1000);
DOY = floor(rem(dates/1000,1)*1000);
[Month,Day]=askDAY(DOY,Year);
date13Land=datenum(Year,Month,Day,0,0,0);

figure
[n,m,z]=size(data13Land);
for i=1:z
    subplot(ceil(z^(1/2)),ceil(z^(1/2)),i);imagesc(data13Land(:,:,i));xlabel(datesName(i,1:7))
    ylabel(datestr(date13Land(i),'mmm'))
    set(gca, 'XTick', []);set(gca, 'YTick', []);
end

%% MASK basin
pathmask = '/home/ana/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/LimitesCuencaFinales-20190226T204536Z-001/LimitesCuencaFinales/';
%pathmask = '/home/anandreum/MEGA/Trabajo/Articulos/Review/2018_TesisEli/MartinGonzalo/Elimapas/LimitesCuencaFinales-20190226T204536Z-001/LimitesCuencaFinales/';

maskyear = 'Cuenca2014.tif';
basin = imread([pathmask maskyear]);basin=single(basin);
io=basin==255;basin(io)=NaN;
basin=repmat(basin,[1 1 25]);
data13Land_basin=data13Land.*basin;

%% map of uses for the basin

use = single(imread(pathuseM2014));
uses_basin=basin(:,:,1).*use;

figure
f=imagesc(uses_basin)
set(f,'AlphaData',~isnan(uses_basin))
colormap(hsv(11))
colorbar('Ticks',[1,2,3,4,5,6,7,8,9,10,11],...
         'TickLabels',{'Dehesa','Conifers','Scrubs','Mix forest','Olives'...
         'Water','Urban','Crops','Grassland','Ground','Unclassified'})
     
figure
[n,m,z]=size(data13Land);
for i=1:z
    subplot(ceil(z^(1/2)),ceil(z^(1/2)),i);imagesc(data13Land_basin(:,:,i));xlabel(datesName(i,1:7))
    ylabel(datestr(date13Land(i),'mmm'))
    set(gca, 'XTick', []);set(gca, 'YTick', []);
end     

%% STATS JUST FOR THE BASIN
% stats per cover - not standardize
% [std,mean,median,max,min]=statsXcover(class,data,pathuse)
[stdOak,meanOak,~,maxOak,minOak,fOak]=statsXcover(1,data13Land_basin,pathuseM2014);
[stdCon,meanCon,~,maxCon,minCon,fCon]=statsXcover(2,data13Land_basin,pathuseM2014);
[stdScr,meanScr,~,maxScr,minScr,fScr]=statsXcover(3,data13Land_basin,pathuseM2014);
[stdMF,meanMF,~,maxMF,minMF,fMF]=statsXcover(4,data13Land_basin,pathuseM2014);
[stdOli,meanOli,~,maxOli,minOli,fOli]=statsXcover(5,data13Land_basin,pathuseM2014);
[stdCro,meanCro,~,maxCro,minCro,fCro]=statsXcover(8,data13Land_basin,pathuseM2014);
% there is just 2 pixels of crops inside the basin...maybe then it is
[stdGra,meanGra,~,maxGra,minGra,fGra]=statsXcover(9,data13Land_basin,pathuseM2014);
[stdGro,meanGro,~,maxGro,minGro,fGro]=statsXcover(10,data13Land_basin,pathuseM2014);
[stdUn,meanUn,~,maxUn,minUn,fUn]=statsXcover(11,data13Land_basin,pathuseM2014);

% FOR THE WHOLE PORTION WE HAVE
[stdOakA,meanOakA,~,~,~,~]=statsXcover(1,data13Land,pathuseM2014);
[stdConA,meanConA,~,~,~,~]=statsXcover(2,data13Land,pathuseM2014);
[stdScrA,meanScrA,~,~,~,~]=statsXcover(3,data13Land,pathuseM2014);
[stdMFA,meanMFA,~,~,~,~]=statsXcover(4,data13Land,pathuseM2014);
[stdOliA,meanOliA,~,~,~,~]=statsXcover(5,data13Land,pathuseM2014);
[stdCroA,meanCroA,~,~,~,~]=statsXcover(8,data13Land,pathuseM2014);
[stdGraA,meanGraA,~,~,~,~]=statsXcover(9,data13Land,pathuseM2014);
[stdGroA,meanGroA,~,~,~,~]=statsXcover(10,data13Land,pathuseM2014);
[stdUnA,meanUnA,~,~,~,~]=statsXcover(11,data13Land,pathuseM2014);

% proportion of the basin % of each use
pixB = [];
for i=1:11
    pixB(i,1)=area(use,basin(:,:,1),i,'yes');
end

% proportion of the image % of each use
pixI = [];
for i=1:11
    pixI(i,1)=area(use,basin(:,:,1),i,'nop');
end

figure
subplot(2,1,1)
%axes1 = axes('Parent',f2);
errorbar(date13Land,meanOak,stdOak,'b','LineWidth',2.5)
hold on
errorbar(date13Land,meanCon,stdCon,'g','LineWidth',2.5)
errorbar(date13Land,meanScr,stdScr,'r','LineWidth',2.5)
errorbar(date13Land,meanMF,stdMF,'c','LineWidth',2.5)
errorbar(date13Land,meanOli,stdOli,'m','LineWidth',2.5)
errorbar(date13Land,meanCro,stdCro,'y','LineWidth',2.5)
errorbar(date13Land,meanGra,stdGra,'k','LineWidth',2.5)
errorbar(date13Land,meanGro,stdGro,'color',[0.85 0.95 0.25],'LineWidth',2.5)
errorbar(date13Land,meanUn,stdUn,'color',[0 0.60 0.50],'LineWidth',2.5)
%l1 =legend('Oak','Conifer','Scrubs','Mix Forest', 'Olives', 'Crops', 'Grassland', 'Ground', 'Unclasif')
legendCell1 = {'Oak';'Conifer';'Scrubs';'Mix Forest';'Olives';'Crops';'Grassland';'Ground';'Unclasif'};
pixBS = [pixB(1:5);pixB(8:11)];
legendCell2 = cellstr(num2str(pixBS,'percent=%0.1f'))
legendCell3 = strcat(legendCell1, {' '}, legendCell2)
legend(legendCell3);
%set(legend,'FontSize',15);
xlim([735245 735583])
ylim([0 5.5])
datetick('x','mmm-yy')
title('not standard units - Martin Gonzalo','LineWidth',2.5,'FontSize',20);

%set(axes1,'FontSize',20,'LineWidth',2.5)
%set(legend,'LineWidth',2.5,'FontSize',20);

subplot(2,1,2)
%axes1 = axes('Parent',f3);
errorbar(date13Land,meanOakA,stdOakA,'b','LineWidth',2.5)
hold on
errorbar(date13Land,meanConA,stdConA,'g','LineWidth',2.5)
errorbar(date13Land,meanScrA,stdScrA,'r','LineWidth',2.5)
errorbar(date13Land,meanMFA,stdMFA,'c','LineWidth',2.5)
errorbar(date13Land,meanOliA,stdOliA,'m','LineWidth',2.5)
errorbar(date13Land,meanCroA,stdCroA,'y','LineWidth',2.5)
errorbar(date13Land,meanGraA,stdGraA,'k','LineWidth',2.5)
errorbar(date13Land,meanGroA,stdGroA,'color',[0.85 0.95 0.25],'LineWidth',2.5)
errorbar(date13Land,meanUnA,stdUnA,'color',[0 0.60 0.50],'LineWidth',2.5)
pixIS = [pixI(1:5);pixI(8:11)];
legendCell2 = cellstr(num2str(pixIS,'percent=%0.1f'))
legendCell3 = strcat(legendCell1, {' '}, legendCell2)
legend(legendCell3);
%set(legend,'FontSize',15);
xlim([735245 735583])
ylim([0 5.5])
datetick('x','mmm-yy')
title('not standard units - ALL basins','LineWidth',2.5,'FontSize',20);
%set(axes1,'FontSize',20,'LineWidth',2.5)
%set(legend,'LineWidth',2.5,'FontSize',20);

%%
[masked,nameUse]=maskvar(pathuseM2014, data13Land_basin,1);
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
