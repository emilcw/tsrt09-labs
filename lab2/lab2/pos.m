function dp = pos(u)
  
  beta = u(1);
  phi  = u(2);
  psi  = u(3);
  
  alpha = 0;
  theta = 0;
  Vtot = 203;
  
  u = Vtot*cos(alpha)*cos(beta);
  v = Vtot*sin(beta);
  w = Vtot*sin(alpha)*cos(beta);
  
  ct = cos(theta); st = sin(theta);
  cphi = cos(phi); sphi = sin(phi);
  cpsi = cos(psi); spsi = sin(psi);
  
  dp = [ct*cpsi -cphi*spsi+sphi*st*cpsi sphi*spsi+cphi*st*cpsi;
	ct*spsi cphi*cpsi+sphi*st*spsi -sphi*cpsi+cphi*st*spsi]*...
       [u v w]';

  % st -sphi*ct -cphi*ct]*[u v w]';
  
