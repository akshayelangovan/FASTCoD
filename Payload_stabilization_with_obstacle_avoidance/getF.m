function F = getF( pd,wb,zLdot,T,fis1,fis2,fis3 )
%GETF CFLS for computing quadrotor thrust
out1 = evalfis([pd;wb],fis1);
out2 = evalfis([out1;zLdot],fis2);
F = evalfis([out2;T],fis3);

end

