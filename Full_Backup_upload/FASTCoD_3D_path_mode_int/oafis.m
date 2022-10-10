function [xgoal,ygoal,zgoal,yawgoal] = oafis(obsloc, xq,yq,zq,fis7)
% This function runs the Obstacle Avoidance Fuzzy Inference System with
% preprocessing the location of the obstacle

distance2obs = norm(obsloc-[xq,yq,zq]); % Euclidean Distance to Obstacle from UAV
azimuth = wrapTo2Pi(atan2((obsloc(2)-yq),(obsloc(1)-xq))); % Azimuthal angle to Obstacle from UAV
polar = acos((obsloc(3)-zq)/distance2obs); % Polar or Elevation angle to Obstacle from UAV

goal = evalfis(fis7,[distance2obs,polar,azimuth]); % Running OAFIS to get goal position
xgoal = goal(1);
ygoal = goal(2);
zgoal = goal(3);
yawgoal = atan((ygoal-yq)/(xgoal-xq)); % Calculating heading angle as yaw

end