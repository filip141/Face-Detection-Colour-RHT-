clear all;close all;

warning off;

%% Variables

maxEllipse = 140;
minEllipse = 60;


%% Read Image and Preprocessing 
coins = imread('taczka.jpg', 'JPG');
rg = rgb2gray(coins);
inImage = wiener2(rg,[70 70]);
edgeim = edge(inImage, 'canny', [0.15 0.2]);

%% Find Edges
[Ex Ey] = find(edgeim);
pix = [Ex Ey];
num = size(pix,1);

%% Choose Random Points

[ sizeh sizew ] = size(edgeim);
acc = zeros(sizeh, sizew);
counter = 0;
% imagesc(fliplr(edgeim))
% figure
% hold on
while counter<3*num
    points = [];
    points = round(rand(1,3)*num + 0.5);
    p1 = pix(points(1),:);
    p2 = pix(points(2),:);
    p3 = pix(points(3),:);
    if(checkPoints(p1,p2,p3,maxEllipse,minEllipse))
        acc = findEllipse(pix, points, edgeim, acc);
    end
   counter = counter + 1;  
end
