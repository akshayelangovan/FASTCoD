function fit = FitFun(R,P,fis1,fis2,fis3,fis4,fis5,initstate,costfuncname,S)
%FITFUN Computes performance of a chromosome by running it on a fis against
%a predefined cost function
switch P.trainingcase % I can basically replace this with P.n_controllers
    case 'z' %(fis3 is fisz)
        for i = 1 : P.nvar/P.n_controllers
            fis3.rule(i).consequent = R(i);
        end
    case 'x' %(fis1 is fisx, fis2 is fisroll)
        for i = 1 : P.nvar/P.n_controllers
            fis4.rule(i).consequent = R(i);
            fis5.rule(i).consequent = R(i + (P.nvar/P.n_controllers));
        end
    case 'a'
        for i = 1 : P.nvar/P.n_controllers
            fis1.rule(i).consequent = R(i);
            fis2.rule(i).consequent = R(i + (P.nvar/P.n_controllers));
            fis3.rule(i).consequent = R(i + 2*(P.nvar/P.n_controllers));
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
    % t,in,fis1,fis2,fis3,M,m,g,l,J
    [t,z]=ode45(@P.ode,P.tspan,initstate(i,:)',options,fis1,fis2,fis3,fis4,fis5,S);
    if t(end)<P.T
        fit = -8e+08 + fit;
    else
        % n is a binary vector which decides what state variables will be on the cost function
        % w is a vector that contains their corresponding weights
        cft = costfuncname(z,t,S);
        fit = cft + fit;
    end
end
end

