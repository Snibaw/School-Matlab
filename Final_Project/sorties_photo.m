
%-------------------------------------------------------------------------
%Constantes utiles
deltarho = 3.8 % largeur à mi-hauteur de la gaussienne
deltaphi = 3.8 % Angle inter-récepteur
step = 0.005; % Résolution de la matrice A

%-------------------------------------------------------------------------
% Recherche de Theta_n: l’ensemble de bords contrastés du Mur
i = 1;
j = 1;
Theta_n = zeros(1,400); % 400 = max transistions possibles
Indice_B_C = zeros(1,400);
while i < 4000 % On parcourt l'ensemble des valeurs du Mur
    teinte = MurComplet(i);
    while MurComplet(i) == teinte
        i = i+1;
        if i > 3999
            break
        end
    end % i correspond à une transition, on calcule donc l'angle correspondant
    Theta_n(j) = atan2(-y,i-x)*180/pi;
    % On sauvegarde les indices des bords contrastés du Mur
    Indice_B_C(j)=i;
    j = j+1;
end
%-------------------------------------------------------------------------
%Sélection des angles de transistion dans le champs visuel du
%photorecepteur 1 et du photorecepteur 2
IndiceTheta1=Indice_B_C( (- 1.3*deltarho + deltaphi/2 - pi/2 <= Theta_n) & (Theta_n <= + 1.3*deltarho + deltaphi/2 - pi/2) );
IndiceTheta2=Indice_B_C((- 1.3*deltarho - deltaphi/2 - pi/2<= Theta_n) & (Theta_n <= + 1.3*deltarho - deltaphi/2 - pi/2) );
% Sauvegarde des valeurs correspondant aux angles précedents
Theta1 = Theta_n(IndiceTheta1);
Theta2 = Theta_n(IndiceTheta2);

% On "transforme" directement ces angles pour les utiliser comme indice
Theta1 = floor(abs(Theta1/step));
Theta2 = floor(abs(Theta2/step));

% Constantes utiles pour les conditions
tailleT1 = length(Theta1);
tailleT2 = length(Theta2);

%-------------------------------------------------------------------------
%Calcul des différentes sorties

Sortie1 = [0]; % Simulink n'accepte pas si Sortie1 est une constante
if tailleT1==0 % Si aucune nuance de teinte n'est detectée
    indice = min(4000,floor(x+y*tan(deltaphi/2)));
    Sortie1(1) = MurComplet(indice); % On prend la teinte en face de l'oeil
elseif tailleT1 ==1
    % Une seule nuance de teinte detectée, on calcule la sortie à partir de
    % la teinte précedente et la teinte suivante
    Sortie1(1) = MurComplet(IndiceTheta1-1)*A(Theta1,1) + MurComplet(IndiceTheta1)*A(end,Theta2);
else % Plus d'une nuance de teinte detectée
    % On calcule chaque sortie d'après la formule
    Sortie1(1) = MurComplet(IndiceTheta1(1))*A(Theta1(1),1) + MurComplet(IndiceTheta1(end))*A(end,Theta1(end));
    for i= 2:(tailleT1-1)
        Sortie1(1) = Sortie1(1) + MurComplet(IndiceTheta1(i))*A(Theta1(i+1),Theta1(i));
    end
end    

Sortie2 = [0];% Simulink n'accepte pas si Sortie1 est une constante
if(tailleT2 == 0) % Si aucune nuance de teinte n'est detectée
    indice = min(4000,floor(x+y*tan(deltaphi/2)));
    Sortie2(1) = MurComplet(indice); % On prend la teinte en face de l'oeil
elseif tailleT2 ==1
    % Une seule nuance de teinte detectée, on calcule la sortie à partir de
    % la teinte précedente et la teinte suivante
    Sortie2(1) = MurComplet(IndiceTheta2-1)*A(Theta2,1) + MurComplet(IndiceTheta2)*A(end,Theta2);
else % Plus d'une nuance de teinte detectée
    % On calcule chaque sortie d'après la formule
    Sortie2(1) = MurComplet(IndiceTheta2(1))*A(Theta2(1),1) + MurComplet(IndiceTheta2(end))*A(end,Theta2(end));
    for i= 2:(tailleT2-1)
        Sortie2(1) = Sortie2(1) + MurComplet(IndiceTheta2(i))*A(Theta2(i+1),Theta2(i));
    end
end    