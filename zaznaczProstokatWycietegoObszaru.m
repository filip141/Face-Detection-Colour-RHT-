function zaznaczProstokatWycietegoObszaru(E, F, G, H)


for x = E(2) : H(2)
    hold on
    plot(x, E(1),'g')
end

for y = H(1) : G(1)
    hold on
    plot(H(2), y,'g')
end

for x = F(2) : G(2)
    hold on
    plot(x, F(1),'g')
end

for y = E(1) : F(1)
    hold on
    plot(E(2), y,'g')
end