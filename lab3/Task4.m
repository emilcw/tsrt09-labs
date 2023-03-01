% Circle kriterion
K = 168;
k1 = 1;
k2 = 0.2;
wrange = [1:1:100];


G = tf(K,[1 4 16 0]);
ciplot(k1,k2,G,wrange)