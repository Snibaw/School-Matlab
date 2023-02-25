function plotSimOut(Sortie1,Sortie2)
hold on
plot(Sortie1);
plot(Sortie2);
hold off
title('Output of both photoreceptors for y = 500 at a speed of 0.5 m/s')
xlabel('t (s)')
ylabel('Sortie1 (blue), Sortie2 (red)')
end

