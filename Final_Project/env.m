function Mur = env()
%-------------------------------------------------------------------------
%Création de l'environnement
tailleMur = 4000; %Le mur a une taille de 4m = 4000mm
indice = 1; %Premier indice du vecteur qui correspond à x = 0 du mur
indiceprec = 1; % Facilite l'attribution des valeurs du Mur
tailleBande = 1; % Permet de savoir si la bande précedante > 100 mm ou < 10 mm
randomprec = -1; % Empêche l'attribution de deux valeurs identiques à la suite avec le random
while indice < tailleMur
    ecartFin = tailleMur - indice; % Nombre de mm restant entre la position x et la fin du mur
    if ecartFin < 10 && tailleBande < 100 - ecartFin %Si on a pas la place pour une bande et qu'on peut prolonger celle d'avant
        Mur(indiceprec:4000) = randomprec; % = Mur(indice:4000) = random. On prolonge la bande precedente jusqu'à la fin
        break % On stop le programme
    else
        if ecartFin < 10 && tailleBande > 100 - ecartFin % Si la dernière bande ne peut être prolonger (sinon taille > 100)
            indiceprec = tailleMur - randi([10,tailleBande-10]); % On empiète sur la dernière bande en en créant une nouvelle
            indice = tailleMur; % La bande va jusqu'à la fin du mur
        else
            indice = indice + randi([10, 100]); % Sinon programme "normal"
        end
        random = randi([0, 255]); %Choix de la teinte de la bande
        while random == randomprec % Empêcher deux bandes successives de même teinte
            random = randi([0, 255]);
        end
        Mur(indiceprec:indice) = random; % Ajout d'une bande grise
        % Actualisation des variables pour la prochaine boucle
        indiceprec = indice; 
        tailleBande = indice - indiceprec;
        randomprec = random;
    end
end
if length(Mur) > 4000
    Mur = Mur(1:4000); % On ne veut pas que le mur soit supérieur à 4000 mm
end
end