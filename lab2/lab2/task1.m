A = G.A;
B = G.B;
C = G.C;
D = G.D;

s = tf('s');
G_tf = tf(G);
G_u1_beta = G_tf(1,1);
G_u1_p = G_tf(2,1);
G_u1_r = G_tf(3,1);

G_u2_beta = G_tf(1,2);
G_u2_p = G_tf(2,2);
G_u2_r = G_tf(3,2);

disp('Egenvärden till G')
disp(eig(G_u1_beta))
disp(eig(G_u1_p))
disp(eig(G_u1_r))
disp(eig(G_u2_beta))
disp(eig(G_u2_p))
disp(eig(G_u2_r))

disp('Nollställen tilll G')
disp(zero(G_u1_beta))
disp(zero(G_u1_p))
disp(zero(G_u1_r))
disp(zero(G_u2_beta))
disp(zero(G_u2_p))
disp(zero(G_u2_r))


%Stegsvar till G
figure(1)
step(G)

%Singulära värden till G
figure(2)
sigma(G)

%Bode av G
figure(3)
bodemag(G)

%Inf norm of G
norm(G, Inf)

G0=freqresp(G,0); %Beräknar G(0)
RGA0=G0.*pinv(G0.'); %Beräknar RGA(G(0))
disp('RGA(G(0)) är')
disp(RGA0)

wc=3.26; %Bandbredden
Gwc=freqresp(G,wc); %Beräknar G(i*wc)
RGAwc=Gwc.*pinv(Gwc.'); %Beräknar RGA(G(i*wc))
disp('RGA(G(wc)) är')
disp(RGAwc)


