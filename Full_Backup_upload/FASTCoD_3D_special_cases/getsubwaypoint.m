function [x_g,y_g,z_g] = getsubwaypoint(S,t)
if S.waypointcase == 1 || S.waypointcase == 2 || S.waypointcase == 3
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
else
    if t<6
        x_g = 1 + t;
    else
        x_g = 7;
    end
    y_g = 0;
    z_g = 0;
end
end