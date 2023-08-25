% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.


timestamp = [1,125,375];
figure()
axis([-4 4 -4 4 -4 4])
% view(30,-30)
view([0,0])
plot3(S.world(1:98,1),S.world(1:98,2),S.world(1:98,3),'*')
hold on
for i = timestamp
    axis([-4 4 -4 4 -4 4])
%     view(30,-30)
view([0 0])
    % plot3([set of X vertices],[set of Y vertices],[set of Z vertices])
    [h1,h2] = drawquad(xq(i),yq(i),zq(i),phiq(i),thetaq(i),psiq(i),r);
    hold on
    [h3,h4] = drawrod(xq(i),yq(i),zq(i),S.l,aq(i),bq(i));
    hold on
    obsloc = sensenearest(xq(i),yq(i),zq(i),S);
    distance2obs = norm(obsloc-[xq(i),yq(i),zq(i)]);
%     if distance2obs<2
%         h5 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--r');
%     else
%         h5 = plot3([obsloc(1),xq(i)],[obsloc(2),yq(i)],[obsloc(3),zq(i)],'--g');
%     end
    hold on
%     if norm(obsloc-[xq(i),yq(i),zq(i)])<S.safe_distance
%         plot3(3,-3,3,'r*');
%     else
%         plot3(3,-3,3,'g*');
%     end
    hold on
    xlabel('x_w');
    ylabel('y_w');
    zlabel('z_w');
    pause(1/P.framespersec)
    hold on
%     if (i~=1)
%         frame = getframe(gcf);
%         writeVideo(myVideo, frame);
%     end
end
hold on
% plot3(0,0,0,'m*')
% text(0,0,0.5,'Desired waypoint')
% text(-1,0,0.5,'t = 0 sec')
% text(0.75,0,-1,'t = 5 sec')

%% Path only
% figure()
% axis([-4 4 -4 4 -4 4])
% view(30,-30)
% plot3(S.world(:,1),S.world(:,2),S.world(:,3),'+')
% hold on
% % h3 = plot3(waypoints(:,1),waypoints(:,2),waypoints(:,3),'y--');
% hold on
% axis([-4 4 -4 4 -4 4])
% hold on
% for i = 1:length(t)
%     axis([-4 4 -4 4 -4 4])
%     view(30,-30)
%     plot3(xq(i),yq(i),zq(i),'.b');
%     hold on
%     plot3(xq(i)+S.l*cos(bq(i))*sin(aq(i)),yq(i)+S.l*sin(bq(i))*sin(aq(i)),zq(i)-S.l*cos(aq(i)),'.r');
%     hold on
%     xlabel('x');
%     ylabel('y');
%     zlabel('z');
%     pause(1/P.framespersec)
%     hold on
% end