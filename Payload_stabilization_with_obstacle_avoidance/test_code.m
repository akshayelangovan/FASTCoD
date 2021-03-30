clear all
clc
%%%%%%%%% INITIALIZE PARAMETERS %%%%%%

% System parameters P (Quadrotor and Payload properties)
P.Jx = 4.4 * 10^(-3); 
P.Jy = 4.4 * 10^(-3);
P.Jz = 8.8 * 10^(-3);
P.g = 9.81;
P.m = 0.5;
P.ml = 0.2;
P.L = 1;

warning('off','Fuzzy:evalfis:InputOutOfRange')

P.nvar = 336;   % Number of variables to be tuned
load('fisbounds.mat')
P.lb = [];
P.ub = [];
for j = 0:13
    P.lb = [P.lb lb(4*j+1)*ones(1,5) lb(4*j+2)*ones(1,5) lb(4*j+3)*ones(1,5) lb(4*j+4)*ones(1,9)]; % lb
    P.ub = [P.ub ub(4*j+1)*ones(1,5) ub(4*j+2)*ones(1,5) ub(4*j+3)*ones(1,5) ub(4*j+4)*ones(1,9)]; % ub % Initial range of the population
end
% P.ode = @myodefun; % For nonlinear dynamics
P.ode = @myodelin; % For linear dynamics

% Initial conditions 
% X = [pn;pe;pd;ub;vb;wb;phi;theta;psi;p;q;r;thetaL;phiL;thetaLdot;phiLdot;xL;yL;zL;xLdot;yLdot;zLdot];
P.X0 =  [0;0;0;0;0;0;0.1;0.1;0;0;0;0;0.1;0.1;0;0;-0.0993;-0.0100;-0.9950;0;0;0];
framespersec = 10;
P.obj = @FitFun;
T_end = 5;             %duration of animation  in seconds
P.tspan=linspace(0,T_end,T_end*framespersec);

fis1 = readfis('fis1');
fis2 = readfis('fis2');
fis3 = readfis('fis3');
fis4 = readfis('fis4');
fis5 = readfis('fis5');
fis6 = readfis('fis6');
fis7 = readfis('fis7');
fis8 = readfis('fis8');
fis9 = readfis('fis9');
fis10 = readfis('fis10');
fis11 = readfis('fis11');
fis12 = readfis('fis12');
fis13 = readfis('fis13');
fis14 = readfis('fis14');

T = 9.81;
save('tension.mat','T')
options=odeset('abstol',1e-3,'reltol',1e-6);
[t,z]=ode23(@P.ode,P.tspan,P.X0,options,P,fis1,fis2,fis3,fis4,fis5,fis6,fis7,fis8,fis9,fis10,fis11,fis12,fis13,fis14);