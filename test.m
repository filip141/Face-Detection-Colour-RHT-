close all; clear all;
mask = ones(10,10);
K2 = 5;

%% Read Image
im = imread('Dom_twarze/Sample7.jpg');
bim = faces_plane(im);

%% Find Izolated Areas
[indexBlackImage, borders] = wytnijKawalki(bim);
[blockNumer numberOfParameters] = size(borders);
areaMaxiumus = [];


%% Find Elliptic areas
for i = 1:blockNumer
    areaMaxiumus(i) = buildEllipses( indexBlackImage(borders(i,2):borders(i,5), borders(i,3) : borders(i,4)), 140, 80 )
end

%% Vector with ellipse votes ( Read More RHT )
maxEllipseVotes = max(max(areaMaxiumus));

%% Draws rectangle on area with high probability to be ellipse
for i = 1:blockNumer
    %You can use treshhold depend on max vote calue for example
    %0.4*maxEllipseVotes or fixed number 5
    if areaMaxiumus(i) > 0.4*maxEllipseVotes
        sampleIm = im(borders(i,2):borders(i,5), borders(i,3) : borders(i,4),:);
        [ sizeh, sizew, ~ ] = size(sampleIm);
        sampleIm(2:7,:,:) = 200;
        sampleIm((sizeh - 7):(sizeh - 2),:,:) = 200;
        sampleIm(:,2:7,:) = 200;
        sampleIm(:,(sizew - 7):(sizew - 2),:) = 200;
        im(borders(i,2):borders(i,5), borders(i,3) : borders(i,4),:) = sampleIm;
    end
end

figure 
imagesc(im)