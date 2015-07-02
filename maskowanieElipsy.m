% Tworzy maskê dla elipsy bszaru o zadanym indeksie
% Korzysta z funkcji - elipsa

function [maska] = maskowanieElipsy(zdjecie, numer)

[punktA,punktC,punktB,punktD,x,y] = elipsa(zdjecie, numer);

[wysokosc, szerokosc] = size(zdjecie);

maska = zeros(wysokosc,szerokosc);

% tworzy obrêcz elpisy z '1'

for i = 1 : 629
    for j = 1 : wysokosc
        if (round(x(1,i)) == j)
            
            b = round(y(1,i));
            maska(j,b) = 1;
        end
    end
end

% wypelnia obrêcz elpisy '1'

for i = 1 : wysokosc
    for j = 1 : szerokosc - 2
    
        if(maska(i,j) == 1)
            if (maska(i,j+1) == 0)
                maska(i,j+1) = 1;      
            end
            if (maska(i,j+2) == 1)
                break      
            end
        end
    end
end

