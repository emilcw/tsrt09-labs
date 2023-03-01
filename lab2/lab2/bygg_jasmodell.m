% -- Ladda gamla modellen = exempel 2.3 --

load jasmodell_ex2_3
Gold = G;

% -- Bygg ny (redycerad) flygplansmodell G --

V = 203; % fart, m/s
st = [1:3,6:7]; % tillstånd i nya modellen
G = ss(Gold.A(st,st),Gold.B(st,:),...
       [diag([1/V 1 1]) zeros(3,2)],zeros(3,2));
G.StateName = {'vy','p','r','delta_a','delta_r'};
G.InputName = {'u1','u2'};
G.OutputName = {'beta','p','r'};

% -- Bygg vindmodell H --

% Dryden vindmodell (MIL-HDBK-1797)
% http://www.mathworks.com/access/helpdesk/help/toolbox/aeroblks/drydenwindturbulencemodelcontinuous.html

% Från http://www.chrismanual.com/Intro/convfact.htm
ft2m = .3048;
m2ft = 1/ft2m;
knots2mps = 0.5148;

b = 8.40; % Gripen wing span
h = 500; % m
hft = h*m2ft;
% Low altitides (< 1000 feet) för att göra det lite enklare
Lw = 0.5*h;
Lv = 0.5*h/(0.177+0.000823*hft)^1.2;
W20 = 45*knots2mps; % Moderate turbulence
Sw = 0.1*W20;
Sv = Sw/(0.177+0.000823*hft)^0.4;

a = 2*Lv/V;
Hv = Sv*sqrt(a/pi)*tf([a*sqrt(3) 1],conv([a 1],[a 1]));
Hp = Sw*sqrt(0.8/V)*(pi/(4*b))^(1/6)*tf(1,(2*Lw)^(1/3)*[4*b/(pi*V) 1]);
Hr = tf([1/V 0],[3*b/(pi*V) 1])*Hv;

Gturb = [Hv 0;0 Hp;Hr 0];
Gturb.InputName = {'e1','e2'};
Gturb.OutputName = {'vind_vy','vind_p','vind_r'};

% Vindens inverkan på planet = Exempel 5.4:
N = [ 0.292   0.001   0.97;
      0.152  -2.54    0.552;
     -0.0364 -0.0688 -0.456;
      zeros(2,3)];

Gvind = ss(G.A,N,G.C,zeros(3,3));
Gvind.StateName = {'vy','p','r','delta_a','delta_r'};
Gvind.InputName = {'w1','w2','w3'};
Gvind.OutputName = {'beta','p','r'};

% Total överföringsfunktion:
H = minreal(Gvind*Gturb);

% -- Tomma regulatorer --

Fy = zeros(2,3);
Fr = eye(2);

save jasmodell G H Fy Fr
