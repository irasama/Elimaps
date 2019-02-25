function [data,dataname]=importElimaps(path)
%import maps tif when giving the path
files = dir([path '/*.tif']);          
dataname = {files.name}';
map = imread([files(1).folder '/' files(1).name]);
[m,n]=size(map);
data = ones(m,n,length(files));
for i=1:length(files)
    map = imread([files(i).folder '/' files(i).name]);
    io=map==-9999; map(io)=NaN;
    data(:,:,i)=map;
end
