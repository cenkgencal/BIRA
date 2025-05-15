%%%%%%%%%%%%%% Bipolar Roosters Main Code %%%%%%%%%%%%%%%%%%%%%%
function offspring=bi_rstr(roo,ch,num_roo,Ub,Lb,dim,f_name)
n=dim;

ro_size=size(roo,1);
ch_size=size(ch,1);

sz2=size(ch,2);
ro_can=zeros(num_roo,sz2);

o=zeros(ch_size,sz2,num_roo);
offspring=zeros(ch_size,sz2);

for i=1:ch_size
    % Roosters that want to mate with chicken_i is chosen
    for j=1 : num_roo
        at1=ceil((ro_size-1)*rand+1);
        ro_can(j,:)=roo(at1,:);
    end
    
    for k=1 : num_roo
        % In this step, roosters dance around the chicken_i
        % If a rooster finds a better point than chicken_i has, then he can mate
        points = dancing(ro_can(k,:),ch(i,:),ch_size);
        cost_r = feval(f_name,points);
        % For a minimization problem
        [~,ind1] = min(cost_r);
        
        cost_ch = feval(f_name,ch);
        
        % For a minimization problem ( for maximization, make it ">" )
        if cost_r(ind1) <= cost_ch
            o(i,:,k) =ro_can(k,:)./2+ch(i,:)./2+(1/2+0.1).*abs(ch(i,:) - ro_can(k,:)).*(2*rand-1);            
        end

    end
    cost_rocan = feval(f_name,ro_can);
    [~,in] = max(cost_rocan);
    % Bipolar Attitude
    if rand <= 0.25
        if size(o,3)==1
            offspring(i,:) = o(i,:,:);
        else
        % If attractive chicken has more than one male, get the best one or
        % the worst one based on the random value
            cost_o = feval(f_name,o(i,:,:));
            [~,ind2] = min(cost_o);
            offspring(i,:) = o(i,:,ind2(1));
        end
    else
        offspring(i,:) = ro_can(in(1),:)./2+ch(i,:)./2+(1/2+0.1).*abs(ch(i,:) - ro_can(in(1),:)).*(2*rand-1); 
    end
end

%%%%%%%%%%%%%%%%% Mending %%%%%%%%%%%%%%%%
    % Fixing the problem that having the value greater than upper limit or
    % less than lower limit by assign upper limits or lower limits to the value
    for m=1:n
        ind3=find(offspring(:,m) > Ub(m));
        offspring(ind3,m) = Ub(m);
        ind4=find(offspring(:,m) < Lb(m));
        offspring(ind4,m) = Lb(m);
    end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%