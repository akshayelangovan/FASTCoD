% Copyright 2021-2023, University of Cincinnati
% All rights reserved. See LICENSE file at:
% https://github.com/akshayelangovan/FASTCoD
% Additional copyright may be held by others, as reflected in the commit history.

function [population_chrom_matrix] = seeded_initialization(M,N)
population_chrom_matrix = zeros(M,N);
seedname = input('Enter name of population seed file :   ','s');
load(seedname) % Chromosome from previous training sessions
if (N==length(BestPop(1).Gene))
    for i = 1:M
        population_chrom_matrix(i,:) = BestPop(i).Gene;
    end
else
    disp('Seed size doesnt match no. of variables')
    return
end


