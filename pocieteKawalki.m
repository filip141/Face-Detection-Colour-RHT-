% Funkcja znajduje skrajne punkty kompnentu - niekoniecznie bêd¹ce na
% œrodku linii. Po prostu skrajnie wysuniête. Na podtsawie tych punktów
% zwraca wyciêty prostok¹t z tym komponentem z nadmiarem 10 pikseli.
% A,B,C,D - punkty skrajne kompnentu
% E,F,G,H - punkty wycietego prostakata


function [pociete, A, B, C, D, E, F, G, H] = pocieteKawalki(zdjecie, numer)

[wys, sze, o] = size(zdjecie);
A = 0;
B = 0;
C = 0;
D = 0;

% A
for i = 1 : wys
    for j = 1 : sze
        
        if zdjecie(i,j) == numer
            if i < 11
            A = [1,j];
            else
            A = [i-10,j];
            end
            break
        end
    end
    if A ~= 0
        break
    end
end

%B
for j = 1 : sze
    for i = 1 : wys
        
        if zdjecie(i,j) == numer
            if j < 11
            B = [i,1];
            else
            B = [i,j-10];
            end
            break
        end
    end
    if B ~= 0
        break
    end
end

%C
for i = wys : -1 : 1
    for j = 1 : sze
        
        if zdjecie(i,j) == numer
            if i > wys - 11
            C = [wys,j];
            else
            C = [i+10,j];
            end
            break
        end
    end
    if C ~= 0
        break
    end
end

%D
for j = sze : -1 : 1
    for i = 1 : wys
        
        if zdjecie(i,j) == numer
            if j > sze - 11
            D = [i,sze];
            else
            D = [i,j+10];
            end
            break
        end
    end
    if D ~= 0
        break
    end
end

E = [A(1), B(2)];
F = [C(1), B(2)];
G = [C(1), D(2)];
H = [A(1), D(2)];

odEF = F(1) - E(1);
odFG = G(2) - F(2);
odGH = G(1) - H(1);
odHE = H(2) - E(2);

wys = max([odEF, odGH]);
sze = max([odFG, odHE]);

pociete = zeros(wys, sze);

for i = 1 : wys
    for j = 1 : sze
    
        pociete(i,j) = zdjecie(E(1)+i-1, E(2)+j-1);
    end
end


% hold on
% imagesc(pociete)
% plot(A(2),A(1),'mo',B(2),B(1),'mo',C(2),C(1),'mo',D(2),D(1),'mo')
% plot(E(2),E(1),'bo',F(2),F(1),'bo',G(2),G(1),'bo',H(2),H(1),'bo')



