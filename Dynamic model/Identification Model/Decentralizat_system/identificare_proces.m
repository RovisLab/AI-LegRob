clear all
clc
% optimizare

data = load('matdate.mat');

in_fr_h = data.fr_h_com;
in_fr_t = data.fr_t_com;
in_fr_c = data.fr_c_com;

in_fr = [in_fr_h in_fr_t in_fr_c]'

out_fr_h = data.fr_h_p;
out_fr_t = data.fr_t_p;
out_fr_c = data.fr_c_p;

out_fr_p = [out_fr_h out_fr_t out_fr_c]'

n = length(out_fr_h);

Ts=0.01;

liml = 0;
limlk = 0;

limuk = 50;
limu = 50;

% limukc = 55;
% limuc = 5;

% LB = [limlk limlk limlk limlk limlk limlk limlk limlk limlk liml liml liml liml liml liml liml liml liml liml liml liml liml liml liml liml liml liml  liml liml liml liml liml liml liml liml liml]';
% UB = [limuk limuk limuk limuk limuk limuk limuk limuk limuk limu limu limu limu limu limu limu limu limu limu limu limu limu limu limu limu limu limu  limu limu limu limu limu limu limu limu limu]';
LB = [limlk limlk limlk liml liml liml liml liml liml]';
UB = [limuk limuk limuk limu limu limu limu limu limu]';

parametrii=length(LB);

%opts = optimoptions('ga','PlotFcn',@gaplot1drange);
opts = optimoptions(@ga,'PlotFcn',{@gaplotbestf,@gaplotstopping},'PopInitRange',[LB';UB'],'UseParallel', true);
%opts = gaoptimset('PopulationSize', popsize, 'Generations', gensize, 'Display', 'off', 'TolFun', 1e-6,'UseParallel', true);


[xyz, fval,EXITFLAG] = ga(@(xyz) functie_proces_tf(xyz,in_fr,out_fr_p,n),parametrii,[],[],[],[],LB,UB,[],opts) 