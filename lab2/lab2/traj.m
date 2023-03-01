function M = traj(x,y,z,pitch,roll,yaw,scale,step,varargin)

% TRAJ - Trajectory visualization.
%
%   M = TRAJ(X,Y,Z,PITCH,ROLL,YAW,SIZE,STEP,[MODEL,VIEW])
%
% Visualizes the trajectory of an object given its the position
% (X,Y,Z) [m] and orientation in Euler angles (PITCH,ROLL,YAW) [rad].
% The coordinate axes point north (X), east (Y), and down (Z). Note
% that this coordinate system differs from the one that Matlab uses
% for 3D plotting.
%
% SIZE decides the length of the object [m]. STEP is the number of
% data points between two plotted instances of the object. MODEL
% (string) decides which object is used:
% 
%  gripen  JAS 39 Gripen (def)    heli     Helicopter
%  mig     Mig			  ah64     AH-64 Apache helicopter
%  tomcat  Tomcat		  a10      A-10
%  jet     Generic jet		  cessna   Cessna
%  747     Boeing 747		  biplane  Generic biplane
%  md90    MD90 jet		  shuttle  Space shuttle
%  dc10    DC-10 jet
%
% VIEW sets the camera view. Use Matlab's "view" as argument to reuse
% the current view.
%
% MOVIE(M) shows an animation of the trajectory. If no output
% variable is given, TRAJ plots all the snapshots in one figure.
%
% Example: load roll.mat
%          traj(x,y,z,pitch,roll,yaw,50,100)
%          movie(M)
%
% See also: MOVIE, MOVIE2AVI

% ------------------------------------------------
%  Based on trajectory2.m by Valerio Scordamaglia. 
%  Modified by Ola Härkegård.
% ------------------------------------------------

  if nargin<8
    error('Too few input arguments.');
  end

  model = 'gripen';
%   theview = view([82.50,2]);
  [az,el] = view([82.50,2]);
  theview=[az el];
  
  for i = 1:length(varargin)
    v = varargin{i};
    if ischar(v)
      model = v;
    else 
      theview = v;
    end
  end
  
  mov = nargout;
  
  % Convert from standard flight axes (north, east, down) to
  % Matlab's 3D-plot axes (north, west, up).
  y = -y;
  z = -z;
  pitch = -pitch;
  yaw = -yaw;
  
  if ~isequal(length(x),length(y),length(z),...
	      length(pitch),length(roll),length(yaw))
    error('x, y, z, pitch, roll, and yaw must have the same length.');
  end

  if step>=length(x)
    error('Step size too large.');
  end

  if nargin==8
    model = 'gripen';
  end
  
  switch model
   case 'shuttle'
    load shuttle;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
   case 'heli'
    load helicopter;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
   case '747'
    load boeing_747;
    V=[V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
   case 'biplane'
    load biplane;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
    case 'md90'
     load md90;
     V=[-V(:,1) V(:,2) V(:,3)];
     V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
     V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
     V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
   case 'dc10'
    load dc10;
    V=[V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
   case 'ah64'
    load ah64;
    V=[V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
   case 'mig'    
    load mig;
    V=[V(:,2) V(:,1) V(:,3)];
   case 'tomcat'
    load tomcat;
    V=[-V(:,2) V(:,1) V(:,3)];
    V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
    V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
    V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
   case 'jet'
    load 80jet;
    V=[-V(:,2) V(:,1) V(:,3)];
   case 'cessna'
    load 83plane;
    V=[-V(:,2) V(:,1) V(:,3)];
   case 'a10'
    load A-10;
    V=[V(:,3) V(:,1) V(:,2)];
   case 'gripen'
    load gripen;
    V=[-V(:,1)+400 V(:,2) V(:,3)-50];
   otherwise
    try
      eval(['load ' model ';']);
      V(:,1)=V(:,1)-round(sum(V(:,1))/size(V,1));
      V(:,2)=V(:,2)-round(sum(V(:,2))/size(V,1));
      V(:,3)=V(:,3)-round(sum(V(:,3))/size(V,1));
    catch
      disp(sprintf('Warning: %s not found. Using default: Gripen', model));
      load gripen;
      V=[-V(:,1)+400 V(:,2) V(:,3)-50];
    end
  end

  % Scale object
  V = V*scale/(max(V(:,1))-min(V(:,1)));

  % Transpose -> coordinates (vertices) in columns
  V = V';
 
  frame = 0;
  % Add objects
  for i=1:step:length(x)
    if mov | (i == 1)
      clf
      plot3(x,y,z);
      grid on;
      hold on;
      light;
    end
      
    % Euler angles
    theta=pitch(i);
    phi=roll(i);
    psi=yaw(i);

    % Total rotation matrix. Here's how to think:
    %
    % A vector v can be written as v = e_e*v_e = e_b*v_b in two
    % different frames e (earth-fixed) and b (body-fixed) where e_*
    % contains the basis vectors of the frame and v_* contains the
    % coordinates of the vector in that frame.
    %
    % The relationship between the *basis vectors* is given by
    % e_b = e_f*R(psi)*R(theta)*R(phi) = e_f*T where
    % R(angle) is a standard rotation matrix. This means
    % v = e_e*v_e = e_e*T*v_b and hence v_e = T*v_b.
    T = [cos(psi) -sin(psi) 0;    % Yaw
	 sin(psi)  cos(psi) 0;
	 0         0        1] * ...
	[cos(theta) 0 sin(theta); % Pitch
	 0          1 0;
	-sin(theta) 0 cos(theta)] * ...
	[1 0 0;			  % Roll
	 0 cos(phi) -sin(phi);
	 0 sin(phi)  cos(phi)];

    % Here, v_b are the vertices stored in V.
    Vnew = T*V; % Coordinates in earth fixed frame
	 
    % Translate
    cg = [x(i) y(i) z(i)]';
    X0 = repmat(cg,1,size(Vnew,2));
    Vnew = Vnew+X0;
    
    % Draw object
    p = patch('faces',F,'vertices',Vnew');
    set(p, 'facec', .85*[1 1 1]);          
%    set(p, 'FaceVertexCData', C);  
    set(p, 'EdgeColor','none'); 
  
    if mov | (i == 1)
      view(theview)
      axis equal;
    end
      
    if mov
      if i == 1
	ax = axis;
      else
	axis(ax);
      end
      lighting phong
      frame = frame + 1;
      M(frame) = getframe;
    end
  end

  if ~mov
    lighting phong
    xlabel('X (m)');
    ylabel('Y (m)');
    zlabel('Z (m)');
  end