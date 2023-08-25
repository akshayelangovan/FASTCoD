% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

function out = ctrimf(x,params)
%CTRIMF Custom triangular membership function for cyc;ic membership ranges
%   Detailed explanation goes here
for i = 1:length(x)
    if x(i) < params(1)
        y(i) = 0;
    elseif x(i)>=params(1) && x(i)<=params(2)
        y(i) = (params(2)-x(i))/(params(2)-params(1));
    elseif x(i)>params(2) && x(i)<params(3)
        y(i) = 0;
    elseif x(i)>=params(3) && x(i)<=params(4)
        y(i) = (x(i)-params(3))/(params(4)-params(3));
    elseif x(i)>params(4)
        y(i) = 0;
    end
    
    out = 1*y';
end

