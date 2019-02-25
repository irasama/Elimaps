function [masked,name]=maskvar(pathuse,data,class)
% masked the data regarding the class
use = imread(pathuse);
[m,n,z]=size(data);
io=use==class;
mask=ones(m,n).*NaN;mask(io)=1;
masked=ones(m,n,z).*NaN;

for i=1:z
    masked(:,:,i)=(data(:,:,i).*mask);
end

if class==1; name='Dehesa';
elseif class==2; name='Conifers';
elseif class==3;name='Scrub';
elseif class==4;name='mixed_forest';
elseif class==5;name='Olives';
elseif class==8;name='Crops';
elseif class==9;name='Grasslanda';
elseif class==10;name='Ground';
end