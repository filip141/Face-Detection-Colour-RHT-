function [ maxAccVal] = buildEllipses( rg, maxEll, minEll)
%Function search ellipses in image
%   INPUT BW IMAGE
%   OUTPUT ELLIPSE ACCUMULATOR

warning off;

%% Variables

maxEllipse = maxEll;
minEllipse = minEll;

mask = ones(10,10);
K2 = 5;
th = 0:pi/500:2*pi;
Na = length(th);

%% Read Image and Preprocessing 

inImage = wiener2(rg,[70 70]);
edgeim = edge(inImage, 'canny', [0.15 0.2]);

%% Find Edges
[Ex Ey] = find(edgeim);
pix = [Ex Ey];
num = size(pix,1);

%% Choose Random Points

[ sizeh sizew ] = size(edgeim);
acc = zeros(sizeh, sizew);
angleA = zeros(sizeh, sizew);
angleB = zeros(sizeh, sizew);
counter = 0;
% imagesc(edgeim)
% figure
% hold on

% You can change x*num parameter to achieve better precision but it will
% generate more calculation time 
while counter<10*num
    points = [];
    points = round(rand(1,3)*num + 0.5);
    p1 = pix(points(1),:);
    p2 = pix(points(2),:);
    p3 = pix(points(3),:);
    if(checkPoints(p1,p2,p3,maxEllipse,minEllipse))
        [acc, angleA, angleB] = findEllipse(pix, points, edgeim, acc, angleA, angleB);
    end
   counter = counter + 1;  
end

%% Build meand plane

 [ sizeh sizew ]= size(acc);
    h = 1;
    for i = 6:10: sizeh-5
        k = 1;
        for j = 6:10:sizew-5  
            buf = acc((i - K2):(i + K2), (j - K2):(j + K2));
            buf = sum(sum(buf));
            angleBufA = angleA((i - K2):(i + K2), (j - K2):(j + K2));
            angleBufA = sum(sum(angleBufA));
            angleBufB = angleB((i - K2):(i + K2), (j - K2):(j + K2));
            angleBufB = sum(sum(angleBufB));
            meanAccum(k, h) = buf;
            if angleBufA > 1  
                meanAngleA(k, h) = angleBufA/(buf-1);
            end
            if angleBufB > 1 
                meanAngleB(k, h) = angleBufB/(buf-1);
            end
            k = k + 1;
        end
        h = h + 1;
    end
%     figure
%     surf(double(meanAccum))
    
%% Find Maxiumum in Accumulator
maxAccVal = max(max(meanAccum));
[indr,indc]=find(meanAccum == maxAccVal);

%% Find Ellipse Angles
finalAngleA = meanAngleA(indr,indc);
finalAngleB = meanAngleB(indr,indc);

%% If more then one maximum choose median
if length(finalAngleA) > 1
    angleArray = meanAngleA(indr,indc);
    angleVector = reshape(angleArray, 1, prod(size(angleArray)));
    angleVector = sort(angleVector);
    Nv = length(angleVector);
    finalAngleA = angleVector(round(Nv/2));
    [indr,indc]=find(meanAngleA == finalAngleA);
end

if length(finalAngleB) > 1
    angleArray = meanAngleB(indr,indc);
    angleVector = reshape(angleArray, 1, prod(size(angleArray)));
    angleVector = sort(angleVector);
    Nv = length(angleVector);
    finalAngleB = angleVector(round(Nv/2)); 
end

%% Draw Ellipse on image 

% x = indr*10 + finalAngleB*cos(th);
% y = indc*10 + finalAngleA*sin(th);
% x = ceil(x);
% y = ceil(y);
% for j = 1:Na
%     if ( x(j) > 0 && y(j) > 0)
%         rg(x(j),y(j),1) = 123;
%     end
% end
% % figure
% % imagesc(rg)
end

