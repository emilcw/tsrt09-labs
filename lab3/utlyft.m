if nargin==4 & funh=='odd'
  if length(fun)==1
      Yf=cf*int(f*sin(u),u,0,pi/2);
      Yf=simple(Yf);
    elseif length(fun)==3
      d=f(2);
      Yf1=cf*int(f(1)*sin(u),u,0,pi/2);
      Yf1=simple(Yf1);
      Yf2=cf*int(f(1)*sin(u),u,0,asin(d/c));
      Yf2=Yf2+cf*int(f(3)*sin(u),u,asin(d/c),pi/2); 
      Yf2=simple(Yf2);
      Yf=[Yf1;Yf2];
    else
      error('wrong format of function')
    end
  return  
end
