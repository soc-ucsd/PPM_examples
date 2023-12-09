clc;clear;close all;
%Get the true solution of SVM problem

datapath = 'example/';
savepath = 'results/GroundTrue/';
List     = {'a1a','australian_scale','fourclass_scale'};
c        = 3;
name     = List{c};
[label_vector, instance_matrix] = libsvmread([datapath,name,'.txt']);

p = 1;
d = width(instance_matrix);
n = height(instance_matrix);

x = sdpvar(d,1); %variable
b = ones(n,1)-label_vector.*(instance_matrix*x);
z = [zeros(n,1),b];
f = sum(max(z,[],2))/n+p/2*x.'*x;
optimize([],f);

Out.obj   = value(f);
Out.xstar = value(x);
%save([savepath,name],'Out');