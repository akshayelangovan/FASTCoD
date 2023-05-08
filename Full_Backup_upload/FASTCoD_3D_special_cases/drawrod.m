function [handle1,handle2] = drawrod(x,y,z,l,a,b)
    handle1 = plot3([x,x+l*cos(b)*sin(a)],[y,y+l*sin(b)*sin(a)],[z,z-l*cos(a)],'r-');
    handle2 = plot3(x+l*cos(b)*sin(a),y+l*sin(b)*sin(a),z-l*cos(a),'ro','MarkerFaceColor','r');
    
end