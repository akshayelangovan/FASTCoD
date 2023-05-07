function [x_g,y_g,z_g] = getsubwaypoint(S,t)
if S.waypointcase == 1 || S.waypointcase == 2 || S.waypointcase == 3
    if t<8
        i=1;
    elseif t>=8 && t<16
        i=2;
    elseif t>=16 && t<24
        i=3;
    elseif t>=24 && t<30
        i=4;
    elseif t>=30 && t<38
        i=5;
    else
        i=6;
    end
    x_g = S.waypoints(i,1);
    y_g = S.waypoints(i,2);
    z_g = S.waypoints(i,3);
elseif S.waypointcase == 4
    z_g=0;
    if t<6
        x_g = 1 + t;
%         y_g = t;
y_g = 0;
    else
        x_g = 7;
%         y_g = 6;
y_g = 0;
    end
else
    x_g = 2*cos(t);
    y_g = 2*sin(t);
    
    z_g = 0;
end
end