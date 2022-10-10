function fit = FitFun(R,P,fis1,fis2,fis3,trainingcase,initstate,n,w)
%FITFUN Computes performance of a chromosome by running it on a fis against
%a predefined cost function
switch trainingcase % I can basically replace this with P.n_controllers
    case 'z' %(fis3 is fisz)
        for i = 1 : P.nvar/P.n_controllers
            fis3.rule(i).consequent = R(i);
        end
    case 'x' %(fis1 is fisx, fis2 is fisroll)
        for i = 1 : P.nvar/P.n_controllers
            fis1.rule(i).consequent = R(i);
            fis2.rule(i).consequent = R(i + (P.nvar/P.n_controllers));
        end
end

% The above code can be rewritten using P.n_controllers where n controllers
% can be written at once with a for single loop
% For eg, if fis'k' has to be written, it would be written as
% fis'k'.rule(i).consequent = R(i + (k-1)*(P.nvar/P.n_controllers))

% Performing simulation to compute cost/fitness for each X0 specified in
% initstate | initstate is a m*n matrix where m is the no. of initial
% conditions and n is the no. of variables in the statespace
fit = 0;
for i = 1 : size(initstate,1)
    options=odeset('abstol',1e-3,'reltol',1e-6);
    [t,z]=ode45(@P.ode,P.tspan,initstate(i,:)',options,fis1,fis2,fis3,P);
    xe = P.x_goal - z(:,1);
    ze = P.z_goal - z(:,2);
    ae = 0 - z(:,3);
    te = 0 - z(:,4);
    xedot = 0 - z(end,5);
    zedot = 0 - z(end,6);
    aedot = 0 - z(:,7);
    tedot = 0 - z(end,8);
    if t(end)<P.T
        fit = -8e+08 + fit;
    else
        % n is a binary vector which decides what state variables will be on the cost function
        % w is a vector that contains their corresponding weights
        SI = stepinfo(z(:,1),t);
        cft1 = w(1) * (n(1)*(xe'*xe) + n(2)*(ze'*ze) + n(3)*(ae'*ae) + n(4)*(te'*te)); % cost function term inside square root
        cft2 = w(2) * (n(5)*(xedot'*xedot) + n(6)*(zedot'*zedot) + n(7)*(aedot'*aedot) + n(8)*(tedot'*tedot));
        fit = -(SI.SettlingTime + sqrt(cft1 + cft2)) + fit;
    end
end
end

