for i = 0:10000 % Nombre de test à faire
    M = env(); % On recré un mur à chaque fois
    i = 1;
    while i < 4000 % On parcourt le mur
        v = M(i);
        longueur = 0;
        while M(i) == v % Tant qu'il n'y a pas de changement de teinte
            i = i+1;
            longueur = longueur + 1;
            if i> 3999 % Si on finis de parcourir c'est bon
                break
            end
        end
        if i < 3999 % Si au moment du changement de teinte
            % La bande précèdente ne respecte pas le c.d.c
            % (10<longueur<100)
            if longueur < 10 || longueur > 100 
                i
                longueur
                % On affiche la longueur + l'indice correspondant
                break
            end
        end
    end
end
