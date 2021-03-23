%Main
clear all
clc
%%%%%%%%% INITIALIZE PARAMETERS %%%%%%
% tic
% System parameters P (Quadrotor and Payload properties)
P.Jx = 4.4 * 10^(-3); 
P.Jy = 4.4 * 10^(-3);
P.Jz = 8.8 * 10^(-3);
P.g = 9.81;
P.m = 0.5;
P.ml = 0.2;
P.L = 1;

% GA conditions
P.nvar = 336;   % Number of variables to be tuned
load('fisbounds.mat')
P.lb = [];
P.ub = [];
for j = 0:13
    P.lb = [P.lb lb(4*j+1)*ones(1,5) lb(4*j+2)*ones(1,5) lb(4*j+3)*ones(1,5) lb(4*j+4)*ones(1,9)]; % lb
    P.ub = [P.ub ub(4*j+1)*ones(1,5) ub(4*j+2)*ones(1,5) ub(4*j+3)*ones(1,5) ub(4*j+4)*ones(1,9)]; % ub % Initial range of the population
end
P.ode = @myodefun;

% Initial conditions 
% X = [pn;pe;pd;ub;vb;wb;phi;theta;psi;p;q;r;thetaL;phiL;thetaLdot;phiLdot;xL;yL;zL;xLdot;yLdot;zLdot];
P.X0 =  [0;0;0;0;0;0;0.1;0.1;0;0;0;0;0.1;0.1;0;0;-0.0993;-0.0100;-0.9950;0;0;0];
framespersec = 20;
P.obj = @FitFun;
T_end = 5;             %duration of animation  in seconds
P.tspan=linspace(0,T_end,T_end*framespersec); 
% P.fis1 = readfis('tauphifis');
% P.fis2 = readfis('tauthetafis');
% P.fis3 = readfis('taupsifis');

% GA parameters
M = 10;
N = P.nvar;
MaxGen = 200;
Pc = 0.95;
Pm = 0.01;
Er = 0.2;

warning('off','Fuzzy:evalfis:InputOutOfRange')
[BestChrom] = CGeneticAlgorithm(M,N,MaxGen,Pc,Pm,Er,P);
save('BestChrom.mat','BestChrom')
% toc