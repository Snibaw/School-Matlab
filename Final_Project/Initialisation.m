%-------------------------------------------------------------------------
%Initialisation :

x = 0; % Abscisse à t = 0
y = 500; % Ordonnée tout au long du programe
vitesse = 500; % Vitesse du robot
MurComplet = env();
A = matrice(); 
fEchantillonage = 2000;
[Y,U] = butter(2,[20 116]/(fEchantillonage/2),'bandpass'); % Coefficients du filtre passe-bande, 2000 est la fréquence d'échantillonnage
% Y numérateur, U dénominateur