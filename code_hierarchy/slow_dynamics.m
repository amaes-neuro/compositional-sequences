%This script can be used to test the parameters and dynamics for a
%recurrent network, there is no read-out

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation time parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = 1100;                      %Simulation in milli-seconds
dt = 0.1;                     %0.1 millisecond time step

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WEIGHT MATRIX 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
createERNN_slow;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for both E and I Neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Vreset = -60;       %Reset for both exc and inh neurons
C = 300;            %capacitance
tau_abs = 5;        %refractory period

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for the E-Neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

Vthres = 20;        %Spiking threshold for exc neurons
tau_E = 20;         %Membrane Time Constant
V_E = -70;          %resting potential 
DET = 2;            %slope of exponential
E_E = 0;            %reversal potential
V_T = -52;          %threshold potential (the spiking threshold for inh neurons)
A_T = 10;           %post spike threshold potential increase
tau_T = 30;         %adaptive threshold time scale
EVthreshold_slow = V_T*ones(1,EneuronNum_slow); %neuronal threshold vector for all exc neurons

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for the I-Neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tau_I = 20;         %Membrane Time Constant
V_I = -62;          %resting potential
E_I = -75;          %reversal potential

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for the short term plasticity/adaptation (E only)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tau_w = 100;                            %adaptation time constant
a = 4;                                  %adaptation slope
b = 0.805;                               %adaptation amplitude
w = a*(Vreset-V_E)*ones(1,EneuronNum_slow);  %adaptation vector for all excitatory neurons

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for the synapses and neuronal conductances
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

tauedecay = 6;      %decay time for e-synapses
tauerise = 1;       %rise time of e-synapses
tauidecay = 2;      %decay time for i-synapses
tauirise = 0.5;     %rise time of i-synapses

xedecay = zeros(1,neuronNum_slow);
xerise = zeros(1,neuronNum_slow);
xidecay = zeros(1,neuronNum_slow);
xirise = zeros(1,neuronNum_slow);

gE = zeros(1,neuronNum_slow);
gI = zeros(1,neuronNum_slow);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% External input to both E and I neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
rex = 4.50;        %external rate to E-neurons        
rix = 2.250;        %external rate to I-neurons
Jeex = 1.6;         %weights for ee external input
Jiex = 1.52;        %weights for ie external input

nextx_slow = zeros(1,neuronNum_slow);      %vector containing the next external input spike times
nextx_slow(1,1:EneuronNum_slow) =  exprnd(1,1,EneuronNum_slow)/rex;         
nextx_slow(1,1+EneuronNum_slow:end) = exprnd(1,1,IneuronNum_slow)/rix;
rx_slow = zeros(1,neuronNum_slow);
rx_slow(1,1:EneuronNum_slow) = rex;
rx_slow(1,EneuronNum_slow+1:end) = rix;
forwardInputsEPrev_slow = zeros(1,neuronNum_slow);
forwardInputsIPrev_slow = zeros(1,neuronNum_slow);
Jex_slow = zeros(1,neuronNum_slow);
Jex_slow(1:EneuronNum_slow) = Jeex;
Jex_slow(EneuronNum_slow+1:neuronNum_slow) = Jiex;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulating Network with EIF neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

rast_slow = zeros(neuronNum_slow,T/dt + 1);          %Matrix storing spike times for raster plots
rast_binary_slow = zeros(neuronNum_slow,T/dt + 1);   %same but with binary numbers
lastAP_slow  = -50 * ones(1,neuronNum_slow);                          %last action potential for refractor period calculation (just big number negative put)

memVol_slow = Vreset+(V_T-Vreset)*rand(1,neuronNum_slow);
v_slow = zeros(1,neuronNum_slow);

for i =2:T/dt

    forwardInputsE_slow = zeros(1,neuronNum_slow);
    forwardInputsI_slow = zeros(1,neuronNum_slow);
    
    %start
    if i<=20/dt
        rx_slow(1,1:100) = rex+5;
    else
        rx_slow(1,1:100) = rex;
    end       

    
    %external input
    while true
        idx = i*dt > nextx_slow;
        if sum(idx) == 0
            break
        end
        idx = find(idx);
        nextx_slow(idx) = nextx_slow(idx) + exprnd(1,1,size(idx,2))./rx_slow(idx);
        forwardInputsEPrev_slow(idx) = forwardInputsEPrev_slow(idx) + Jex_slow(idx);
    end

    %connectivity
    xerise = xerise -dt*xerise/tauerise + forwardInputsEPrev_slow;
    xedecay = xedecay -dt*xedecay/tauedecay + forwardInputsEPrev_slow;
    xirise = xirise -dt*xirise/tauirise + forwardInputsIPrev_slow;
    xidecay = xidecay -dt*xidecay/tauidecay + forwardInputsIPrev_slow;
    
    gE = (xedecay - xerise)/(tauedecay - tauerise);
    gI = (xidecay - xirise)/(tauidecay - tauirise);

    %adaptation and plasticity excitatory
    w = w + (dt/tau_w)*(a*(memVol_slow(1:EneuronNum_slow) - V_E) - w);     %adaptation current
    EVthreshold_slow = EVthreshold_slow + (dt/tau_T)*(V_T - EVthreshold_slow);  %adapting threshold

    %cell dynamics excitatory
    v_slow(1:EneuronNum_slow) = memVol_slow(1:EneuronNum) + (dt/tau_E)*(-memVol_slow(1:EneuronNum_slow) + V_E + DET*exp((memVol_slow(1:EneuronNum_slow)-EVthreshold_slow)/DET)) ...
        + (dt/C)*(gE(1:EneuronNum_slow).*(E_E - memVol_slow(1:EneuronNum_slow)) + gI(1:EneuronNum_slow).*(E_I - memVol(1:EneuronNum_slow)) - w);

    %cell dynamics inhibitory
    v_slow(EneuronNum_slow+1:neuronNum_slow) = memVol_slow(EneuronNum_slow+1:neuronNum_slow) + (dt/tau_I)*(-memVol_slow(EneuronNum_slow+1:neuronNum_slow) + V_I) + ...
        (dt/C)*(gE(EneuronNum_slow+1:neuronNum_slow).*(E_E - memVol_slow(EneuronNum_slow+1:neuronNum_slow)) + gI(EneuronNum_slow+1:neuronNum_slow).*(E_I - memVol_slow(EneuronNum_slow+1:neuronNum_slow)));

    %refractory period
    v_slow(lastAP_slow>=i-tau_abs/dt) = Vreset;

    %spike recorded excitatory
    idx = v(1:EneuronNum_slow)>Vthres;
    v_slow(idx) = Vreset;
    lastAP_slow(idx) = i;
    rast_slow(idx,i) = find(idx);
    rast_binary_slow(idx,i) = 1;
    forwardInputsE_slow = forwardInputsE_slow + [sum(weightsEE_slow(:,idx),2);sum(weightsIE_slow(:,idx),2)]'; %recurrent
    EVthreshold_slow(idx) = EVthreshold_slow(idx) + A_T;
    w(idx) = w(idx) + b;
    
    %spike recorded inhibitory
    idx = find(v_slow(EneuronNum_slow+1:neuronNum_slow)>V_T)+EneuronNum_slow;
    v_slow(idx) = Vreset;
    lastAP_slow(idx) = i;
    rast_slow(idx,i) = idx;
    rast_binary_slow(idx,i) = 1;
    forwardInputsI_slow = forwardInputsI_slow + [sum(weightsEI_slow(:,idx-EneuronNum_slow),2);sum(weightsII_slow(:,idx-EneuronNum_slow),2)]'; %recurrent

  
    memVol_slow = v_slow;
    forwardInputsEPrev_slow = forwardInputsE_slow;
    forwardInputsIPrev_slow = forwardInputsI_slow;
    
end

