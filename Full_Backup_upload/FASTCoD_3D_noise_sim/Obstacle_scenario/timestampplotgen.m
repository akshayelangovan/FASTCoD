% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

figure()
axis([-4 4 -4 4 -4 4])
% view(30,-30)
view([0,0])
plot3(S.world(1:98,1),S.world(1:98,2),S.world(1:98,3),'*')
hold on
timestamp = [1,100,400];
for i = timestamp
    axis([-4 4 -4 4 -4 4])
%     view(30,-30)
view([0 0])
    % plot3([set of X vertices],[set of Y vertices],[set of Z vertices])
    [h1,h2] = drawquad(xq(i),yq(i),zq(i),phiq(i),thetaq(i),psiq(i),r);
    hold on
    h3 = drawrod(xq(i),yq(i),zq(i),S.l,aq(i),bq(i));
    hold on
    obsloc = sensenearest(xq(i),yq(i),zq(i),S);
    distance2obs = norm(obsloc-[xq(i),yq(i),zq(i)]);
%     if distance2obs<2
%         h4 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--r');
%     else
%         h4 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--g');
%     end
    hold on
%     if norm(obsloc-[xq(i),yq(i),zq(i)])<S.safe_distance
%         plot3(3,-3,3,'r*');
%     else
%         plot3(3,-3,3,'g*');
%     end
    hold on
    xlabel('x in meters');
    ylabel('y in meters');
    zlabel('z in meters');
    pause(1/P.framespersec)
    hold on
%     if (i~=1)
%         frame = getframe(gcf);
%         writeVideo(myVideo, frame);
%     end
%     if (i~=(length(xq)-1))
%         delete(h1)
%         delete(h2)
%         delete(h3)
%         delete(h4)
%     end
end
text(1.9,0,-1,'t = 0 sec')
text(0.7,0,-1.4,'t = 1 sec')
text(-0.5,0,-2.2,'t = 4 sec')