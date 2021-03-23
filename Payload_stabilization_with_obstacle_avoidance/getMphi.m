function Mphi = getMphi( pe,vb,yLdot,phiLdot,phi,p,fis5,fis6,fis7,fis8,fis9 )
%GETMPHI CFLS for computing quadrotor roll torque

out1 = evalfis([pe;vb],fis5);
out2 = evalfis([out1;yLdot],fis6);
out3 = evalfis([out2;phiLdot],fis7);
out4 = evalfis([out3;phi],fis8);
Mphi = evalfis([out4;p],fis9);

end

