function [handle1, handle2] = drawquad(x, y, z, phi, theta, psi, r)

Rx = [...
    1 0 0;
    0 cos(phi) -sin(phi);
    0 sin(phi) cos(phi)];
Ry = [...
    cos(theta) 0 sin(theta);
    0 1 0;
    -sin(theta) 0 cos(theta)];
Rz = [...
    cos(psi) -sin(psi) 0;
    sin(psi) cos(psi) 0;
    0 0 1];

Rb2i = Rz*Ry*Rx;
X0 = [x;y;z];
X1 = Rb2i * [r;0;0];
X2 = Rb2i * [0;r;0];
X3 = Rb2i * [-r;0;0];
X4 = Rb2i * [0;-r;0];

handle1 = plot3([X0(1) + X1(1), X0(1) + X3(1)],[X0(2) + X1(2), X0(2) + X3(2)],[X0(3) + X1(3), X0(3) + X3(3)],'-b');
handle2 = plot3([X0(1) + X2(1), X0(1) + X4(1)],[X0(2) + X2(2), X0(2) + X4(2)],[X0(3) + X2(3), X0(3) + X4(3)],'-b');

end