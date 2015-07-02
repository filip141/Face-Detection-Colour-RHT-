function zwracamy = myfun(zdjecie)  % wczytywanie zdjecia

cb = zdjecie(:,:,2);            % skladowa Cb
cr = zdjecie(:,:,3);            % skladowa Cr
[x,y] = size(cb);               % wielkosc macierzy

wyciete = zeros(x,y);           % macierz zer o odpowiedniej wielkosci


for i = 1 : x
    for j = 1 : y
                            % jesli spelniony prog detekcji (kolor twarzy) 
                            % - przypisz 1
        if ((cb(i,j) + 0.6*cr(i,j)) < 215) && ((cb(i,j) + 0.6*cr(i,j)) > 199) && (cr(i,j) > 138) && (cr(i,j) < 178)
            wyciete(i,j) = 1;
           
        end
    end
end

zwracamy = wyciete;