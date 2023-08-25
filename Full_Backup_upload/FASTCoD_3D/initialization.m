% Written by Seyedali Mirjalili
% Modified by Akshay Elangovan for FASTCoD

function [population_chrom_matrix] = initialization(M,N,lb,ub)
population_chrom_matrix = zeros(M,N);
for i = 1:M
    for j = 1:N
        population_chrom_matrix(i,j) = round((ub(j)-lb(j)) * rand()) + lb(j);
    end
end
