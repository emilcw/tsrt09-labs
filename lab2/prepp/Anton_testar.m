%%%Anton testar
%G�ra ett bandpassfilter som precis r�r kravet delta_G 
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
%Vi vill att allt �ver 4hz f�r max ha en f�st�rkning p� 3db. designar
%d�rf�r ett lp filter med brytpunkt p� 4hz. Kanske vill h�ja b f�r att
%f�rs�kra sig om att �ver 4hz �r helt <3db.
sigma(WU)







%WS = [W_help(0.70, inf,6,1), 0; W_help(0.70, inf,6,1), 0]; 
%ID�: V�ljs b till 6rad/s ty vi vill ha 6 som brytpunkt. Ett filter av
%typen l�gpass som inventerat blir ett h�gpass dvs den trycker ner
%frekvenser fram till 6rad/s enligt v�ra krav. 
%a,c v�ljs f�r att f� en "skarp" lp utseende. 
% K v�ljs till 0.70 pga att k=1 var 3db f�rstr�kning vid l�gpass delen. 
%detta vill vi s�nka till 0db s� mag2db(-3db) = 0.70