% Funckja ta ma na celu wyznaczenie elipsy na ka¿ym komponencie oraz
% wyznaczenie odpowiadajacej im maski dla calego obrazu.

% Korzystam tutaj z 3 innych funkcji:
%   - srodekTwarzy
%   - elipsa
%   - maskowanieElipsy

% Funkcja polega na wykorzystaniu 3 powy¿szych funkcji do utworzenia
% elipsy, maski i zaznaczeniu typowych punktow na obrazie. Operacja ta jest
% potwarzana dla kazdgo komponentu.

function [CalaMaska] = RysowanieElipsyZwracaMaske(zdjecie, kmax)

[wysokosc, szerokosc] = size(zdjecie);
CalaMaska = zeros(wysokosc,szerokosc);

for i = 1 : kmax(3)
    
[x0,y0]=srodekTwarzy(zdjecie,i);
iloscPikseli = ilePikseli(zdjecie, i);
    if(iloscPikseli>500)
        [punktA,punktC,punktB,punktD,x,y] = elipsa(zdjecie, i);
        [maska] = maskowanieElipsy(zdjecie, i);
        CalaMaska = CalaMaska + maska;
        
        % rysowanie elips i punktow
        hold on
        plot(punktA(2),punktA(1),'mo',punktB(2),punktB(1),'mo',punktC(2),punktC(1),'mo',punktD(2),punktD(1),'mo',y0,x0,'or')
        plot(y,x,'b')
    end
end
