% Written by Seyedali Mirjalili
% Modified by Akshay Elangovan for FASTCoD

function [cgcurve,avgcurve,BestPop]  = GeneticAlgorithm (P,S)

cgcurve = zeros(1,P.MaxGen);
avgcurve = zeros(1,P.MaxGen);

%%  Initialization
switch P.seed_status
    case 'random'
        [ chromosomes_hold ] = initialization(P.M, P.nvar, P.lb, P.ub);
    case 'seeded'
        [ chromosomes_hold ] = seeded_initialization(P.M, P.nvar);
    otherwise
        disp('Error: seed_status must be random or seeded, else check if seed is passed correctly')
end

% Calculating fitness with parfor
fitness_hold = zeros(1,P.M);
parfor i = 1 : P.M
    warning('off','all');
    fitness_hold(i) = FitFun( chromosomes_hold(i,:),P,P.fis1,P.fis2,P.fis3,P.initstate,P.costfuncname,S);
end
for i = 1 : P.M
    population.Chromosomes(i).Gene = chromosomes_hold(i,:);
    population.Chromosomes(i).fitness = fitness_hold(i);
end

cgcurve(1) = max(fitness_hold);
avgcurve(1)= mean(fitness_hold);

disp('Generation #1');
%% Main loop
for g = 2 : P.MaxGen
    disp(['Generation #' , num2str(g)]);
    % Calculate the fitness values
    fitness_hold = zeros(1,P.M);
    for i = 1 :P.M
        chromosomes_hold(i,:) = population.Chromosomes(i).Gene;
    end
    parfor i = 1 : P.M
        warning('off','all')
        fitness_hold(i) = FitFun( chromosomes_hold(i,:),P,P.fis1,P.fis2,P.fis3,P.initstate,P.costfuncname,S);
    end
    for i=1:P.M
        population.Chromosomes(i).fitness = fitness_hold(i);
    end
    
    drawnow
    new_chromosome_hold = zeros(P.M,P.nvar);
    for k = 1: 2: P.M
        % Selection
        [ parent1, parent2] = selection(population);
        
        % Crossover
        [child1 , child2] = crossover(parent1 , parent2, P.Pc, P.crossovername);
        
        % Mutation
        [child1] = mutation(child1, P.Pm, P.lb, P.ub);
        [child2] = mutation(child2, P.Pm, P.lb, P.ub);
        
        % Inversion
        [child1] = inversion(child1,P.Pi);
        [child2] = inversion(child2,P.Pi);
        
        new_chromosome_hold(k,:) = child1.Gene;
        new_chromosome_hold(k+1,:) = child2.Gene;
    end
    
    parfor i = 1 : P.M
        fitness_hold(i) = FitFun( new_chromosome_hold(i,:),P,P.fis1,P.fis2,P.fis3,P.initstate,P.costfuncname,S);
    end
    for i=1:P.M
        newPopulation.Chromosomes(i).Gene = new_chromosome_hold(i,:);
        newPopulation.Chromosomes(i).fitness = fitness_hold(i);
    end
    % Elitism
    [ newPopulation ] = elitism(population , newPopulation, P.Er);
    
    population = newPopulation;
    
    
    all_fitness_values = [ population.Chromosomes(:).fitness ];
    cgcurve(g) = max( all_fitness_values);
    avgcurve(g) = mean( all_fitness_values);
end

[~ , indx] = sort([ population.Chromosomes(:).fitness ] , 'descend');

for i = 1:P.M
    BestPop(i).Gene = population.Chromosomes(indx(i)).Gene;
    BestPop(i).Fitness = population.Chromosomes(indx(i)).fitness;
end

end