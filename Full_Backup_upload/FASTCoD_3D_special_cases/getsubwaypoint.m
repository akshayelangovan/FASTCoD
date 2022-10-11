function [x_g,y_g,z_g] = getsubwaypoint(S,t)
 i=1;
 if t>4
     i=2;
 end
x_g = S.waypoints(i,1);
y_g = S.waypoints(i,2);
z_g = S.waypoints(i,3);
end