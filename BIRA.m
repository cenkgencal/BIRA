%  --------------- BIPOLAR IMPROVED ROOSTERS ALGORITHM --------------------

% --------------------------- Inputs --------------------------------------
% The algorithm gets seven parameters:
% popsize                       : Size of the population
% maxIter                       : Number of generations
% num_roo                       : Maximum number of roosters that can mate with a chiken
% ul                            : Upper limit 
% ll                            : Lower limit
% dim                           : Dimension of an individual 
% f_name                        : The name of objective function which must
%                                 be entered like 'function name'.
% -------------------------------------------------------------------------

% ------------------------ Outputs ----------------------------------------
% mincost                       : The found minimum fitness value
% value                         : The individual having mincost value
% bests                         : All bests throughout iterations
% -------------------------------------------------------------------------

function [mincost,value,bests]=BIRA(popsize, maxIter,num_roo,ul,ll,dim,f_name,seed)

rng(seed);
% As an example, you can call the algorithm like;
% [mincost,value,bests]=BIRA(100,100,4,5,-5,2,'dejong',1)

n = dim;
ff=f_name;

%%%%%%%%%%%% Initialization %%%%%%%%%%%%%%%%

% Creating population having default values
pop=ones(popsize,n);

% Using ul and ll, we create our population
Lb = ll*ones(1,n); 
Ub = ul*ones(1,n);
for i=1:popsize
    pop(i,:) = Lb+(Ub-Lb).*rand(size(Lb));
end

% For plotting
% iter=1:maxIter;

count=maxIter;
bests=zeros(maxIter,1);

while maxIter>0
    
    %%%%%%%%%%%% Identification %%%%%%%%%%%%%%%%%%
    cost=feval(ff,pop);
    [~,in]=sort(cost);
    ch=pop(in(1:round(popsize/2)),:);
    roo=pop(in(round(popsize/2)+1:popsize),:);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%% Main Part of the Code %%%%%%%%%%%%%%%
    offspring=bi_rstr(roo,ch,num_roo,Ub,Lb,dim,f_name);
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    %%%%%%%%%%%%%%% Elitism %%%%%%%%%%%%%%%%%%%%%%
    n_elit=popsize*0.1;
    if n_elit<1
        n_elit=1;
    end
    part1=pop(in(1:popsize-n_elit),:);
    cost_off=feval(ff,offspring);
    [~,in1]=sort(cost_off);
    part2=offspring(in1(1:n_elit),:);
    pop=[part1;part2];
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    
    % Finding the best for each iteration
    maxIter=maxIter-1;
    index=count-maxIter;
    cost=feval(ff,pop);
    [val,~]=min(cost);
    bests(index,:)=val;
end

last_cost=feval(ff,pop);
[mincost,in]=min(last_cost);
value=pop(in,:);

% For plotting
% figure, semilogy(iter,bests,'r');
% xlabel('Iterations');
% ylabel('Best Value');




