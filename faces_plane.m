function [ probaIm ] = faces_plane( smplim )  
%Function creates 1 0 mask for skin regions
%   Output 1 0 Mask
%   INPUT image

%% Read Image and convert to yCbCr
    sample = smplim;
    chromaSmpl = rgb2ycbcr(sample);
    %figure
    %imagesc(sample);
    %figure
    %imagesc(chromaSmpl);
%% Build Probabilistic Color Plane

    cbSmpl = chromaSmpl(:,:,2);
    crSmpl = chromaSmpl(:,:,3);
    [sizeh sizew] = size(crSmpl);
    [gaussPlane] = buildFacePlane();
    probaIm = zeros(sizew, sizeh);
    for i = 1:sizeh
        for j = 1:sizew
            probaIm(i,j) = gaussPlane(cbSmpl(i,j),crSmpl(i,j));
        end
    end
    %figure
    %surf(gaussPlane);
    %figure
    %colormap(gray(256))
    % imagesc(probaIm);
    % figure

%% Build 1 0 Mask by finding extremum 

    iter = 1;
    counter = 0.75;

    while counter > 0
    numPix = 0;
    for i = 1:sizeh
        for j = 1:sizew
            if(probaIm(i,j)>counter)
                numPix= numPix + 1;
            end
        end
    end
    counter = counter - 0.05;
    Pix(iter) = numPix;
    iter = iter + 1;
    end

    CounterVec = [0.75:-0.05:0];
    CounterVec = CounterVec(1:end-1);

    % plot(CounterVec, Pix);

    diffPix = diff(Pix);
    diffPix = [0 diffPix];
    [maxim ind] = max(diffPix);
    % figure
    % plot(CounterVec, diffPix);
    for i = 1:sizeh
        for j = 1:sizew
            if(probaIm(i,j)>CounterVec(ind-1))
                probaIm(i,j) = 1;
                numPix= numPix + 1;
            else
                probaIm(i,j) = 0;
            end
        end
    end

    % figure
    % colormap(gray(256))
    % imagesc(probaIm);
end