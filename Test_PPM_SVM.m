clc;clear;close all;
%PPM for SVM
%Package requirement: Yalmip and Mosek

datapath = 'example/';
savepath = 'results/PPM/';
name     = {'a1a','australian_scale','fourclass_scale'};
c        = 1;
[label_vector, instance_matrix] = libsvmread([datapath,name{c},'.txt']);

Out_True = load(['results/GroundTrue/SVM/',name{c},'.mat']);

p        = 1;%regularization parameter
d        = width(instance_matrix);
n        = height(instance_matrix);

x        = sdpvar(d,1); %variable
b        = ones(n,1)-label_vector.*(instance_matrix*x);
z        = [zeros(n,1),b];
f        = sum(max(z,[],2))/n+p/2*x.'*x;

Max_iter = 10;
xk       = zeros(d,1);
cost     = [];
xstar    = [];
ck       = 1;

b0       = ones(n,1)-label_vector.*(instance_matrix*xk);
z0       = [zeros(n,1),b0];
cost(1)  = sum(max(z0,[],2))/n+p/2*xk.'*xk;
xstar{1} = xk ;

for i = 1:Max_iter
    ft           = f + 1/(2*ck)*(x-xk)'*(x-xk);
    optimize([],ft);
    cost(i+1)    = value(ft);
    xk           = value(x);
    xstar{i+1}   = xk;
end


semilogy(abs(cost-Out_True.Out.obj)/Out_True.Out.obj);

Out.obj   = cost;
Out.xstar = xstar;
%save([savepath,name,'_result'],'Out');
