function fit = FitFun_2(z,t,S)
%FITFUN_2 Calculates fitness
SI = stepinfo(z(:,1),t);
% xe = S.x_goal - z(:,1);
% ye = S.y_goal - z(:,2);
%ze = S.z_goal - z(:,3);
xq = z(:,1);
yq = z(:,2);
zq = z(:,3);
% aq = z(:,4);
% bq = z(:,5);
% phiq = z(:,6);
% thetaq = z(:,7);
% psiq = z(:,8);
% psie = S.yaw_goal - z(:,8);
% xqdot = z(:,9);
% yqdot = z(:,10);
% zqdot = z(:,11);
% alphadot = z(:,12);
% bqdot = z(:,13);
% phiqdot = z(:,14);
% thetaqdot = z(:,15);
% psiqdot = z(:,16);
t0 = [0;t(1:length(t)-1)];
dt = t-t0;

%fit = -(SI.SettlingTime + (alphadot'*alphadot) + 10*(xe'*dt + ze'*dt)); A0
% fit = -(SI.SettlingTime + (alphadot'*alphadot) + (abs(xe)'*dt + abs(ze)'*dt)); % A1 and A1_2; B1 
%fit = -(SI.SettlingTime + (alphadot'*alphadot) + 10*sqrt(theta'*theta) + 10*(abs(xe)'*dt +% abs(ze)'*dt)); % A3,B5 
% fit = -(SI.SettlingTime + (alphadot'*alphadot) + 10 * (abs(alphadot)'*dt + abs(xe)'*dt + abs(ze)'*dt)); % A4 - Hope is a good thing;B3,B4, B6, B7
%fit = -(SI.SettlingTime + (alphadot'*alphadot) + (xe'*xe) + (ze'*ze) + 10 * (abs(alphadot)'*dt + abs(xe)'*dt + abs(ze)'*dt)); % A4_2 - seeded training to reduce x 
% and z recovery time and A6 random initialized
%fit = -(SI.SettlingTime + 10 * (abs(alphadot)'*dt + abs(xe)'*dt + abs(ze)'*dt)); % A5 to understand the absence of the D term
% A5 does not stabilize payload, oscillates while trying to hover
% A7 has the same fitness as A4, random initialized, looks like it needs
% more generations (trained for 6 ICs)
%fit = -(SI.SettlingTime + sqrt(alphadot'*alphadot) + (abs(alphadot)'*dt + abs(xe)'*dt + abs(ze)'*dt)); % A8 and 8_2 = same as A7 but different cost function
%fit = -(sqrt(alphadot'*alphadot) + 10*(abs(alphadot)'*dt + abs(xe)'*dt + abs(ze)'*dt)); % A8_3 + B1_random_init_only movement
%fit = -((alphadot'*alphadot) + (xe'*xe) + 10*(abs(alphadot)'*dt +
%abs(xe)'*dt + abs(ze)'*dt)); J1,J2
% fit = -((alphadot'*alphadot) + 10*(abs(alphadot)'*dt + abs(xe)'*dt +
% abs(ze)'*dt)); %S1 training fit = -(SI.SettlingTime +
% (alphadot'*alphadot) + 10*(abs(xe)'*dt + abs(ze)'*dt)); 
% fit = -(SI.SettlingTime + 10*(abs(xe)'*dt + abs(ze)'*dt)); %M1, T2, T4,T5, T6 randomized %M9a
% if (abs(xe(end))>0.2)
%     fit = fit - 1000;
% end
% fit = -(SI.SettlingTime + 10*(abs(xe)'*dt + abs(ye)'*dt + abs(ze)'*dt)); %M1, T2, T4,T5, T6 randomized %M9a || 3d version M9i - has ye added
% if (abs(xe(end))>0.2)
%     fit = fit - 1000;
% end
% fit = -(10*(abs(xe)'*dt + abs(ze)'*dt)); %M2, M3 - all 8 conditions; M6 - all 4 conditions , T3
% fit = - (xe'*xe + ze'*ze); %M4 - all 4 conditions 
% fit = -10*(sqrt(xe'*xe) + sqrt(ze'*ze)); %M5 - all 4 conditions;M7 - 105*5pop size ; 25 gen
% fit = - (alphadot'*alphadot + 10*(abs(xe)'*dt + abs(ze)'*dt));  %S1   - Stabilization with  7*5
% fit = -(SI.SettlingTime + (alphadot'*alphadot) + 10 * (abs(alphadot)'*dt + abs(xe)'*dt + abs(ze)'*dt));  %S2- Stabilization with  7*5
% fit = -(SI.SettlingTime + 10*(10*abs(xe)'*dt + abs(ze)'*dt)); %M8
% fit = -(SI.SettlingTime + (alphadot'*alphadot) + 10*(abs(xe)'*dt +
% abs(ze)'*dt)); % C1; AC1

% fit = -(SI.SettlingTime + (alphadot'*alphadot) + (bqdot'*bqdot) + 10 * (abs(alphadot)'*dt + abs(bqdot)'*dt + abs(xe)'*dt + abs(ye)'*dt + abs(ze)'*dt)); %C3m
% fit = -(SI.SettlingTime + (alphadot'*alphadot) + 10 * (abs(alphadot)'*dt + abs(ye)'*dt + abs(ze)'*dt)); %C3m
% fit = -(SI.SettlingTime + 10*(abs(psie)'*dt)); %Y1
dist = zeros(size(xq));
for i = 1:size(xq,1)
    dist(i) = norm([xq(i),yq(i),zq(i)]);
end
fit = -(SI.SettlingTime + (abs(dist)'*dt));
    


end