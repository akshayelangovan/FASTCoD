function Mtheta = getMtheta( pn,ub,xLdot,thetaLdot,theta,q,fis10,fis11,fis12,fis13,fis14 )
%GETMTHETA CFLS for computing quadrotor pitch torque

out1 = evalfis([pn;ub],fis10);
out2 = evalfis([out1;xLdot],fis11);
out3 = evalfis([out2;thetaLdot],fis12);
out4 = evalfis([out3;theta],fis13);
Mtheta = evalfis([out4;q],fis14);

end

