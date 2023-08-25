% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

tic
load('M9a.mat') % Trained controller chromosome + fitness

R = BestChrom.Gene;

fis1 = P.fis1;
fis2 = P.fis2;
fis3 = P.fis3;

P.T = 8; % duration of animation  in seconds
P.tspan=linspace(0,P.T,P.T*P.framespersec); % Generating time span

S.x_goal = 0;
S.z_goal = 0;

r = 0.5;

warning('off','all');

%% Applying trained chromosome to controllers

if (length(R)==P.nrules*2)
    %FIS1 - fx controller
    %FIS2 - tau controller
    % Tuning Rules
    for i = 1:P.nvar/P.n_controllers
        fis1.rule(i).consequent = R(i); % Assigning rules
        fis2.rule(i).consequent = R(i + (P.nvar/P.n_controllers));
    end
elseif (length(R)==P.nrules)
    %FIS3 - F controller
    % Tuning Rules
    for i = 1:P.nvar/P.n_controllers
        fis3.rule(i).consequent = R(i); % Assigning rules
    end
elseif (length(R)==P.nrules*3)
    for i = 1:P.nvar/P.n_controllers
        fis1.rule(i).consequent = R(i); % Assigning rules
        fis2.rule(i).consequent = R(i + (P.nvar/P.n_controllers));
        fis3.rule(i).consequent = R(i + 2*(P.nvar/P.n_controllers));
    end
end

toc
i = input('Enter initial state case (1 or 2):   ');
tic
X0 = P.initstate(i,:);

%% Simulating system

% X = all varaibles or statespace for our equations
options=odeset('abstol',1e-3,'reltol',1e-6);
[t,z]=ode45(@P.ode,P.tspan,X0,options,fis1,fis2,fis3,S);

xq = z(:,1);
zq = z(:,2);
aq = z(:,3);
tq = z(:,4);
xqdot = z(:,5);
zqdot = z(:,6);
aqdot = z(:,7);
tqdot = z(:,8);
t0 = [0;t(1:length(t)-1)];
dt = t-t0;

% Calculating Errors

xe = S.x_goal - xq;
ze = S.z_goal - zq;

toc

%% Animating
% To save video, uncomment 75-77, 90-91 and 98
% myVideo = VideoWriter('T5_videoa');
% myVideo.FrameRate = 50;
% open(myVideo)

figure()
axis([-4 4 -4 4])
for i = 1:length(xq)
    axis([-4 4 -4 4])
    h1 = plot([xq(i)-r*cos(tq(i)),xq(i)+r*cos(tq(i))],[zq(i)+r*sin(tq(i)),zq(i)-r*sin(tq(i))],'b-','LineWidth',2);
    hold on
    h2 = plot([xq(i),xq(i)+S.l*sin(aq(i))],[zq(i),zq(i)-S.l*cos(aq(i))],'k-','LineWidth',1);
    hold on
    h3 = viscircles([xq(i)+S.l*sin(aq(i)),zq(i)-S.l*cos(aq(i))],0.05,'LineStyle','-','LineWidth',1.25);
    pause(1/P.framespersec)
    hold on
%     h4 = plot(0,0,'-x','MarkerEdgeColor','red','MarkerSize',15);
%     frame = getframe(gcf);
%     writeVideo(myVideo, frame);
    if (i~=(length(xq)-1))
        delete(h1)
        delete(h2)
        delete(h3)
    end
end
% close(myVideo)

fit = P.costfuncname(z,t,S);
disp('Fitness of the current run:')
disp(fit)

%% Plots
% 
% Plotting error
figure()
plot(t,zq,t,xq,t,tq,t,zeros(size(t)))
legend('z_q','x_q','tq','x,z desired')
title('Time vs Position States')

figure()
plot(t,aq,t,zeros(size(t)))
legend('a_q')
title('Time vs Cable Angle')
xlabel('Seconds')
ylabel('Radians')
%xe, xedot, ze,zedot,theta,tedot,fis1,fis2,fis3,S
F = zeros(1,length(t));
tau = F;
for i=1:length(xq)
    xe = S.x_goal - xq(i);
    ze = S.z_goal - zq(i);
    thetades = evalfis(fis1,[xe/S.max_pos_error,xqdot(i)/S.max_vel_error]);
    tau_t = S.max_tau * evalfis(fis2,[wrapToPi(thetades-tq(i)),tqdot(i)/S.max_vel_roll]);
    f_t = S.hover_F * evalfis(fis3,[ze/S.max_pos_error,zqdot(i)/S.max_vel_error]);
    F(i) = f_t;
    tau(i) = tau_t;
end

figure()
plot(t,F)
xlabel('time (s)')
ylabel('Total Thrust (N)')

figure()
plot(t,tau)
xlabel('time (s)')
ylabel('Roll Torque (Nm)')
% 
% figure()
% plot(t,ze.*ze,t,xe.*xe)
% legend('z_e^2','x_e^2')
% title('Time vs Position States')
% 
% figure()
% plot(t,zqdot,t,xqdot,t,zeros(size(t)))
% legend('z_qdot','x_qdot','final desired velocity')
% title('Time vs Velocity States')
% 
% figure();
% plot(xq, zq);
% xlabel('xq in meters');
% ylabel('zq in meters');
% title('UAV path');

% figure(2);
% hold on
% plot(xq, zq);
% plot3(xq,zq,t);
% xlabel('xq in meters');
% ylabel('zq in meters');
% zlabel('t(ime) in seconds');
% view(-35,25); % azimuth = -35deg, elevation = 25deg
% hold off