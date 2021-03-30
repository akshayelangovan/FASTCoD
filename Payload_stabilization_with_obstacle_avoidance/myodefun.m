
function xdot = myodefun(t,x,P,fis1,fis2,fis3,fis4,fis5,fis6,fis7,fis8,fis9,fis10,fis11,fis12,fis13,fis14)
% Contains dynamics for quadrotor single payload system
% X = [pn;pe;pd;ub;vb;wb;phi;theta;psi;p;q;r;thetaL;phiL;thetaLdot;phiLdot;xL;yL;zL;xLdot;yLdot;zLdot]
pn = x(1);%% 12 quad states
pe = x(2);
pd = x(3);
ub = x(4);
vb= x(5);
wb= x(6);
phi = x(7); 
theta = x(8);
psi = x(9);
p = x(10);
q = x(11);
r = x(12);
thetaL = x(13);%% 4 cable angle states
phiL = x(14);
thetaLdot = x(15);
phiLdot = x(16);
% xL = x(17); %% 6 payload position states
% yL = x(18);
% zL = x(19);
xLdot = x(20);
yLdot = x(21);
zLdot = x(22);

load('tension.mat') % Loading tension from previous timestep

%Input from FIS controllers
% Thrust force
F = getF(pd,wb,zLdot,T,fis1,fis2,fis3); % 6 inputs
%Torque forces
tauPsi = evalfis([psi,r],fis4);
tauPhi = getMphi(pe,vb,yLdot,phiLdot,phi,p,fis5,fis6,fis7,fis8,fis9);
tauTheta = getMtheta(pn,ub,xLdot,thetaLdot,theta,q,fis10,fis11,fis12,fis13,fis14);
% F = 0;
% tauPsi = 0;
% tauPhi = 0;
% tauTheta = 0;

% Write equation of motion here
% xdot=?
pndot = ub;
pedot = vb;
pddot = wb;

ubdot = (cos(phi)*sin(theta)*cos(psi) + sin(phi)*sin(psi))*(F/P.m) - (sin(thetaL)*cos(phiL)*T/P.m);
vbdot = (cos(phi)*sin(theta)*sin(psi) - sin(phi)*cos(psi))*(F/P.m) + (sin(thetaL)*sin(phiL)*T/P.m);
wbdot = (cos(phi)*cos(theta))*(F/P.m) - P.g - cos(thetaL)*T/P.m;

phidot = p + q*sin(phi)*tan(theta)+r*cos(phi)*tan(theta);
thetadot = q*cos(phi)-r*sin(phi);
psidot = q*sin(phi)/cos(theta) + r*cos(phi)/cos(theta);

pdot=(P.Jy-P.Jz)/P.Jx*q*r + 1/P.Jx*tauPhi;
qdot=(P.Jz-P.Jx)/P.Jy*p*r + 1/P.Jy*tauTheta;
rdot=(P.Jx-P.Jy)/P.Jz*p*q + 1/P.Jz*tauPsi;

thetaLddot = -(P.L*sin(thetaL)*sin(phiL)*T/P.ml) + tauTheta/P.ml;
phiLddot = -(P.L*sin(thetaL)*cos(phiL)*T/P.ml) + tauPhi/P.ml;

xLddot = T*sin(thetaL)*cos(phiL)/P.ml;
yLddot = T*sin(thetaL)*sin(phiL)/P.ml;
zLddot = (T*cos(thetaL) - P.ml*P.g)/P.ml;

T = P.ml * norm([xLddot;yLddot;zLddot]);
save('tension.mat','T')

xdot = [...
    pndot;
    pedot;
    pddot;
    ubdot;
    vbdot;
    wbdot;
    phidot;
    thetadot;
    psidot;
    pdot;
    qdot;
    rdot;
    thetaLdot;
    phiLdot;
    thetaLddot;
    phiLddot;
    xLdot;
    yLdot;
    zLdot;
    xLddot;
    yLddot;
    zLddot];

end