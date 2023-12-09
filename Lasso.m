clc; clear; close all
%Get the true solution of Lasso problem
datapath = 'example/';
savepath = 'results/GroundTrue/';
List     = {'n10m40s5','n20m50s10','n30m60s15'};
c        = 3;
name     = List{c};
load([datapath,name,'.mat']);
lambda   = 10;
m        = width(X);
w        = sdpvar(m,1);
f        = (y-X*w)'*(y-X*w)/2 + lambda*norm(w,1);
ops      = sdpsettings('solver','mosek','verbose',1,'debug',1);
out      = optimize([],f,ops);
Out.obj  = value(f);
save([savepath,name],'Out');