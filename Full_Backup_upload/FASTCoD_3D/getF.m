function [F,tau_theta,tau_phi] = getF( xe, xedot, ye, yedot, ze,zedot,theta,thetadot, phi, phidot, fis1,fis2,fis3,fis4,fis5,S )
%GETF FLS for computing quadrotor thrust and roll torque
%Inputs to the fis's are normalized
% if ((alpha>pi/4)) || (alpha<(-pi/4))
%     thetades = evalfis(fis4,[xe/S.max_pos_error;xedot/S.max_vel_error]);
%     tau = S.max_tau * evalfis(fis5,[(thetades-theta),tedot/S.max_vel_roll]);
%     F = S.hover_F * evalfis(fis6,[ze/S.max_pos_error;zedot/S.max_vel_error]);
% else
%     thetades = evalfis(fis1,[xe/S.max_pos_error;xedot/S.max_vel_error]);
%     tau = S.max_tau * evalfis(fis2,[(thetades-theta),tedot/S.max_vel_roll]);
%     F = S.hover_F * evalfis(fis3,[ze/S.max_pos_error;zedot/S.max_vel_error]);
% end

thetades = evalfis(fis1,[xe/S.max_pos_error;xedot/S.max_vel_error]);
tau_theta = S.max_tau * evalfis(fis2,[(thetades-theta),thetadot/S.max_vel_roll]);
phides = evalfis(fis4,[ye/S.max_pos_error;yedot/S.max_vel_error]);
tau_phi = S.max_tau * evalfis(fis5,[(phides-phi),phidot/S.max_vel_roll]);
% tau_phi = 0;
F = S.hover_F * evalfis(fis3,[ze/S.max_pos_error;zedot/S.max_vel_error]);

end
% note: removed wrapToPi command from line 6; 4/29/22
% cascade format for reference
% out1 = evalfis([pd;wb],fis1);
% out2 = evalfis([out1;zLdot],fis2);
% F = evalfis([out2;T],fis3);