function [std,mean,median,max,min,h]=statsXcover(class,data,pathuse)
% give you some stats regarding the use
use = imread(pathuse);
[m,n,z]=size(data);
io=use==class;
mask=ones(m,n).*NaN;mask(io)=1;

std=ones(z,1).*NaN;
mean=ones(z,1).*NaN;
max=ones(z,1).*NaN;
min=ones(z,1).*NaN;
median=ones(z,1).*NaN;
dataHist=[];

h=figure
for i=1:z
    std(i,1)=nanstd(nanstd(data(:,:,i).*mask));
    mean(i,1)=nanmean(nanmean(data(:,:,i).*mask));
    max(i,1)=nanmax(nanmax(data(:,:,i).*mask));
    min(i,1)=nanmin(nanmin(data(:,:,i).*mask));
    median(i,1)=nanmedian(nanmedian(data(:,:,i).*mask));
    dataV=data(:,:,i).*mask;dataV=dataV(:);
    histogram(dataV,50);hold on
end

if class==1; title('Dehesa')
elseif class==2; title('Conifers')
elseif class==3;title('Scrub')
elseif class==4;title('mixed_forest')
elseif class==5;title('Olives')
elseif class==8;title('Crops')
elseif class==9;title('Grasslanda')
elseif class==10;title('Ground')
end

