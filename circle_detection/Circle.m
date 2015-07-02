clear all;close all;
startRadi = 12;
endRadi = 40;
coins = imread('im2.jpg', 'JPG');
imagesc(coins)
rg = rgb2gray(coins);
edgeim = edge(rg, 'canny', [0.15 0.2]);
colormap(gray(256));
imagesc(edgeim)
[Ex Ey] = find(edgeim);
[sizeh sizew] = size(rg);
N = length(Ey);
hough = zeros(sizeh, sizew, endRadi - startRadi);
rr = startRadi:endRadi;
th = 0:pi/500:2*pi;
Na = length(th);
figure
for r = 1:(endRadi - startRadi)
    for i = 1:N
        x = Ex(i)+rr(r)*cos(th);
        y = Ey(i)+rr(r)*sin(th);
        x = ceil(x);
        y = ceil(y);
        for j = 1:Na
            if(x(j) < sizeh && y(j) < sizew && x(j) > 0 && y(j) > 0 )
                hough(x(j),y(j),r) = hough(x(j),y(j),r) + 1;
            end
        end
    end
end
[m ind]= max(max(max(hough)));
[row col] = find(hough(:,:,ind) == m);
x = row+rr(ind+10)*cos(th);
y = col+rr(ind+10)*sin(th);
x = ceil(x);
y = ceil(y);
for j = 1:Na
    coins(x(j),y(j),1) = 123;
    coins(x(j),y(j),2) = 255;
    coins(x(j),y(j),3) = 188;
end
imagesc(coins);
    