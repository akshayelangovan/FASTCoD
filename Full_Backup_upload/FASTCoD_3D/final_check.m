tic

fis1 = P.fis1;
fis2 = P.fis2;
fis3 = P.fis3;
fis4 = P.fis4;
fis5 = P.fis5;

load('M9aa.mat');% Trained controller chromosome + fitness || M9a - motion tracking in XZ, C3 - stabilization in XZ
% load('C3.mat');
R0 = BestChrom.Gene;

for i = 1 : P.nrules
    fis1.rule(i).consequent = R0(i);
    fis2.rule(i).consequent = R0(i + (P.nvar/P.n_controllers));
    fis3.rule(i).consequent = R0(i + 2*(P.nvar/P.n_controllers));
end

% load('M9ii.mat') 
load('C4ii.mat');
R1 = BestChrom.Gene;

for i = 1:P.nrules
    fis4.rule(i).consequent = R1(i); % Assigning rules
    fis5.rule(i).consequent = R1(i + (P.nvar/P.n_controllers));
end

P.T = 10; % duration of animation  in seconds
P.tspan=linspace(0,P.T,P.T*P.framespersec); % Generating time span


r = 0.5;

warning('off','all');

%% Applying trained chromosome to controllers

% if (length(R1)==P.nrules*2)
%     %FIS1 - fx controller
%     %FIS2 - tau controller
%     % Tuning Rules
% 
% elseif (length(R1)==P.nrules)
%     %FIS3 - F controller
%     % Tuning Rules
%     for i = 1:P.nvar/P.n_controllers
%         fis3.rule(i).consequent = R1(i); % Assigning rules
%     end
% elseif (length(R1)==P.nrules*3)
%     for i = 1:P.nvar/P.n_controllers
%         fis1.rule(i).consequent = R1(i); % Assigning rules
%         fis2.rule(i).consequent = R1(i + (P.nvar/P.n_controllers));
%         fis3.rule(i).consequent = R1(i + 2*(P.nvar/P.n_controllers));
%     end
% end
% load('M9a.mat') % Trained controller chromosome + fitness
% 
% R2 = BestChrom.Gene;
% 
% if (length(R2)==P.nrules*2)
%     %FIS1 - fx controller
%     %FIS2 - tau controller
%     % Tuning Rules
%     for i = 1:P.nvar/P.n_controllers
%         fis4.rule(i).consequent = R2(i); % Assigning rules
%         fis5.rule(i).consequent = R2(i + (P.nvar/P.n_controllers));
%     end
% elseif (length(R2)==P.nrules)
%     %FIS3 - F controller
%     % Tuning Rules
%     for i = 1:P.nvar/P.n_controllers
%         fis6.rule(i).consequent = R2(i); % Assigning rules
%     end
% elseif (length(R2)==P.nrules*3)
%     for i = 1:P.nvar/P.n_controllers
%         fis4.rule(i).consequent = R2(i); % Assigning rules
%         fis5.rule(i).consequent = R2(i + (P.nvar/P.n_controllers));
%         fis6.rule(i).consequent = R2(i + 2*(P.nvar/P.n_controllers));
%     end
% end

toc
i = input('Enter initial state case (1 or 2):   ');
tic
X0 = P.initstate(i,:);

%% Simulating system

% X = all varaibles or statespace for our equations
options=odeset('abstol',1e-3,'reltol',1e-6);
[t,z]=ode45(@P.ode,P.tspan,X0,options,fis1,fis2,fis3,fis4,fis5,S);

xq = z(:,1);
yq = z(:,2);
zq = z(:,3);
aq = z(:,4);
bq = z(:,5);
phiq = z(:,6);
thetaq = z(:,7);
psiq = z(:,8);

xqdot = z(:,9);
yqdot = z(:,10);
zqdot = z(:,11);
aqdot = z(:,12);
bqdot = z(:,13);
phiqdot = z(:,14);
thetaqdot = z(:,15);
psiqdot = z(:,16);

t0 = [0;t(1:length(t)-1)];
dt = t-t0;

% Calculating Errors

% xe = S.x_goal - xq;
% ze = S.z_goal - zq;

toc

%% Animating
% To save video, uncomment 113-115,133-136,143
% myVideo = VideoWriter('vid_yz_c2_theta_zero');
% myVideo.FrameRate = 50;
% open(myVideo)

figure()
axis([-4 4 -4 4 -4 4])
view(30,30)
for i = 1:length(t)
    axis([-4 4 -4 4 -4 4])
    view(30,30)
    % plot3([set of X vertices],[set of Y vertices],[set of Z vertices])
    [h1,h2] = drawquad(xq(i),yq(i),zq(i),phiq(i),thetaq(i),psiq(i),r);
    hold on
    h3 = drawrod(xq(i),yq(i),zq(i),S.l,aq(i),bq(i));
    hold on
    xlabel('x');
    ylabel('y');
    zlabel('z');
    pause(1/P.framespersec)
    hold on
%     if (i~=1)
%         frame = getframe(gcf);
%         writeVideo(myVideo, frame);
%     end
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
plot(t,xq,t,yq,t,zq,t,zeros(size(t)))
legend('x_q','y_q','zq','x,y,z desired')
title('Time vs Position States')

% figure()
% plot(t,aq,t,zeros(size(t)))
% legend('a_q')
% title('Time vs Cable Angle')
% xlabel('Seconds')
% ylabel('Radians')
% %xe, xedot, ze,zedot,theta,tedot,fis1,fis2,fis3,S
% F = zeros(1,length(t));
% tau = F;
% for i=1:length(xq)
%     xe = S.x_goal - xq(i);
%     ze = S.z_goal - zq(i);
%     thetades = evalfis(fis1,[xe/S.max_pos_error,xqdot(i)/S.max_vel_error]);
%     tau_t = S.max_tau * evalfis(fis2,[wrapToPi(thetades-tq(i)),tqdot(i)/S.max_vel_roll]);
%     f_t = S.hover_F * evalfis(fis3,[ze/S.max_pos_error,zqdot(i)/S.max_vel_error]);
%     F(i) = f_t;
%     tau(i) = tau_t;
% end
% 
% figure()
% plot(t,F)
% xlabel('time (s)')
% ylabel('Total Thrust (N)')
% 
% figure()
% plot(t,tau)
% xlabel('time (s)')
% ylabel('Roll Torque (Nm)')
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