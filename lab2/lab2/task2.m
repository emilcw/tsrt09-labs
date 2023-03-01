% Define weight functions

s = tf('s');

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WS %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a = Inf;
b = 0.75; 
c = 20;
k = 0.05*2;
Ws1 = W_help(k,a,b,c);

a = Inf;
b = 5; 
c = 20;
k = 0.05*2;

Ws2 = W_help(k,a,b,c);

a1 = Inf;
b1 = 3; 
c1 = 1;
k1 = 0.75*2;
a2 = 1;
b2 = 3; 
c2 = 0;
k2 = 0.75;

Ws31 = W_help(k1,a1,b1,c1);
Ws32 = W_help(k2,a2,b2,c2);
Ws3 = Ws31*Ws32;

WS = [Ws1 0 0;0 Ws2 0;0 0 Ws3];



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WT %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Krav 1: T(iw) ska ligga under denna.
delta_G = 1 / (-1 / (1 + s / 40));

%Krav 2:
% T(iw) < 1 / 0.3 i magnitud ==> 10.4576

k1 = 1.5*0.3;
a1 = 0.02*5;
b1 = 4*5;
c1 = 1;
k2 = 4*1.6;
a2 = 100*1.3;
b2 = 0.02*5;
c2 = 1;
WT_filter = W_help(k1,a1,b1,c1)*W_help(k2,a2,b2,c2);
WT_filter = inv(WT_filter);
WT = [WT_filter, 0, 0; 0, WT_filter, 0 ; 0 0 WT_filter];

sigma(WT)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% WU %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

a1 = 50;
b1 = 3.5; 
c1 = 1;
k1 = 5;

WU1 = inv(W_help(k1,a1,b1,c1));
WU = [WU1 0; 0 WU1];

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%% Fy, Fr and Gc %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%% Question: Our dimensions does not make sense, we need help with dim for
%%% WS, WT, WU and dim for G 3x2, is this correct? WS, WT and WU are now
%%% 3x3. Gc1 becomes 3x2 but should according to picture be 3x3, why?

% Make G in 3x2
G = tf(G);

Ge = [zeros(2,3) WU;zeros(3,3) WT*G; WS WS*G;eye(3) G];
Ge = minreal(Ge);
[Fy, cl, gamma, info] = hinfsyn(Ge,3,2,'GMIN',0.1,'GMAX',100,'TOLGAM',0.01);
Fy = -Fy;

%Bestäm känslighetsfunktionerna.
S = minreal(feedback(eye(3),G*Fy));
T = minreal(feedback(G,Fy)*Fy);
Gwu = minreal(-feedback(Fy,G));

Gc1 = minreal(feedback(G*Fy, eye(3)));
Gc1 = Gc1(1:2, 1:2);
Fr = pinv(dcgain(Gc1));
Gc = minreal(Fr * Gc1);
%%%%%%%%%%%%%%%%%%%%%%%%%%% Evalution %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% S.
figure(1)
sigma(S*H);
title('S * H with Fy');
% Here we can see that S*H is below -40db for w < 1 rad / s and that S*H is
% below -27 db for w = 3 rad/s.

% T
figure(2)
delta_g = 1 / (-1/(1 + 40/s));
sigma(T, delta_g);
title('T with Fy');
%We can see that we are under the delta_g. Moreover we it does surpass 10.5 db. 

% Gwu
figure(3)
sigma(Gwu);
title('Gwu with Fy');
% After 4 Hz = 25.1 rad/s we can see that the magnitude never becomes more
% than 9.5 db (3.0 mag) which is our req.


% Step response for Gc, to show decoupling
figure(4)
step(Gc)
hold on
plot([0 0.2 2.2 5],[0 0 0.8 0.8 ; 1.2 1.2 1.2 1.2])
% Bounds for beta, when applying a step response.
% Beta is within the boudrais given in Figure 8. We can also see that the
% system is decoupled since we have 0 gain at the offdiag.






