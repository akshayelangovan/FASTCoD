% Written by Seyedali Mirjalili
% Modified by Akshay Elangovan for FASTCoD

function [child] = mutation(child,Pm,lb,ub)

Gene_no = length(child.Gene);

for j = 1: Gene_no
    R = rand();
    if R < Pm
         child.Gene(j) = round((ub(j)-lb(j)) * rand()) + lb(j);
    end
end

end