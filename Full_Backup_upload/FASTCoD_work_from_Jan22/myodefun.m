% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

function xdot = myodefun(t,in,fis1,fis2,fis3,S)
% Contains dynamics for planar quadrotor single payload system
x = in(1);
z = in(2);
alpha = in(3);
theta = in(4);
xdot = in(5);
zdot = in(6);
alphadot = in(7);
thetadot = in(8);

M = S.M;
m = S.m;
l = S.l;
g = S.g;
J = S.J;

xe = S.x_goal - x; % calculating x_error
% xedot  = (0 - xdot);
ze = S.z_goal - z; % calculating z_error
% zedot = (0 - zdot);
%theta error is calculated inside getF.m
% tedot = 0-thetadot;

[F,tau] = getF(xe,xdot,ze,zdot,theta,thetadot,fis1,fis2,fis3,S);

fx = F*sin(theta);
fz = F*cos(theta);
% disp([fx,fz,tau])

% Write equation of motion here % Should write as state space for better
% solve times
% xdot=?

xddot = ((M+m*cos(alpha)*cos(alpha))/(M*(M+m)))*fx + ((m*sin(alpha)*cos(alpha))/(M*(M+m)))*fz + (m*l*alphadot^2*sin(alpha))/(M+m);
zddot = ((m*sin(alpha)*cos(alpha))/(M*(M+m)))*fx + ((M + m*sin(alpha)*sin(alpha))/(M*(M+m)))*fz - (m*l*alphadot^2*cos(alpha))/(M+m) - g;
alphaddot = -cos(alpha)*fx/(M*l) - sin(alpha)*fz/(M*l);
thetaddot = tau/J;

xdot = [...
    xdot;
    zdot;
    alphadot;
    thetadot;
    xddot;
    zddot;
    alphaddot;
    thetaddot;];
end