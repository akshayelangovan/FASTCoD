load('BestChrom.mat')
% R = BestChrom.Gene;
tic
R = P.lb;
%Reading FIS files to be trained
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

%% Fis 1 to 3 commands Total thrust of UAV
%FIS1
mfp = sort(R(1:5)); % mf parameters
fis1.input(1).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis1.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis1.input(1).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(6:10));
fis1.input(2).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis1.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis1.input(2).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(11:15));
fis1.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis1.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis1.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis1.rule(i).consequent = round(R(15+i)); % Assigning rules 
    if fis1.rule(i).consequent == 0
        fis1.rule(i).consequent = 1;
    end
end

%FIS2
mfp = sort(R(25:29)); % mf parameters
fis2.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis2.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis2.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(30:34));
fis2.input(2).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis2.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis2.input(2).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(35:39));
fis2.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis2.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis2.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis2.rule(i).consequent = round(R(39+i)); % Assigning rules 
    if fis2.rule(i).consequent == 0
        fis2.rule(i).consequent = 1;
    end
end

%FIS3
mfp = sort(R(49:53)); % mf parameters
fis3.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis3.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis3.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(54:58));
fis3.input(2).mf(1).params = [0 0 mfp(1) mfp(3)];
fis3.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis3.input(2).mf(3).params = [mfp(3) mfp(5) 20 20];

mfp = sort(R(59:63));
fis3.output(1).mf(1).params = [-10 -10 mfp(1) mfp(3)];
fis3.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis3.output(1).mf(3).params = [mfp(3) mfp(5) 10 10];

for i = 1:9
    fis3.rule(i).consequent = round(R(63+i)); % Assigning rules 
    if fis3.rule(i).consequent == 0
        fis3.rule(i).consequent = 1;
    end
end

%% Fis 4 commands UAV Yaw Torque
%FIS4
mfp = sort(R(73:77)); % mf parameters
fis4.input(1).mf(1).params = [-pi -pi mfp(1) mfp(3)];
fis4.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis4.input(1).mf(3).params = [mfp(3) mfp(5) pi pi];

mfp = sort(R(78:82));
fis4.input(2).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis4.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis4.input(2).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(83:87));
fis4.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis4.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis4.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis4.rule(i).consequent = round(R(87+i)); % Assigning rules 
    if fis4.rule(i).consequent == 0
        fis4.rule(i).consequent = 1;
    end
end

%% Fis 5 to 9 commands UAV Roll Torque
%FIS5
mfp = sort(R(97:101)); % mf parameters
fis5.input(1).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis5.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis5.input(1).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(102:106));
fis5.input(2).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis5.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis5.input(2).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(107:111));
fis5.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis5.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis5.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis5.rule(i).consequent = round(R(111+i)); % Assigning rules 
    if fis5.rule(i).consequent == 0
        fis5.rule(i).consequent = 1;
    end
end

%FIS6
mfp = sort(R(121:125)); % mf parameters
fis6.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis6.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis6.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(126:130));
fis6.input(2).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis6.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis6.input(2).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(131:135));
fis6.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis6.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis6.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis6.rule(i).consequent = round(R(135+i)); % Assigning rules 
    if fis6.rule(i).consequent == 0
        fis6.rule(i).consequent = 1;
    end
end

%FIS7
mfp = sort(R(145:149)); % mf parameters
fis7.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis7.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis7.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(150:154));
fis7.input(2).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis7.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis7.input(2).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(155:159));
fis7.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis7.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis7.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis7.rule(i).consequent = round(R(159+i)); % Assigning rules 
    if fis7.rule(i).consequent == 0
        fis7.rule(i).consequent = 1;
    end
end

%FIS8
mfp = sort(R(169:173)); % mf parameters
fis8.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis8.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis8.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(174:178));
fis8.input(2).mf(1).params = [-pi -pi mfp(1) mfp(3)];
fis8.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis8.input(2).mf(3).params = [mfp(3) mfp(5) pi pi];

mfp = sort(R(179:183));
fis8.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis8.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis8.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis8.rule(i).consequent = round(R(183+i)); % Assigning rules 
    if fis8.rule(i).consequent == 0
        fis8.rule(i).consequent = 1;
    end
end

%FIS9
mfp = sort(R(193:197)); % mf parameters
fis9.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis9.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis9.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(198:202));
fis9.input(2).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis9.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis9.input(2).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(203:207));
fis9.output(1).mf(1).params = [-2 -2 mfp(1) mfp(3)];
fis9.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis9.output(1).mf(3).params = [mfp(3) mfp(5) 2 2];

for i = 1:9
    fis9.rule(i).consequent = round(R(207+i)); % Assigning rules 
    if fis9.rule(i).consequent == 0
        fis9.rule(i).consequent = 1;
    end
end

%% Fis 10 to 14 commands UAV Pitch Torque
%FIS10
mfp = sort(R(217:221)); % mf parameters
fis10.input(1).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis10.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis10.input(1).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(222:226));
fis10.input(2).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis10.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis10.input(2).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(227:231));
fis10.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis10.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis10.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis10.rule(i).consequent = round(R(231+i)); % Assigning rules 
    if fis10.rule(i).consequent == 0
        fis10.rule(i).consequent = 1;
    end
end

%FIS11
mfp = sort(R(241:245)); % mf parameters
fis11.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis11.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis11.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(246:250));
fis11.input(2).mf(1).params = [-5 -5 mfp(1) mfp(3)];
fis11.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis11.input(2).mf(3).params = [mfp(3) mfp(5) 5 5];

mfp = sort(R(251:255));
fis11.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis11.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis11.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis11.rule(i).consequent = round(R(255+i)); % Assigning rules 
    if fis11.rule(i).consequent == 0
        fis11.rule(i).consequent = 1;
    end
end

%FIS12
mfp = sort(R(265:269)); % mf parameters
fis12.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis12.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis12.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(270:274));
fis12.input(2).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis12.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis12.input(2).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(275:279));
fis12.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis12.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis12.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis12.rule(i).consequent = round(R(279+i)); % Assigning rules 
    if fis12.rule(i).consequent == 0
        fis12.rule(i).consequent = 1;
    end
end

%FIS13
mfp = sort(R(289:293)); % mf parameters
fis13.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis13.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis13.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(294:298));
fis13.input(2).mf(1).params = [-pi -pi mfp(1) mfp(3)];
fis13.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis13.input(2).mf(3).params = [mfp(3) mfp(5) pi pi];

mfp = sort(R(299:303));
fis13.output(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis13.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis13.output(1).mf(3).params = [mfp(3) mfp(5) 1 1];

for i = 1:9
    fis13.rule(i).consequent = round(R(303+i)); % Assigning rules 
    if fis13.rule(i).consequent == 0
        fis13.rule(i).consequent = 1;
    end
end

%FIS14
mfp = sort(R(313:317)); % mf parameters
fis14.input(1).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis14.input(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis14.input(1).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(318:322));
fis14.input(2).mf(1).params = [-1 -1 mfp(1) mfp(3)];
fis14.input(2).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis14.input(2).mf(3).params = [mfp(3) mfp(5) 1 1];

mfp = sort(R(323:327));
fis14.output(1).mf(1).params = [-2 -2 mfp(1) mfp(3)];
fis14.output(1).mf(2).params = [mfp(2) mfp(3) mfp(4)];
fis14.output(1).mf(3).params = [mfp(3) mfp(5) 2 2];

for i = 1:9
    fis14.rule(i).consequent = round(R(327+i)); % Assigning rules 
    if fis14.rule(i).consequent == 0
        fis14.rule(i).consequent = 1;
    end
end

%%
% size(R) = 336 now i.e 15 mf params for each fis (5x2 for inputs, 5x1 for outputs)
% + 9 rules for each fis. Therefore (15+9) x 14 fis = 336 values to be
% tuned

% myodefun(t,x,P,fis1,fis2,fis3,fis4,fis5,fis6,fis7,fis8,fis9,fis10,fis11,fis12,fis13,fis14)
% X = all variables or statespace for our equations
% X = [pn;pe;pd;ub;vb;wb;phi;theta;psi;p;q;r;thetaL;phiL;thetaLdot;phiLdot;xL;yL;zL;xLdot;yLdot;zLdot]
T = 9.81;
save('tension.mat','T')
options=odeset('abstol',1e-2,'reltol',1e-4);
[t,z]=ode45(@myodefun,P.tspan,P.X0,options,P,fis1,fis2,fis3,fis4,fis5,fis6,fis7,fis8,fis9,fis10,fis11,fis12,fis13,fis14);
%[t,z]=ode45(@Pendctr,tspan,[theta1;theta2;theta1prime;theta2prime],options,m1,m2,l1,l2,g,fis1,fis2);
% n = size(z,1);

% zf = z(end,:);
% fit = zf*zf';
SI = stepinfo(z(:,1),t);
xL = z(:,17);
yL = z(:,18);
zL = z(:,19);
xLdot = z(:,20);
yLdot = z(:,21);
zLdot = z(:,22);

if t(end)<5 % Sometimes the above ode45 function will halt prematurely when it hits a singularity. This if statement penalizes such cases.
    fit = -8e+08;
else
    fit = -(SI.SettlingTime + xL'*xL + yL'*yL + zL'*zL + 10*(xLdot'*xLdot + yLdot'*yLdot + zLdot'*zLdot)); % Cost is a combination of settling time and steady state error, since we need to minimize both.
end

% Penalty constraints
if (sum((z(:,1:3)>4))~=0)
    fit = fit -8e+08;
end
if (sum((z(:,1:3)<-4))~=0)
    fit = fit -8e+08;
end
toc