clc; clear; close all
%Get the true solution of ElasticNet problem

datapath = 'example/';
savepath = 'results/GroundTrue/ElasticNet/';
name     = 'n30m60s15';
load([datapath,name,'.mat']);
lambda   = 10;
m        = width(X);
w        = sdpvar(m,1);
mu       = 1;
f        = (y-X*w)'*(y-X*w)/2 + lambda*norm(w,1) + mu*w'*w;
ops      = sdpsettings('solver','mosek','verbose',1,'debug',1);
out      = optimize([],f,ops);
Out.obj  = value(f);
save([savepath,name],'Out');