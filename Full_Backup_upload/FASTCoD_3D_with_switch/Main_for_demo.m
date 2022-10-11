%% Code for modularized training
% Author : Akshay Elangovan

clc
close all
clear

%% Defining system specifications
S.M = 2; % Mass of quadrotor
S.m = 1; % Mass of payload
S.l = 1; % Length of rigid cable
S.J = 0.17; % Moment of inertia of quadrotor

S.g = 9.81; % acceleration due to gravity

S.hover_F = (S.M+S.m)*S.g; % Maximum thrust generated by quadrotor
S.max_tau = 10; % Maximum torque by quadrotor

S.max_pos_error = 3; % Max position error that is expected
S.max_vel_error = 3; % Max velocity error that is expected
S.max_vel_roll = 3; % Max roll velocity (angular) that is permitted

S.safe_distance = 2;

[Y,Z] = meshgrid(-3:1:3);
points = [Y(:),Z(:)];
X = ones(size(points,1),1)*3;


% Obstacle List
S.world = [X, points(:,1), points(:,2);
    points(:,1), points(:,2), -X;
    -X, points(:,1), points(:,2);
    points(:,1), points(:,2), X;
    points(:,1), -X, points(:,2)
    points(:,1), X, points(:,2)];
    
% Initial Condition List
i3 = 2/sqrt(3);
P.initstate = [...
    0 0 0 -pi/4 0 0 0 0 0 0 0 0 0 0 0 0;
    2 0 0 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    2 0 0 pi/4 0 0 0 0 0 0 0 0 0 0 0 0;
    2 0 0 -pi/4 0 0 0 0 0 0 0 0 0 0 0 0;
    0 2 0 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    0 -2 0 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 2 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    0 0 -2 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    i3 i3 i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    i3 i3 -i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    i3 -i3 i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    i3 -i3 -i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    -i3 i3 i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    -i3 i3 -i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    -i3 -i3 i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0;
    -i3 -i3 -i3 0.0001 0 0 0 0 0 0 0 0 0 0 0 0];
    

P.ode = @myodefun; % function containing system equations for odesolver

fis1 = readfis('fisx_7x5'); % FIS files being tuned
fis2 = readfis('fisroll_7x5');
fis3 = readfis('fisz_noninverted_7x5');
fis4 = readfis('fisx_7x5'); % FIS files being tuned
fis5 = readfis('fisroll_7x5');
fis6 = readfis('fisyaw_7x5');
fis7 = readfis('OAFIS5');

fis8 = readfis('fisx_7x5'); % FIS files being tuned
fis9 = readfis('fisroll_7x5');
fis10 = readfis('fisz_noninverted_7x5');
fis11 = readfis('fisx_7x5'); % FIS files being tuned
fis12 = readfis('fisroll_7x5');

tic

load('M9aa.mat');
R0 = BestChrom.Gene;
load('M9ii.mat') 
R1 = BestChrom.Gene;
load('Y1.mat');% Trained controller chromosome + fitness || Y1 - yaw control in XY
R2 = BestChrom.Gene;

load('C3.mat') 
R3 = BestChrom.Gene;
load('C4i.mat') 
R4 = BestChrom.Gene;


for i = 1 : 35
    fis1.rule(i).consequent = R0(i);
    fis2.rule(i).consequent = R0(i + (35));
    fis3.rule(i).consequent = R0(i + 2*(35));
    fis4.rule(i).consequent = R1(i); % Assigning rules
    fis5.rule(i).consequent = R1(i + (35));
    fis6.rule(i).consequent = R2(i);
    
    fis8.rule(i).consequent = R3(i);
    fis9.rule(i).consequent = R3(i + (35));
    fis10.rule(i).consequent = R3(i + 2*(35));
    fis11.rule(i).consequent = R4(i); % Assigning rules
    fis12.rule(i).consequent = R4(i + (35));
end

toc

%% User interface
        disp('Running final_check.m for testing')

%% 

P.framespersec = 50;    
P.T = 8; % duration of animation  in seconds
P.tspan=linspace(0,P.T,P.T*P.framespersec); % Generating time span


r = 0.5;

warning('off','all');

i = input('Enter initial state case (1 or 2):   ');
tic
X0 = P.initstate(i,:);

%% Simulating system

% X = all varaibles or statespace for our equations
options=odeset('abstol',1e-3,'reltol',1e-6);
[t,z]=ode45(@P.ode,P.tspan,X0,options,fis1,fis2,fis3,fis4,fis5,fis6,fis7,fis8,fis9,fis10,fis11,fis12,S);

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
% To save video, uncomment 63-65,101-104,112
% myVideo = VideoWriter('vid_obs_XZ_view_for_example_dumb');
% myVideo.FrameRate = 50;
% open(myVideo)

figure()
axis([-4 4 -4 4 -4 4])
% view(30,-30)
view([0,0])
plot3(S.world(1:98,1),S.world(1:98,2),S.world(1:98,3),'*')
hold on
for i = 1:length(t)
    axis([-4 4 -4 4 -4 4])
%     view(30,-30)
view([0 0])
    % plot3([set of X vertices],[set of Y vertices],[set of Z vertices])
    [h1,h2] = drawquad(xq(i),yq(i),zq(i),phiq(i),thetaq(i),psiq(i),r);
    hold on
    h3 = drawrod(xq(i),yq(i),zq(i),S.l,aq(i),bq(i));
    hold on
    obsloc = sensenearest(xq(i),yq(i),zq(i),S);
    distance2obs = norm(obsloc-[xq(i),yq(i),zq(i)]);
    if distance2obs<2
        h4 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--r');
    else
        h4 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--g');
    end
    hold on
    if norm(obsloc-[xq(i),yq(i),zq(i)])<S.safe_distance
        plot3(3,-3,3,'r*');
    else
        plot3(3,-3,3,'g*');
    end
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
        delete(h4)
    end
end
% close(myVideo)

% fit = FitFun(z,t,S);
% disp('Fitness of the current run:')
% disp(fit)

%% Plots

% Plotting UAV Positions
figure()
plot(t,xq,t,yq,t,zq,t,zeros(size(t)))
legend('x_q','y_q','zq','x,y,z desired')
title('Time vs Position States')

% Plot UAV Velocities
figure()
plot(t,xqdot,t,yqdot,t,zqdot)
legend('x velocity','y velocity','z velocity')
title('Time vs Velocity States')

% Plot UAV Path
figure();
plot3(xq, yq, zq);
xlabel('xq in meters');
ylabel('yq in meters');
zlabel('zq in meters');
title('UAV path');

% Plot Payload Cable Angle
figure()
plot(t,aq,t,zeros(size(t)))
legend('\alpha')
title('Time vs Cable Angle')
xlabel('Seconds')
ylabel('Radians')

% % Plot force inputs
% F = zeros(1,length(t));
% tau_pitch = F;
% tau_roll = F;
% tau_yaw = F;
% 
% for i=1:length(xq)
%     obs = sensenearest(xq(i),yq(i),zq(i),S);
%     [x_goal, y_goal, z_goal, yaw_goal] = oafis(obs,xq(i),yq(i),zq(i),fis7);
%     xe = x_goal; % calculating x_error
%     ye = y_goal; % calculating y_error
%     ze = z_goal; % calculating z_error
%     psie = yaw_goal - psiq(i);
%     
%     if norm(obs-[xq(i),yq(i),zq(i)])<S.safe_distance
%         [f,t_theta,t_phi,t_psi] = getF(xe,xqdot(i),ye,yqdot(i),ze,zqdot(i),thetaq(i),thetaqdot(i),phiq(i),phiqdot(i),psie,psiqdot(i),fis1,fis2,fis3,fis4,fis5,fis6,S);
%     else
%         [f,t_theta,t_phi,t_psi] = getF(xe,xqdot(i),ye,yqdot(i),ze,zqdot(i),thetaq(i),thetaqdot(i),phiq(i),phiqdot(i),psie,psiqdot(i),fis8,fis9,fis10,fis11,fis12,fis6,S);
%     end
%     F(i) = f;
%     tau_pitch(i) = t_theta;
%     tau_roll(i) = t_phi;
%     tau_yaw(i) = t_psi;
% end

% figure()
% plot(t,F)
% xlabel('time (s)')
% ylabel('Total Thrust (N)')
% 
% figure()
% plot(t,tau_pitch)
% xlabel('time (s)')
% ylabel('Pitch Torque (Nm)')

 %% End       