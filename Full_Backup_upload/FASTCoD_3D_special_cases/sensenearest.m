function obs = sensenearest(xq,yq,zq,S)
distance = 10*ones(size(S.world,1),1);
for i = 1:size(S.world,1)
    distance(i) = norm(S.world(i,:) - [xq,yq,zq]);
end
[~,idx] = min(distance);
obs = S.world(idx,:);


    