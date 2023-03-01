%%% Plotta de olika beskrivande funktionerna

c=0:0.001:100;

figure(1)
%Kubisk
plot(c,dfcube(c,3))
title("Kubisk")

figure(2)
% Mättning
plot(c,dfsat(c,[2,3]))
title("Mättning")

% Dödzon
figure(3)
plot(c,dfdeadz(c,[2,3]))
title("Dödzon")

figure(4)
% Relä med dödzon
%plot(c,dfreldz(c,[2,3]))
plot(c,dfreldz(c,[0.2,1]))
title("Relä med Dödzon")
