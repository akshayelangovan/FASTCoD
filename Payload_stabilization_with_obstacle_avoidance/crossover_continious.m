%Written by Seyedali Mirjalili 

function [child1 , child2] = crossover_continious(parent1 , parent2, Pc, Problem)

child1.Gene = zeros(1,Problem.nvar);
child2.Gene = zeros(1,Problem.nvar);
for k = 1 : Problem.nvar
    beta = rand();
    child1.Gene(k) = beta * parent1.Gene(k) + (1-beta)*parent2.Gene(k); 
    child2.Gene(k) = (1-beta) * parent1.Gene(k) + beta*parent2.Gene(k);
    
    if child1.Gene(k) > Problem.ub(k) 
        child1.Gene(k)  =  Problem.ub(k);
    end
    if child1.Gene(k) < Problem.lb(k)
        child1.Gene(k) = Problem.lb(k);
    end
    
    if child2.Gene(k) > Problem.ub(k) 
        child2.Gene(k)  =  Problem.ub(k);
    end
    
    if child2.Gene(k) < Problem.lb(k)
        child2.Gene(k) = Problem.lb(k);
    end
end

R1 = rand();

if R1 > Pc
    child1 = parent1;
end

R2 = rand();

if R2 > Pc
    child2 = parent2;
end

end