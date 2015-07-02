function [ Cb,Cr ] = toCbCr( faceImage )
%Funtion changes RGB colors into YCbCr colors
%   Input : Face image
%   Output: CbCr color matrix in row

%% Read Sample Image and convert to yCbCr

normalIm = imread(faceImage, 'PNG');
chromaIm = rgb2ycbcr(normalIm);

%% Remove Shades of Black  

noBlack  = chromaIm(:,:,3);
[ sizeh, sizew ] = size(noBlack);
mask = ones(sizeh, sizew);
tmp = mean2(noBlack);
for i = 1:sizeh
    for j = 1:sizew
        if ( tmp > noBlack(i,j))
            mask(i,j) = 255;
        end
    end
end

chromaIm(:,:,1) = chromaIm(:,:,1) .* uint8(mask);
chromaIm(:,:,2) = chromaIm(:,:,2) .* uint8(mask);
chromaIm(:,:,3) = chromaIm(:,:,3) .* uint8(mask);

%% Convert to vector

Cb = chromaIm(:,:,2);
Cr = chromaIm(:,:,3);
Cb = reshape(Cb, 1, prod(size(Cb)));
Cr = reshape(Cr, 1, prod(size(Cr)));

end


