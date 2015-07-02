function [ gaussPlot ] = buildFacePlane(  )
%Function to build Gauss probability plane 
% to detect skin color on image 
%   Output Gauss probability matrix

%% Read Samples
[cb1, cr1] = toCbCr('Faces/1.png');
[cb2, cr2] = toCbCr('Faces/2.png');
[cb3, cr3] = toCbCr('Faces/3.png');
[cb4, cr4] = toCbCr('Faces/4.png');
[cb5, cr5] = toCbCr('Faces/5.png');
[cb6, cr6] = toCbCr('Faces/6.png');
[cb7, cr7] = toCbCr('Faces/7.png');
[cb8, cr8] = toCbCr('Faces/8.png');
[cb9, cr9] = toCbCr('Faces/9.png');
[cb10, cr10] = toCbCr('Faces/10.png');
[cb11, cr11] = toCbCr('Faces/11.png');
[cb12, cr12] = toCbCr('Faces/12.png');
[cb13, cr13] = toCbCr('Faces/13.png');
[cb14, cr14] = toCbCr('Faces/14.png');
[cb15, cr15] = toCbCr('Faces/15.png');
[cb16, cr16] = toCbCr('Faces/16.png');
[cb17, cr17] = toCbCr('Faces/17.png');

tcbAll = [cb1 cb2 cb3 cb4 cb5 cb6 cb7 cb8 cb9 ... 
   	cb10 cb11 cb12 cb13 cb14 cb15 cb16 cb17];
tcrAll = [cr1 cr2 cr3 cr4 cr5 cr6 cr7 cr8 cr9 ...
      cr10 cr11 cr12 cr13 cr14 cr15 cr16 cr17];
  
%% Remove Shades of Black  
 N = length(tcbAll);
 crcounter = 1;
 cbcounter = 1;
 for i = 1:N
     if(tcrAll(i) ~= 255)
        crAll(crcounter) = tcrAll(i);
        crcounter= crcounter + 1;
     end
     if(tcrAll(i) ~= 255)
        cbAll(cbcounter) = tcbAll(i);
        cbcounter= cbcounter + 1;
     end
 end
 
 N = length(cbAll);
 
 %% Calculate histogram
 
 skinPlane = zeros(256,256);
 for i = 1:N
     skinPlane(cbAll(i), crAll(i)) = skinPlane(cbAll(i), crAll(i)) + 1;
 end
 
 [indr,indc]=find(skinPlane == max(max(skinPlane)));
 skinPlane(indr, indc) = 0;

%  surf(skinPlane);
%  figure
 crMean = mean(crAll);
 cbMean = mean(cbAll);
 
 %% Build Gauss Plot
 
 crossCov = cov(double(cbAll), double(crAll));
 gaussPlot = zeros(256,256);
 for i = 1:255
     for j = 1:255
         gaussPlot(i,j) = exp((-0.5).*([(i - cbMean);(j - crMean)]')*inv(crossCov)*[(i - cbMean);(j - crMean)]);
     end
 end

end

