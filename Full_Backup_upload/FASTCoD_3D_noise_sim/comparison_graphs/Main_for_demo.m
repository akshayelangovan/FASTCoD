%% Code for modularized training
% Author : Akshay Elangovan

clc
close all
clear

rng(2323)

load('clean.mat')

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

distancetoobs_clean = distancetoobs;

load('error5.mat')
z_with_error = z_with_error5;

xq_noisy = z_with_error(:,1);
yq_noisy = z_with_error(:,2);
zq_noisy = z_with_error(:,3);
aq_noisy = z_with_error(:,4);
bq_noisy = z_with_error(:,5);
phiq_noisy = z_with_error(:,6);
thetaq_noisy = z_with_error(:,7);
psiq_noisy = z_with_error(:,8);

xqdot_noisy = z_with_error(:,9);
yqdot_noisy = z_with_error(:,10);
zqdot_noisy = z_with_error(:,11);
aqdot_noisy = z_with_error(:,12);
bqdot_noisy = z_with_error(:,13);
phiqdot_noisy = z_with_error(:,14);
thetaqdot_noisy = z_with_error(:,15);
psiqdot_noisy = z_with_error(:,16);

distancetoobs_noisy = distancetoobs;

%% Plots

% Plotting UAV Positions
figure()
plot(t,xq,t,xq_noisy,t,yq,t,yq_noisy,t,zq,t,zq_noisy)
legend('x_q','x_qn','y_q','y_qn','z_q','z_qn')
xlabel('Time in seconds')
ylabel('UAV position in meters')
ylim([-1 3])

% % Plot UAV Velocities
% figure()
% plot(t,xqdot,t,yqdot,t,zqdot)
% legend('x velocity','y velocity','z velocity')
% title('Time vs Velocity States')

figure()
plot(t,distancetoobs_clean,t,distancetoobs_noisy)
ylabel('Distance in meters');
xlabel('Time in seconds')
legend('Clean','Noisy')
title('Distance between UAV and closest obstacle over time')
ylim([0 3.5])
% 
% % Plot UAV Path
% figure();
% plot3(xq, yq, zq);
% xlabel('x_q in meters');
% ylabel('y_q in meters');
% zlabel('z_q in meters');
% title('UAV path');
% xlim([-1 3]);
% ylim([-2 2]);
% zlim([-2 2]);
% 
% Plot Payload Cable Angle
figure()
plot(t,rad2deg(aq),t,rad2deg(aq_noisy),t,zeros(size(t)))
legend('\alpha','\alpha_n')
title('Time vs Cable Angle')
xlabel('Seconds')
ylabel('Degrees')


 %% End       