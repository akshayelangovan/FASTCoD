function handle = drawrod(x,y,z,l,a,b)
    handle = plot3([x,x+l*cos(b)*sin(a)],[y,y+l*sin(b)*sin(a)],[z,z-l*cos(a)],'r-');
end