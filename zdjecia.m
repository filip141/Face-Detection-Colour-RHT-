close all; clear all;

%% Wczytywanie obrazu

zdjecie = imread('Dom_twarze/Sample13.jpg');
figure
imagesc(zdjecie);


%% Konwersja z RGB -> YCbCr 

% zdjecie = rgb2ycbcr(zdjecie);
% figure
% imagesc(zdjecie);


%% Przypisawanie '1' -> twarz, '0' -> reszta

% czarne = myfun(zdjecie);

czarne = faces_plane( zdjecie ) ;

% figure
% imagesc(czarne);

%% Przypisanie indeksu 'k' ka¿demu zamkniêtemu obszarowi

[k,tabulka,Mapa] = indeksuj(czarne);
kmax = max(tabulka);

KoloroweTwarze = uint8(Mapa);

figure
imagesc(KoloroweTwarze);
imwrite(KoloroweTwarze,'Buziak','BMP')
% colormap(gray)


%% Nie dziala :(
% % %% Narysowanie elipsy na ka¿dym komponencie oraz
% % %  wyznaczenie odpowiadajacej im maski dla calego obrazu
% % 
% % % CalaMaska = RysowanieElipsyZwracaMaske(Mapa, kmax);
% % 
% % 
% % %% Wyznaczenie zawartosci komponentu w elipsie
% % 
% % % procent = jakiProcent(Mapa, CalaMaska, kmax);


%% Podzielenie obrazu na pojedyncze komponenty


j = 0;
for k = 1 : kmax(3)


    iloscPikseli = ilePikseli(Mapa, k);
    if iloscPikseli > 2000

        j = j+1;
        l = k;
        [pociete, A, B, C, D, E, F, G, H] = pocieteKawalki(Mapa, k);
        i = int2str(j);
        eval(['komponent' i ' = pociete;']);
       
    zaznaczProstokatWycietegoObszaru(E, F, G, H);
    end
end

% 
% for k = 1 : j
%     
%         
%         k = int2str(k);
%         eval(['imagesc(komponent' k ');']);
%         
% end
 
% figure
% subplot 231
% imagesc(KoloroweTwarze);
% subplot 232
% imagesc(komponent1);
% subplot 233
% imagesc(komponent2);
% subplot 234
% imagesc(komponent3);
% subplot 235
% imagesc(komponent4);


% rg = rgb2gray(komponent1);
% figure
% inImage = wiener2(komponent1,[70 70]);
% edgeim = edge(inImage, 'canny', [0.15 0.2]);
% imagesc(fliplr(edgeim))

