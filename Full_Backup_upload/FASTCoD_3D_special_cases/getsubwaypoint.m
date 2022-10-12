function [x_g,y_g,z_g] = getsubwaypoint(S,t)
if t>8 && t<16
    i=2;
elseif t>=16
    i=3;
else
    i=1;
end
x_g = S.waypoints(i,1);
y_g = S.waypoints(i,2);
z_g = S.waypoints(i,3);
end