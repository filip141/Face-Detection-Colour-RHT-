function procent = jakiProcent(Mapa, CalaMaska, kmax)

[wys,sze,o] = size(Mapa);
procent = zeros(kmax(3), 1);

for k = 1 : kmax(3)

ileProcent = zeros(wys, sze);

l = 0;
for i= 1 : wys
    for j = 1 : sze
        
        if(Mapa(i,j) == k)         
        ileProcent(i,j) = Mapa(i,j)*CalaMaska(i,j);
        l = l+1;
        end

    end
end


m = 0;
for i= 1 : wys
    for j = 1 : sze
        
        if(ileProcent(i,j) == k)         
        m = m+1;
        end

    end
end

procent(k,1) = m/l*100;

end



