%%% Uppgift 6
g=tf(45,[1 10 9 0]);
K = 5.5; %Ändra förstärkningen för att få bort självsvängningar
Flead = 0.27*tf([1.24 1],[0.07*1.24 1]);

c = [0.3:0.1:5];
w = [1:0.1:100];
h = 1;
d = 0.2;
dfplot('dfreldz',[d,h],c,Flead*K*g,w)

%Vi får en skärning vid C = 0.6 och w = 3. Blir en skärning vid samma
%frekvens med ett högre C.

%Vi lär förmodligen bara observera den med C = 0.6 och w = 3.