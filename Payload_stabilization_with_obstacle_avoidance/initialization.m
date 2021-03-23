function [population] = initialization(M,N,P)

for i = 1:M
    for j = 1:N
        population.Chromosomes(i).Gene(j) = (P.ub(j)-P.lb(j)) * rand() + P.lb(j);
    end
end
