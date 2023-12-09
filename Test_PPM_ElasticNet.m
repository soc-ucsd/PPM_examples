clc; clear; close all
%PPM for ElasticNet
%Package requirement: Yalmip and Mosek

datapath = 'example/';
savepath = 'results/PPM/ElasticNet/';
name     = {'n10m40s5','n20m50s10','n30m60s15'};
c        = 1;

load([datapath,name{c},'.mat']);
Out_True = load(['results/GroundTrue/ElasticNet/',name{c},'.mat']);

m        = width(X);
n        = height(X);
lambda   = 10;

x        = sdpvar(m,1); %Yalmip variable

mu       = 1;
f        = (y-X*x)'*(y-X*x)/2 + lambda*norm(x,1)+mu*x'*x; %objective function

Max_iter = 10;
xk       = zeros(m,1);
cost     = [];
xstar    = [];
ck       = 0.3;

cost(1)  = (y-X*xk)'*(y-X*xk)/2 + lambda*norm(xk,1)+mu*xk'*xk;
xstar{1} = xk;

for i = 1:Max_iter
    ft          = f + 1/(2*ck)*(x-xk)'*(x-xk);
    optimize([],ft);
    %y.xknext = value(x);
    cost(i+1)   = value(ft);
    xk          = value(x);
    xstar{i+1}  = xk;
end


semilogy(abs(cost-Out_True.Out.obj)/Out_True.Out.obj);

Out.obj   = cost;
Out.xstar = xstar;
%save([savepath,name{c},'_result'],'Out');
