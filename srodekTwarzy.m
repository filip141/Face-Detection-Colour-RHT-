% Funckja wyszukuje srodek komponentu o zadanym indeksie.

function [srodek_wys, srodek_szer] = srodekTwarzy(zdjecie, numer)

zdjecie = zdjecie(:,:,1);
[wysokosc, szerokosc] = size(zdjecie);

k = 0;
w = 0;
iloscPikseli = 0;
for i= 2 : wysokosc
    for j = 2 : szerokosc
        
        if(zdjecie(i,j) == numer)         
            k = k+i;
            w = w+j;
            iloscPikseli = iloscPikseli+1;
        end
    end
end

srodek_wys = floor(k/iloscPikseli);
srodek_szer = floor(w/iloscPikseli);
