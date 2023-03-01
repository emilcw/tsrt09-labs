% THIS IS T
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

% THIS IS S
% a = Inf;
% b = 0.75; 
% c = 20;
% k = 0.05*2;
% Ws1 = W_help(k,a,b,c);
% 
% a = Inf;
% b = 5; 
% c = 20;
% k = 0.05*2;
% 
% Ws2 = W_help(k,a,b,c);
% 
% a1 = Inf;
% b1 = 3; 
% c1 = 1;
% k1 = 0.75*2;
% a2 = 1;
% b2 = 3; 
% c2 = 0;
% k2 = 0.75;
% 
% Ws31 = W_help(k1,a1,b1,c1);
% Ws32 = W_help(k2,a2,b2,c2);
% Ws3 = Ws31*Ws32;
% 
% WS = [Ws1 0 0;0 Ws2 0;0 0 Ws3];
% 
% 
% figure(1)
% title('WS')
% sigma(WS)