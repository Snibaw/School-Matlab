function A = matrice()
%-------------------------------------------------------------------------
%Création de la table de correspondance (matrice A)
deltarho = 3.8; % largeur à mi-hauteur de la gaussienne
step = 0.005; % Résolution de la matrice A
sigma2 = deltarho^2/(8*log(2)); % Utile pour créer la "matrice A" (Variance) (Largeur 95%)²
taille_A = ceil(2.6*deltarho/step); % arrondi au dessus de la taille
A = zeros(taille_A);
for i = 1:taille_A
    phi = (i-ceil(taille_A/2))*step; % position azimutale dans le champ visuel du photorécepteur
    v(i)=erf(phi/sqrt(2*sigma2)); % fonction d'erreur (primitive gaussienne)
end
max = abs(v(1)-v(taille_A)); % diffèrence entre 2 points extrêmes
for i = 1:taille_A
    for j= 1:i
        A(i,j) = abs(v(i)-v(j))/max; % normalisation de la matrice
    end
end




