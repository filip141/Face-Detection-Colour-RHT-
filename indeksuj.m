%% Funkcja indeksuj ma na celu wyszukanie zamkniêtych bia³ych obszarów.
% Ka¿demu takiemu obszarowi zostaje przypisany inny indeks.
% Funckja sk³ada siê z 3 etapów. 

% k - ilosc wykorzytsanych indeksow w etapie I

% tablica - sklada sie z 3 wektorow. 
%   nr tablicy oraz 1 wektor to 'klucz' - wyjasnie na zywo :)
%   2 wektor to indkes, któremu odpowiadaj¹ wszystkie nr tablicy - dzieki
%   temu komponent laczy sie z kilku kawalkow w jedna calosc
%   3 wektor to uporzadkowane od najwiekszego do najmniejszego nr indeksow
%   dla kazdego komponentu


%% Etap I 
%   dla ka¿dej napotkanej '1' na obrazie sprawdza piksel nad sob¹
%   oraz po lewej stronie i przypisuje mu odpowiedni¹ wartoœæ indeksu.

function [k,tablica,zdjecieBialoCzarne] = indeksuj(zdjecieBialoCzarne)

[wysokosc, szerokosc, o] = size(zdjecieBialoCzarne);

k = 2;
tablica = zeros(2000,3); 
for i= 2 : wysokosc
    for j = 2 : szerokosc
        
    if (zdjecieBialoCzarne(i,j) ~= 0)
        
        if (zdjecieBialoCzarne(i-1,j) == 0 && zdjecieBialoCzarne(i,j-1) == 0)
            zdjecieBialoCzarne(i,j) = k;
            k = k+1;
        end
        
        if (zdjecieBialoCzarne(i-1,j) ~= 0 && zdjecieBialoCzarne(i,j-1) == 0)
            zdjecieBialoCzarne(i,j) = zdjecieBialoCzarne(i-1,j);
        end
        
        if (zdjecieBialoCzarne(i-1,j) == 0 && zdjecieBialoCzarne(i,j-1) ~= 0)
            zdjecieBialoCzarne(i,j) = zdjecieBialoCzarne(i,j-1);
        end
        
        if (zdjecieBialoCzarne(i-1,j) ~= 0 && zdjecieBialoCzarne(i,j-1) ~= 0)
            zdjecieBialoCzarne(i,j) = zdjecieBialoCzarne(i-1,j);
            
            if(zdjecieBialoCzarne(i-1,j) ~= zdjecieBialoCzarne(i,j-1))
            tablica(zdjecieBialoCzarne(i-1,j),1) = zdjecieBialoCzarne(i,j-1);
            end
        end
            
    end
    end
end

for i = 2 : k
    if(tablica(i,1) == 0)
    tablica(i,1) = i;
    end
end

for i = 2 : k
    pomoc = i;
    w = 0;
    while(tablica(pomoc,1) ~= pomoc && w <200)
        pomoc = tablica(pomoc,1);
        
        if (tablica(pomoc,1) == i)
            tablica(pomoc,1) = pomoc;
        end
        w = w+1;
    end
    tablica(i,2) = pomoc;
end


for i= 2 : wysokosc
    for j = 2 : szerokosc
        
    if(zdjecieBialoCzarne(i,j) ~= 0);
    zdjecieBialoCzarne(i,j) = tablica(zdjecieBialoCzarne(i,j),2);
    end
    
    end
end

%% Etap II
%   Drugie kolorwanie. Algorytm nie jest doskona³y. Nale¿y powtórzyæ operacjê
%   z etapu I oko³o 10 razy, aby uzyskaæ porz¹dany efekt.
%   Dzieje siê tak, poniewa¿ w œrodku obrazu wsytêpuj¹ dziury i uk³ad
%   komponentu komplikuje siê.

for z=1:10

for i= 2 : wysokosc
    for j = 2 : szerokosc
        
        if (zdjecieBialoCzarne(i-1,j) ~= 0 && zdjecieBialoCzarne(i,j-1) ~= 0)
            if(zdjecieBialoCzarne(i-1,j) ~= zdjecieBialoCzarne(i,j-1))
            tablica(zdjecieBialoCzarne(i-1,j),1) = zdjecieBialoCzarne(i,j-1);
            end
        end
    end
end

for i = 2 : k
    if(tablica(i,1) == 0)
    tablica(i,1) = i;
    end
end

for i = 2 : k
    pomoc = i;
    w = 0;
    while(tablica(pomoc,1) ~= pomoc && w <200)
        pomoc = tablica(pomoc,1);
        
        if (tablica(pomoc,1) == i)
            tablica(pomoc,1) = pomoc;
        end
        w = w+1;
    end
    tablica(i,2) = pomoc;
end


for i= 2 : wysokosc
    for j = 2 : szerokosc
        
    if(zdjecieBialoCzarne(i,j) ~= 0);
    zdjecieBialoCzarne(i,j) = tablica(zdjecieBialoCzarne(i,j),2);
    end
    
    end
end
end

%% Etap III
% Sortowanie wartosci komponentu. Tworzymy now¹ tablicê do przechowywania
% wszystkich oryginalnych wartoœci z pierwotnej tablicy, aby nastêpnie je
% posortowaæ i zwróciæ w³aœciwy wynik.

tablicaNowa = zeros(2000,4); 
tablicaNowa(:,1) = tablica(:,1);
tablicaNowa(:,2) = tablica(:,2);
tablicaNowa(:,3) = sort(tablica(:,2));

m = 0;

for i = 2 : 2000
    if(abs(tablicaNowa(i-1,3)-tablicaNowa(i,3)) ~= 0)
        tablicaNowa(i-1,4) = m;
        m = m+1;
    end
    if(abs(tablicaNowa(i-1,3)-tablicaNowa(i,3)) == 0)
        tablicaNowa(i-1,4) = m;
    end
    if(i == 500)
        tablicaNowa(i,4) = m;
    end
end

for i = 1 : 2000
   for j = 1 : 2000 
    if(tablicaNowa(i,2) == tablicaNowa(j,3))
        if (tablicaNowa(j,3) == 0)
            tablica(i,3) = tablicaNowa(j,4);
        else
        tablica(i,3) = max(tablicaNowa(:,4))+1 - tablicaNowa(j,4);
        end
    end
   end
end

for i= 2 : wysokosc
    for j = 2 : szerokosc
        
    if(zdjecieBialoCzarne(i,j) ~= 0);
    zdjecieBialoCzarne(i,j) = tablica(zdjecieBialoCzarne(i,j),3);
    end
    
    end
end




    