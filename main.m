close all;clear;clc;
dim = 2;
pop = 20;
gen = 100000;
beta = 1;
cr = 0.2;
%A = [1 2 3;8 2 7;2 5 6];
A = [1 2 ;3 4];
minx = -1 * max(max(A));
maxx = max(max(A));
X=rand(dim*dim, pop);
X
[fit] = invMatFit(A, X, dim);
fitTrack = [];
bestFitUntilNow = 100000;

X(:,4) = [-2;1;1.5;-0.5];
for i = 1:gen
    U=[];
for p = 1:pop    
    
    randX= linspace(1,pop,pop);randX(p) = [];
    px1=ceil(rand(1,1)*numel(randX));x1=randX(px1);randX(px1)=[];
    px2=ceil(rand(1,1)*numel(randX));x2=randX(px2);randX(px2)=[];
    px3=ceil(rand(1,1)*numel(randX));x3=randX(px3);randX(px3)=[];
    M = X(:,x1) + beta .* (X(:,x2) - X(:,x3));
    tcr = rand(dim*dim,1);
    for t=1:numel(tcr)
        if tcr(t) > cr, M(t) = X(t,p);end
        %if M(t) > maxx, M(t) = maxx;end
        %if M(t) < minx, M(t) = minx;end
        if M(t) > maxx, M(t) = floor(minx+(maxx-minx)*rand(1,1));end
        if M(t) < minx, M(t) = floor(minx+(maxx-minx)*rand(1,1));end        
    end
    
    U=[U M];
    
end    
    [MutantFit] = invMatFit(A, U, dim);
   
    for t = 1:numel(MutantFit)
        if MutantFit(t) < fit(t) && MutantFit(t)>=0, 
            X(:,t) = U(:,t); 
            fit(t) = MutantFit(t);
        end
        if MutantFit(t) > fit(t) && MutantFit(t)<0, 
            X(:,t) = U(:,t);
            fit(t) = MutantFit(t);
        end
        
    end
    
%      [bestFit, loc] = min(fit);
%     if bestFit < bestFitUntilNow && bestFit >= 0,bestFitUntilNow = bestFit;end    
%     if bestFit > bestFitUntilNow && bestFit < 0,bestFitUntilNow = bestFit;end
%     
%     fitTrack = [fitTrack bestFitUntilNow];
     fitTrack = [fitTrack;fit];    
    
end

disp('expected answer');
inv(A)

for i = 1:pop
    r=reshape(X(:,i),dim,dim);
    A*r
end

figure(1);clf;
 plot(linspace(1,gen,gen),fitTrack(:,:));hold on;
% plot(linspace(1,gen,gen),fitTrack(:,1), 'b-');hold on;
% plot(linspace(1,gen,gen),fitTrack(:,2), 'r-');hold on;
% plot(linspace(1,gen,gen),fitTrack(:,3), 'g-');hold on;
% plot(linspace(1,gen,gen),fitTrack(:,4), 'c-');

