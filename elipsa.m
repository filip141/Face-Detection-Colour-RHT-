% Na podstawie funkcji srodekTwarzy - wyznacza skrane srodkowe wspolrzedne
% komponentu. Elipsa wyznaczana jest na podstawie odleglosci od punktu
% A (czubek g³owy) do srodka twarzy.

function [punktA,punktC,punktB,punktD,x,y] = elipsa(zdjecie, numer)


[sWy, sSze] = srodekTwarzy(zdjecie,numer);
zdjecie = zdjecie(:,:,1);
[wysokosc, szerokosc] = size(zdjecie);

for i= 1 : sWy
    
        if(zdjecie(i,sSze) == numer)
            punktA = [i, sSze];
            break;
        end
end

for i= wysokosc: -1 :sWy
    
        if(zdjecie(i,sSze) == numer)
            punktC = [i, sSze];
            break;
        end
end

for j= 1 : sSze
    
        if(zdjecie(sWy,j) == numer)
            punktB = [sWy,j];
            break;
        end
end

for j= szerokosc : -1 : sSze 
    
        if(zdjecie(sWy,j) == numer)
            punktD = [sWy,j];
            break;
        end
end

a=abs(punktA(1)-sWy); % promien pionowy
b=a/2.5; % promien poziomy

% sWy,sSze - srodek elipsy

t=-pi:0.01:pi;
x=sWy+a*cos(t);
y=sSze+b*sin(t);


