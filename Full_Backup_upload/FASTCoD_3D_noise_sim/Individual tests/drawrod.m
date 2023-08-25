% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

function handle = drawrod(x,y,z,l,a,b)
    handle = plot3([x,x+l*cos(b)*sin(a)],[y,y+l*sin(b)*sin(a)],[z,z-l*cos(a)],'r-');
end