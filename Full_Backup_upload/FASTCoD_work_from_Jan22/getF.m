% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

function [F,tau] = getF( xe, xedot, ze,zedot,theta,tedot,fis1,fis2,fis3,S )
%GETF FLS for computing quadrotor thrust and roll torque
%Inputs to the fis's are normalized

thetades = evalfis(fis1,[xe/S.max_pos_error;xedot/S.max_vel_error]);
tau = S.max_tau * evalfis(fis2,[(thetades-theta),tedot/S.max_vel_roll]); 
F = S.hover_F * evalfis(fis3,[ze/S.max_pos_error;zedot/S.max_vel_error]);
% F = 3*9.81;
% tau = 0;
end
% note: removed wrapToPi command from line 6; 4/29/22
% cascade format for reference
% out1 = evalfis([pd;wb],fis1);
% out2 = evalfis([out1;zLdot],fis2);
% F = evalfis([out2;T],fis3);