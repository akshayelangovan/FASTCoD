function Xdot = myodefun2(t,in,fis1,fis2,fis3,fis4,fis5,fis6,fis7,fis8,fis9,fis10,fis11,fis12, S)
% Contains dynamics for planar quadrotor single payload system
x = in(1);
y = in(2);
z = in(3);
a = in(4);
b = in(5);
phi = in(6);
theta = in(7);
psi = in(8);
xdot = in(9);
ydot = in(10);
zdot = in(11);
adot = in(12);
bdot = in(13);
phidot = in(14);
thetadot = in(15);
psidot = in(16);

M = S.M;
m = S.m;
l = S.l;
g = S.g;
Jx = S.J;
Jy = S.J;
Jz = Jx/2;


% get subway point
[x_goal,y_goal,z_goal] = getsubwaypoint(S,t);
% psie = yaw_goal - psi;
psie=0;

if norm([x_goal,y_goal,z_goal]-[x,y,z])>0.001
    xe = x_goal - x; % calculating x_error
    ye = y_goal - y; % calculating y_error
    ze = z_goal - z; % calculating z_error
    [F,T_theta,T_phi,T_psi] = getF(xe,xdot,ye,ydot,ze,zdot,theta,thetadot,phi,phidot,psie,psidot,fis1,fis2,fis3,fis4,fis5,fis6,S);
else
    xe = x_goal - x; % calculating x_error
    ye = y_goal - y; % calculating y_error
    ze = z_goal - z; % calculating z_error
    [F,T_theta,T_phi,T_psi] = getF(xe,xdot,ye,ydot,ze,zdot,theta,thetadot,phi,phidot,psie,psidot,fis8,fis9,fis10,fis11,fis12,fis6,S);
end



Rx = [...
    1 0 0;
    0 cos(phi) -sin(phi);
    0 sin(phi) cos(phi)];
Ry = [...
    cos(theta) 0 sin(theta);
    0 1 0;
    -sin(theta) 0 cos(theta)];
Rz = [...
    cos(psi) -sin(psi) 0;
    sin(psi) cos(psi) 0;
    0 0 1];

R = Rz*Ry*Rx*[0;0;F];
Fx = R(1);
Fy = R(2);
Fz = R(3);

% fx = F*sin(theta);
% fz = F*cos(theta);
% disp([fx,fz,tau])

% Write equation of motion here % Should write as state space for better
% solve times
% xdot=?

xddot = (Fx * ( M + m*cos(b)*cos(b)*cos(a)*cos(a) + m*sin(b)*sin(b)) - Fy * (m*cos(b)*sin(b)*sin(a)*sin(a)) + Fz * (m*cos(b)*cos(a)*sin(a)) + M*m*l*cos(b)*sin(a)*(adot*adot + sin(a)*sin(a)*bdot*bdot))/(M*(M+m));
yddot = (-Fx * (m*cos(b)*sin(b)*sin(a)*sin(a)) + Fy * (M + m*sin(b)*sin(b)*cos(a)*cos(a) + m*cos(b)*cos(b)) + Fz * (m*sin(b)*cos(a)*sin(a)) + M*m*l*sin(b)*sin(a)*(adot*adot + sin(a)*sin(a)*bdot*bdot))/(M*(M+m));
zddot = ((Fx * (m*cos(b)*sin(a)*cos(a)) + Fy * (m*sin(b)*sin(a)*cos(a)) + Fz * (M + m*sin(a)*sin(a)) - M*m*l*cos(a)*adot*adot - M*m*l*sin(a)*sin(a)*cos(a)*bdot*bdot)/(M*(M+m))) - g;
addot = ((-Fx*cos(b)*cos(a) - Fy*sin(b)*cos(a) - Fz*sin(a))/(M*l)) + sin(a)*cos(a)*bdot*bdot;
bddot = (Fx*sin(b) - Fy*cos(b) - 2*M*l*cos(a)*adot*bdot)/(M*l*sin(a));
phiddot = T_phi/Jx;
thetaddot = T_theta/Jy;
psiddot = T_psi/Jz;

Xdot = [...
    xdot;
    ydot;
    zdot;
    adot;
    bdot;
    phidot;
    thetadot;
    psidot;
    xddot;
    yddot;
    zddot;
    addot;
    bddot;
    phiddot;
    thetaddot;
    psiddot;
    ];
end