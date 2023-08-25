% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

fis1 = P.fis1;
fis2 = P.fis2;
fis3 = P.fis3;
fis4 = P.fis4;
fis5 = P.fis5;
fis6 = P.fis6;
fis7 = P.fis7;
fis8 = P.fis8;
fis9 = P.fis9;
fis10 = P.fis10;
fis11 = P.fis11;
fis12 = P.fis12;

    
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
distancetoobs = z(:,1);
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
    [h3,h4] = drawrod(xq(i),yq(i),zq(i),S.l,aq(i),bq(i));
    hold on
    obsloc = sensenearest(xq(i),yq(i),zq(i),S);
    distance2obs = norm(obsloc-[xq(i),yq(i),zq(i)]);
    distancetoobs(i) = distance2obs;
    if distance2obs<2
        h5 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--r');
    else
        h5 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--g');
    end
    hold on
    if norm(obsloc-[xq(i),yq(i),zq(i)])<S.safe_distance
        plot3(3,-3,3,'r*');
    else
        plot3(3,-3,3,'g*');
    end
    hold on
    xlabel('x_w');
    ylabel('y_w');
    zlabel('z_w');
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
        delete(h5)
    end
end
% close(myVideo)

% fit = P.costfuncname(z,t,S);
% disp('Fitness of the current run:')
% disp(fit)

%% Plots
% 
% Plotting error
figure()
plot(t,xq,t,yq,t,zq)
legend('x_q','y_q','z_q')
ylabel('x_q,y_q,z_q in meters')
xlabel('Time in seconds')
title('UAV Position States vs Time')

% Plot UAV Path
figure();
plot3(S.world(1:98,1),S.world(1:98,2),S.world(1:98,3),'*')
hold on
plot3(xq, yq, zq,'b');
view([0 0])
xlabel('x_w');
ylabel('y_w');
zlabel('z_w');
title('UAV path');
axis([-4 4 -4 4 -4 4])

% Plot Payload Cable Angle
figure()
plot(t,rad2deg(aq),t,zeros(size(t)))
title('Cable Angle vs Time')
xlabel('Time in seconds')
ylabel('\alpha in degrees')

% plot distance to closest obstacle
figure()
plot(t,distancetoobs)
ylabel('Distance in meters');
xlabel('Time in seconds')
title('Distance between UAV and closest obstacle vs Time')
ylim([0 3.5])
hold on
yline(2)
legend('Distance to obstacle','Safe distance')

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

% figure(2);
% hold on
% plot(xq, zq);
% plot3(xq,zq,t);
% xlabel('xq in meters');
% ylabel('zq in meters');
% zlabel('t(ime) in seconds');
% view(-35,25); % azimuth = -35deg, elevation = 25deg
% hold off