%This script can be used to test the parameters and dynamics for a
%recurrent network, there is no read-out

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation time parameters
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

T = 1200;                     %Simulation in milli-seconds
dt = 0.1;                     %0.1 millisecond time step

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% WEIGHT MATRIX 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
       
createIRNN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Parameters for I Neurons
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dynamics_parameters;
external_input;
plasticity_parameters;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulating Network 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%I-RNN init
rast_IRNN = zeros(IRNN_size,T/dt+1);
lastAP_IRNN = -50*ones(1,IRNN_size);
memVol_IRNN = Vreset+(V_T-Vreset)*rand(1,IRNN_size);
v_IRNN = zeros(1,IRNN_size);

for i =2:T/dt

    
    if i<=30/dt
        rirnnx(1,1:100) = rIRNNex+3;
    else
        rirnnx(1,1:100) = rIRNNex;
    end       

  
    %I-RNN
    forwardInputsIRNNE = zeros(1,IRNN_size);
    forwardInputsIRNNI = zeros(1,IRNN_size);

    
    %%%%%%%%%%%%%%%%%
    %%%   I-RNN   %%%
    %%%%%%%%%%%%%%%%%

    %external input
    while true
        idx = i*dt > nextIRNNx;
        if sum(idx) == 0
            break
        end
        idx = find(idx);
        nextIRNNx(idx) = nextIRNNx(idx) + exprnd(1,1,size(idx,2))./rirnnx(idx);
        forwardInputsIRNNEPrev(idx) = forwardInputsIRNNEPrev(idx) + Jiex;
    end
  
    %connectivity
    xIRNNerise = xIRNNerise -dt*xIRNNerise/tauerise + forwardInputsIRNNEPrev;
    xIRNNedecay = xIRNNedecay -dt*xIRNNedecay/tauedecay + forwardInputsIRNNEPrev;
    xIRNNirise = xIRNNirise -dt*xIRNNirise/tauirise + forwardInputsIRNNIPrev;
    xIRNNidecay = xIRNNidecay -dt*xIRNNidecay/tauidecay + forwardInputsIRNNIPrev;
        
    gE = (xIRNNedecay - xIRNNerise)/(tauedecay - tauerise);
    gI = (xIRNNidecay - xIRNNirise)/(tauidecay - tauirise);
               
    x_IRNN = x_IRNN + dt*(1-x_IRNN)/tau_x_IRNN;        

    %inhibitory dynamics
    v_IRNN = memVol_IRNN + (dt/tau_I)*(-memVol_IRNN + V_I) + ...
        (dt/C)*(gE.*(E_E - memVol_IRNN) + gI.*(E_I - memVol_IRNN));

    %refractory period
    v_IRNN(lastAP_IRNN>=i-tau_abs/dt) = Vreset;

    %spike recorded inhibitory
    idx = find(v_IRNN>V_T);
    v_IRNN(idx) = Vreset;
    lastAP_IRNN(idx) = i;
    rast_IRNN(idx,i) = idx;
    rast_binary_IRNN(idx,i) = 1;
    x_IRNN(idx) = x_IRNN(idx) - dt*u_IRNN*x_IRNN(idx);
    forwardInputsIRNNI = forwardInputsIRNNI + sum(x_IRNN(idx).*IRNN_weights(:,idx),2)'; %recurrent 


    
    %I-RNN
    memVol_IRNN = v_IRNN;
    forwardInputsIRNNEPrev = forwardInputsIRNNE;
    forwardInputsIRNNIPrev = forwardInputsIRNNI;

end
