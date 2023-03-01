A = [0 1; 0 0];
B = [0; 1];
C = [1 0];

p1 = -4;
p2 = -1.5;
p = [p1 p2];
L = place(A, B, p);
Lr = inv(C*inv(B*L -A)*B);
%Lr = 1;
Gc = ss(A-B*L, Lr*B, C, 0);
step(Gc)