
function [BestChrom]  = CGeneticAlgorithm (M , N, MaxGen , Pc, Pm , Er , Problem)

% cgcurve = zeros(1,MaxGen);

%%  Initialization
[ population ] = initialization(M, N, Problem);
for i = 1 : M
    population.Chromosomes(i).fitness = Problem.obj( population.Chromosomes(i).Gene(:),Problem);
end

% all_fitness_values = [ population.Chromosomes(:).fitness ];
% [cgcurve(1) , ~ ] = max( all_fitness_values);

g = 1;
disp(['Generation #' , num2str(g)]);

%% Main loop
for g = 2 : MaxGen
    
    tic
    disp(['Generation #' , num2str(g)]);
    % Calcualte the fitness values
    for i = 1 : M
        population.Chromosomes(i).fitness = Problem.obj( population.Chromosomes(i).Gene(:), Problem );
    end
    
    drawnow
    
    for k = 1: 2: M
        % Selection
        [ parent1, parent2] = selection(population);
        
        % Crossover
        
        [child1 , child2] = crossover_continious(parent1 , parent2, Pc, Problem);
        
        % Mutation
        
        [child1] = mutation_continious(child1, Pm, Problem);
        [child2] = mutation_continious(child2, Pm, Problem);
        
        newPopulation.Chromosomes(k).Gene = child1.Gene;
        newPopulation.Chromosomes(k+1).Gene = child2.Gene;
    end
    
    for i = 1 : M
        newPopulation.Chromosomes(i).fitness = Problem.obj( newPopulation.Chromosomes(i).Gene(:), Problem );
    end
    % Elitism
    [ newPopulation ] = elitism(population , newPopulation, Er);
    
    population = newPopulation;
    
    
% all_fitness_values = [ population.Chromosomes(:).fitness ];
%  [cgcurve(g) , ~ ] = max( all_fitness_values);
% cgcurve(g)
    toc
end

for i = 1 : M
    population.Chromosomes(i).fitness = Problem.obj( population.Chromosomes(i).Gene(:),Problem );
end


[max_val , indx] = sort([ population.Chromosomes(:).fitness ] , 'descend');
    
BestChrom.Gene    = population.Chromosomes(indx(1)).Gene;
BestChrom.Fitness = population.Chromosomes(indx(1)).fitness;
 
end