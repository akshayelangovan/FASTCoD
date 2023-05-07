figure()
axis([-4 4 -4 4 -4 4])
% view(30,-30)
view([0,0])
% plot3(S.world(1:98,1),S.world(1:98,2),S.world(1:98,3),'*')
hold on
timestamp = [1];
for i = timestamp
    axis([-4 4 -4 4 -4 4])
%     view(30,-30)
view([0 0])
    % plot3([set of X vertices],[set of Y vertices],[set of Z vertices])
    [h1,h2] = drawquad(xq(i)-2,yq(i),zq(i),phiq(i),thetaq(i),psiq(i),r);
    hold on
    h3 = drawrod(xq(i)-2,yq(i),zq(i),S.l,aq(i),bq(i));
    hold on
%     obsloc = sensenearest(xq(i),yq(i),zq(i),S);
%     distance2obs = norm(obsloc-[xq(i),yq(i),zq(i)]);
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
hold on
plot3(0,0,0,'r*')
text(0,0,0.5,'Desired waypoint')
% text(-1,0,0.5,'t = 0 sec')
% text(0.75,0,-1,'t = 5 sec')