% zdjeciePoInedksowaniu - kazdy zamkniety obszar wykryty jako skora 
%                           ma swoj indeks ukryty w tabulka -> kmax(3)
% graniceObszarow - tablica 5 elemntowych wektorów, ktora zawiera wylacznie
%                   obszary przyjete do dalszej obrobki (odpowiednio duze)
%   graniceObszarow[1] = wartosc (indeks) tego obszaru
%   graniceObszarow[2] = y górnego lewego rogu,
%   graniceObszarow[3] = x górnego lewego rogu,
%   graniceObszarow[4] = x górnego prawego rogu,
%   graniceObszarow[5] = y dolnego lewego rogu,

function [zdjeciePoInedksowaniu, graniceObszarow] = wytnijKawalki(czarnoBiale)

[k,tabulka,zdjeciePoInedksowaniu] = indeksuj(czarnoBiale);
kmax = max(tabulka);

iloscPikseli = zeros(kmax(3),1);

for k = 1 : kmax(3)

    iloscPikseli(k) = ilePikseli(zdjeciePoInedksowaniu, k);

end

najwiekszyObszar = max(iloscPikseli);

%graniceObszarow = zeros(kmax(3),5);
j = 0;
kmax(3)
for k = 1 : kmax(3)
   
    if iloscPikseli(k) > najwiekszyObszar*0.3
        
        j = j+1;
        [pociete, A, B, C, D, E, F, G, H] = pocieteKawalki(zdjeciePoInedksowaniu, k);
        graniceObszarow(j,1) = k;
        graniceObszarow(j,2) = E(1);
        graniceObszarow(j,3) = E(2);
        graniceObszarow(j,4) = H(2);
        graniceObszarow(j,5) = F(1);
    end
end



