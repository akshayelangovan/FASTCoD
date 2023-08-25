% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

function obs = sensenearest(xq,yq,zq,S)
distance = 10*ones(size(S.world,1),1);
for i = 1:size(S.world,1)
    distance(i) = norm(S.world(i,:) - [xq,yq,zq]);
end
[~,idx] = min(distance);
obs = S.world(idx,:);


    