% Kodskelett till lösningar på förberedelseuppgifter
% Laboration: "Robust reglerdesign av JAS 39 Gripen"
close all

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Definitioner
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

s = tf('s');

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 1
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Läs!

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 2
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = 0.3;
k = 1;

G = 1/(1 + 0.3*s); 

figure(1)
bode(G)
title('Bodeplot G up1')


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 3
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Definitioner av S, T och Gwu, se kap. 6.1 i läroboken.
% feedback(A,B) ger överföringsmatrisen (I+A*B)^(-1)*A. Vad skall A, B vara
% för S, T och Gwu?
% Det kan vara bra att använda "minreal".

G  = eye(3)/s; % dummy
Fy = eye(3); % dummy

S = minreal(feedback(eye(3),G*Fy));%S mäter effekten av systemstörning på utsignalen w->y 
T = minreal(feedback(G,Fy)*Fy); %T mäter effekten av mätstörningar på utsignalen n ->y
Gwu = minreal(-feedback(Fy,G));%Mäter effekten av "process noice to control input" på utsignalen wu ->y



%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 4
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gör för hand! (Detta är en omfattande uppgift som tar tid.)

%|s(iw)|<a , w<6rad/s 
%där a är "så litet som möjligt"


%För "T" se anteckningar 
%|T(iw)|<= 1/(|delta_G(iw)|), DÄR delta_G=0.3
%|T(iw)|< 10db

%|T(iw)|<= 1/(|delta_G(iw)|), DÄR delta_G = -1/(1 + p0/s)
%p0=40 är "värsta" fallet.


%För Fy se anteckningar
%Krav på Fy kan appliceras på Gwu
%%|Gwu| <= 9.5db då w > 4hz = 25.1 rad/s


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 5
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% %--------------- a) --------------------
% Förbered figurer för de kombinationer av a,b,c som anges i uppgiften.

% ---------------- Fallet c = 1, a > b: -------------------
k = 1;
a = 10;
b = 1;
c = 1;
W1 = W_help(k,a,b,c);
figure(51)
bodemag(W1)
title('c = 1, a > b')

% ---------------- Fallet c= 1, a < b: --------------------
k = 1;
a = 1;
b = 10;
c = 1;
W2 = W_help(k,a,b,c);
figure(52)
bodemag(W2)
title('c= 1, a < b')

% ---------------- Fallet a = inf: ------------------------
k = 1;
a = inf;
b = 1;
c = 1;
W2 = W_help(k,a,b,c);
figure(53)
bodemag(W2)
title('a=inf')
    
% ---------------- Fallet c = 0:   ------------------------
k = 1;
a = 1;
b = 1;
c = 0;
W2 = W_help(k,a,b,c);
figure(54)
bodemag(W2)
title('c=0')

% Observera: Var hamnar brytpunkterna? Vad är förstärkningen då w->0 resp.
% w->infty ?

%%%t%%%%#########ANTECKNINGAR
%b styr brytpunkten.
%a och c styr utseendet (a relativt b)
%k styr förstärkning

% %--------------- b) --------------------
k1 = 1/3;
a1 = inf;
b1 = 18.8;
c1 = 1;
k2 = 1/3;
a2 = 1;
b2 = 18.8;
c2 = 0;
H = W_help(k1,a1,b1,c1)*W_help(k2,a2,b2,c2);
figure(55)
bodemag(H)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 6
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


% %--------------- a) --------------------
G = [1/(s+1), 1/((s+1)*(s+4)); 1/(s+3), 1/((s+1)*(s+5))];
dim_u = size(G,2); % Antalet kolonner är antalet inputs
Fy_a = eye(dim_u);


% % Bestäm känslighetsfunktionerna, se uppg. 3.
S_a = minreal(feedback(eye(dim_u),G*Fy_a));
T_a = minreal(feedback(G,Fy_a)*Fy_a); 
Gwu_a = minreal(-feedback(Fy_a,G));


% %--------------- b) --------------------
WT  = [s/(0.3*s+1), 0; 0, s/(0.3*s + 1)];
WS  = [1/(2*s + 1), 0; 0, 1/(2*s + 1)];
WU  = [s/(3*s + 1), 0; 0, s/(3*s + 1)];


% % Se avsnitt 4 i labb-pm för hur Fy kan bestämmas med kommandot hinfsyn.
Ge = [zeros(2,2) WU;zeros(2,2) WT*G; WS WS*G;eye(2) G]; %build the extended system
Ge = minreal(Ge);
[Fy_b, cl, gamma, info] = hinfsyn(Ge,2,2,'GMIN',0.1,'GMAX',100,'TOLGAM',0.01); %Ändrar dimensioner så att det passar vårat system
Fy_b = -Fy_b;
% Bestäm känslighetsfunktionerna.
S_b = minreal(feedback(eye(2),G*Fy_b));
T_b = minreal(feedback(G,Fy_b)*Fy_b); 
Gwu_b = minreal(-feedback(Fy_b,G));

%Hypotes: WT och WU är Högpassfilter, som inverterat agerar som lågpass,
%p.s.s är WS ett lågpass och blir inverterat ett högpass. Således kommer
%exempelvis WT att trycka ner höga frekvenser medan låta höga bli mer eller
%mindre oförändrare. Samma koncept gäller för de övriga filtren. Dvs när vi
%använder ett Fy som inte är I kommer detta ske. Vi kan se detta i
%plottarna nedan.

%--------------- c) --------------------
WT  = [10*(s+1)/(0.3*s+1), 0; 0, 10*(s+1)/(0.3*s + 1)];
WS  = [1/(2*s + 1), 0; 0, 1/(2*s + 1)];
WU  = [s/(3*s + 1), 0; 0, s/(3*s + 1)];

% Bestäm Fy
Ge = [zeros(2,2) WU;zeros(2,2) WT*G; WS WS*G;eye(2) G]; %build the extended system
Ge = minreal(Ge);
[Fy_c, cl, gamma, info] = hinfsyn(Ge,2,2,'GMIN',0.1,'GMAX',100,'TOLGAM',0.01);
Fy_c = -Fy_c;

% Bestäm känslighetsfunktionerna.
S_c = minreal(feedback(eye(2),G*Fy_c));
T_c = minreal(feedback(G,Fy_c)*Fy_c); 
Gwu_c = minreal(-feedback(Fy_c,G));

%Hypotes: I Uppgift c) lägger vi till WT där det är en summa av ett högpass
%och ett lågpass, dvs ett allpass. Detta inverterat blir ett nopass vilket
%innebär att den försöker trycka ner vid alla frekvenser.

%--------------------------------------
% Jämför resultat
 figure(61)
 sigma(S_a,S_b,S_c)
 legend('a','b','c','location','southeast')
 title('S')
 
 figure(62)
 sigma(T_a,T_b,T_c)
 legend('a','b','c','location','southeast')
 title('T')
 
 figure(63)
 sigma(Gwu_a,Gwu_b,Gwu_c)
 legend('a','b','c','location','southeast')
 title('Gwu')
 
% Vår hypotes tycks stämma, den trycker ner och höjer där vi tänker oss att
% den ska göra det. 

%För uppgift c). T ändras så att den trycks ner ännu mer överallt,
%singulära max/min värden är väldigt nära varandra för låga frekvenser. Vi
%ser dock att S har blivit upptryckt, detta förmodligen på bekostnad av att
%T blev bättre. Detta beror på att S + T = 1, dvs de påverkar varandras
%utseende.


%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 7
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Detta är en omfattande uppgift som tar lång tid. Konstruera
% diagonalelementen till WS, WT och WU som lågpass/högpass/bandpass filter
% t.ex. med hjälpfunktionen W_help.

% % Exempel:
% WS = [W_help()*W_help() 0 0;
%       0 W_help() 0;
%       0 0 W_help()];
%%%Antons kommentar:::straffa olika på olika tillstånd, [beta, p, r] 
%Enligt figur 8 (och Hamads mail) så vill vi straffa r vid 3rad/s som bandpassfilter för att
%undvika resonanspunkten. Beta och p ska båda straffas med lågpassfilter
%enligt figur 8 och tips 4. bandbredden LP-filtret för p ska vara lite
%större. detta för att beta var väldigt viktigt att undertrycka ner vid
%låga frekvenser och då kan vi göra p mer "smooth". 


a = 5;
b = 0.75; 
c = 20;
k = 0.05;
%krav för Ws är 'vara liten för w < 6 rad/s'
Ws1 = W_help(k,a,b,c)

a = 10;
b = 5; 
c = 20;
k = 0.05;

Ws2 = W_help(k,a,b,c)

a1 = Inf;
b1 = 3; 
c1 = 1;
k1 = 0.75;
a2 = 1;
b2 = 3; 
c2 = 0;
k2 = 0.75;

Ws31 = W_help(k1,a1,b1,c1)
Ws32 = W_help(k2,a2,b2,c2)
Ws3 = Ws31*Ws32

figure(70)
bodemag(Ws1, Ws2, Ws3)
legend('Ws_beta','Ws_p','Ws_r')
WS = [Ws1 0 0;0 Ws2 0;0 0 Ws3];





WT = [W_help(1, inf, 40, 1), 0; W_help(1, inf, 40, 1), 0]; %WT vi har studerat delta_G = -1/(1 + s/po)

k1 = 1.5;
a1 = 0.02;
b1 = 4;
c1 = 1;
k2 = 2;
a2 = 100;
b2 = 0.02;
c2 = 1;
WT_filter = W_help(k1,a1,b1,c1)*W_help(k2,a2,b2,c2);
WT_2 = [WT_filter, 0; WT_filter, 0];



a1 = 50;
b1 = 3.5; 
c1 = 1;
k1 = 5;

WU = W_help(k1,a1,b1,c1); 
%bodemag(inv(Wu))




figure(71)
sigma(WS,WT_2,WU)
legend('WS','WT','WU','location','southeast')






%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 8
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%se grön note i block
% Ta alla rader, Ta första och andra kol, ta bort sista kol för denna är r.
% G = ...
% Fy = ...
% Gc = (I + G*Fy)^-1*G*Fr
% Gc = feedback(G, Fy)*Fr

%Fr0 = pinv(dcgain(Gc(:,1:2))) %%indexerar bort r pga att vi inte har en
%referenssignal till r. (se simulink)

%% %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Uppgift 9
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Gc = feedback(G, Fy)*Fr


