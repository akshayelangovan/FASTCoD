%Written by Seyedali Mirjalili 

function [child] = mutation_continious(child, Pm, Problem)

Gene_no = length(child.Gene);

for k = 1: Gene_no
    R = rand();
    if R < Pm
        child.Gene(k) = (Problem.ub(k) - Problem.lb(k)) * rand() + Problem.lb(k);
    end
end

end