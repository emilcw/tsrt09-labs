%%%Anton testar
%Göra ett bandpassfilter som precis rör kravet delta_G 
p0 =40;
delta_G = -s/(s + p0);
bodemag(1/delta_G)
% %a2 = 100;
% %b2 = 0.030;
% %b1 = 0.038;
% %a1 = 0.02;
% k1 = 1.5;
% a1 = 32;
% b1 = 16;
% c1 = 1;
% k2 = 2;
% a2 = 1;
% b2 = 0.6;
% c2 = 1;

k1 = 1.5;
a1 = 0.02;
b1 = 4;
c1 = 1;
k2 = 2;
a2 = 100;
b2 = 0.02;
c2 = 1;
WT = [W_help(1, inf, 40, 1), 0; W_help(1, inf, 40, 1), 0];

WT_filter = W_help(k1,a1,b1,c1)*W_help(k2,a2,b2,c2);
WT_test = [WT_filter, 0; WT_filter, 0];
%WT_test = W_help(k1,a1,b1,c1)*W_help(k2,a2,b2,c2);
%W_help(k1,a1,b1,c1)*W_help(k2,a2,b2,c2)
sigma(1/delta_G, WT_test,WT)
%%%






%WU = [inv(W_help(0.43, 0.5*8*pi, 8*pi, 1)), 0; inv(W_help(0.43, 2*8*pi, 8*pi, 1)), 0];
WU = [inv(W_help(1, 30, 8*pi, 0)), 0; inv(W_help(1, 30, 8*pi, 0)), 0]; 
%Vi vill att allt över 4hz får max ha en föstärkning på 3db. designar
%därför ett lp filter med brytpunkt på 4hz. Kanske vill höja b för att
%försäkra sig om att över 4hz är helt <3db.
sigma(WU)







%WS = [W_help(0.70, inf,6,1), 0; W_help(0.70, inf,6,1), 0]; 
%IDÉ: Väljs b till 6rad/s ty vi vill ha 6 som brytpunkt. Ett filter av
%typen lågpass som inventerat blir ett högpass dvs den trycker ner
%frekvenser fram till 6rad/s enligt våra krav. 
%a,c väljs för att få en "skarp" lp utseende. 
% K väljs till 0.70 pga att k=1 var 3db försträkning vid lågpass delen. 
%detta vill vi sänka till 0db så mag2db(-3db) = 0.70