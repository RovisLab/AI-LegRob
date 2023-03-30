

% DATE SIMULINK 


Kwalk = 1;
tWalk = 0.002;
trajtimp =0.1;
tc = 0.13; %timpul in care articulatiile ajung in punctul dorit Simulink

h = 0.30;
g = 9.80665;
stepHeight = 0.03;

% Contact Froces 
damp = 1e6;
stiff = 1e6;

% Path
pathT = [0 20 40 60 75 80]';
pathX = [0 1.5 6 6 0 0]';
pathY = [0 0 0 6 6 0]';%[0 0.01 0 1 1 0]';
curveT = linspace(0,pathT(end),100)';
curveX = interp1(pathT,pathX,curveT);
curveY = interp1(pathT,pathY,curveT);
curveZ = zeros(size(curveT));
interPts = [curveX curveY curveZ];
TsCtrl = 0.05;
