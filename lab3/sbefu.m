function Yf=sbefu(c,u,fun,funh)
%
% Yf=sbefu(c,u,fun)
% computes the describing function for a 
% nonlinearity given by fun 
%
% c - amplitude of sine at input (symbolic)
% u - input variable (symbolic)
% fun - symbolic expression of the nonlinearity;
%       if fun  has the form [fun_1,d1,fun_2,d2,..,fun_k] it is
%       assumed that the nonlinearity is given by fun1 for u<d1, by
%       fun2 for d1<u<d2, etc
% 
% For nonlinearities with hysteresis the form
% Yf=sbefu(c,u,fun1,fun2) is used, where fun1 and fun2 give the nonlinearity 
% for increasing and decreasing u-values respectively.
%
syms f Yfi;
L=length(fun);
f=subs(fun,u,c*sin(u));
if L==1
  Yf=int(f*sin(u),u,-pi/2,pi/2);
else
  Yf=int(f(1)*sin(u),u,-pi/2,asin(f(2)/c))+int(f(L)*sin(u),u,asin(f(L-1)/c),pi/2);
  for j=1:(L-3)/2
    Yf=Yf+int(f(j+2)*sin(u),u,asin(f(j+1)/c),asin(f(j+3)/c));
  end
end
if nargin==3 % no hysteresis -- real output
  Yf=(2/(pi*c))*simple(Yf);
  return
end
% hysteresis --  sine integral over decreasing u
Lh=length(funh);
fh=subs(funh,u,c*sin(u));
if Lh==1
  Yf=Yf+int(fh*sin(u),u,-pi/2,pi/2);
else
  Yf=Yf+int(fh(1)*sin(u),u,-pi/2,asin(fh(2)/c))+int(fh(Lh)*sin(u),u,asin(fh(Lh-1)/c),pi/2);
  for j=1:(Lh-3)/2
    Yf=Yf+int(fh(j+2)*sin(u),u,asin(fh(j+1)/c),asin(fh(j+3)/c));
  end
end
% cosine integral over increasing u
if L==1
  Yfi=int(f*cos(u),u,-pi/2,pi/2);
else
  Yfi=int(f(1)*cos(u),u,-pi/2,asin(f(2)/c))+int(f(L)*cos(u),u,asin(f(L-1)/c),pi/2);
  for j=1:(L-3)/2
    Yfi=Yfi+int(f(j+2)*cos(u),u,asin(f(j+1)/c),asin(fh(j+3)/c));
  end
end
% cosine integral over decreasing u
if Lh==1
  Yfi=Yfi-int(fh*cos(u),u,-pi/2,pi/2);
else
  Yfi=Yfi-int(fh(1)*cos(u),u,-pi/2,asin(fh(2)/c))-int(fh(Lh)*cos(u),u,asin(fh(Lh-1)/c),pi/2);
  for j=1:(Lh-3)/2
    Yfi=Yfi-int(fh(j+2)*cos(u),u,asin(fh(j+1)/c),asin(fh(j+3)/c));
  end
end
Yf=simple(Yf)/(c*pi) + i * simple(Yfi)/(c*pi);




