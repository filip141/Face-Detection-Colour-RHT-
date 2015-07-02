function iloscPikseli = ilePikseli(zdjecie, numer)

[wysokosc, szerokosc, o] = size(zdjecie);

iloscPikseli = 0;
for i= 2 : wysokosc
    for j = 2 : szerokosc
        
        if(zdjecie(i,j) == numer)         
                   
            iloscPikseli = iloscPikseli+1;
        
        end
    end
end