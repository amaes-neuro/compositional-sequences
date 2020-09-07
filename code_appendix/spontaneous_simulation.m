%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulating Network 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%E-RNN init
rast = zeros(neuronNum,T/dt + 1);          %Matrix storing spike times for raster plots
rast_binary = zeros(neuronNum,T/dt + 1);   %same but with binary numbers
lastAP  = -50 * ones(1,neuronNum);         %last action potential for refractor period calculation (just big number negative put)
memVol = Vreset+(V_T-Vreset)*rand(1,neuronNum);
v = zeros(1,neuronNum);

%I-RNN init
rast_IRNN = zeros(IRNN_size,T/dt+1);
lastAP_IRNN = -50*ones(1,IRNN_size);
memVol_IRNN = Vreset+(V_T-Vreset)*rand(1,IRNN_size);
v_IRNN = zeros(1,IRNN_size);

%Syllables init
rast_syll = zeros(SyllIneuronNum, T/dt+1);
rast_binary_syll = zeros(SyllIneuronNum, T/dt+1);
lastAP_syll = -50*ones(1,SyllIneuronNum);
memVol_syll = Vreset+(V_T-Vreset)*rand(1,SyllIneuronNum);
v_syll = zeros(1,SyllIneuronNum);

%Read-out init
rast_R = zeros(RneuronNum, T/dt+1);
rast_binary_R = zeros(RneuronNum, T/dt+1);
lastAP_R = -50*ones(1,RneuronNum);
memVol_R = Vreset+(V_T-Vreset)*rand(1,RneuronNum);
v_R = zeros(1,RneuronNum);


for i =2:T/dt

    if mod(i,10000) == 0
        i/10000
    end
    
    if i<=30/dt
        rirnnx(1,1:100) = rIRNNex+3;
        rx(1,1:100) = rex + 5;
    else
        rirnnx(1,1:100) = rIRNNex;
        rx(1,1:100) = rex;
    end       

    
    %E-RNN
    forwardInputsE = zeros(1,neuronNum);
    forwardInputsI = zeros(1,neuronNum);
    %I-RNN
    forwardInputsIRNNE = zeros(1,IRNN_size);
    forwardInputsIRNNI = zeros(1,IRNN_size);
    %Syllables
    forwardInputsSyllE = zeros(1,SyllIneuronNum);
    forwardInputsSyllI = zeros(1,SyllIneuronNum);
    %Read-out
    forwardInputsRE = zeros(1,RneuronNum);
    forwardInputsRI = zeros(1,RneuronNum);
    
    
    %%%%%%%%%%%%%%%%%
    %%%   E-RNN   %%%
    %%%%%%%%%%%%%%%%%

    %external input
    while true
        idx = i*dt > nextx;
        if sum(idx) == 0
            break
        end
        idx = find(idx);
        nextx(idx) = nextx(idx) + exprnd(1,1,size(idx,2))./rx(idx);
        forwardInputsEPrev(idx) = forwardInputsEPrev(idx) + Jex(idx);
    end    

    %connectivity
    xerise = xerise -dt*xerise/tauerise + forwardInputsEPrev;
    xedecay = xedecay -dt*xedecay/tauedecay + forwardInputsEPrev;
    xirise = xirise -dt*xirise/tauirise + forwardInputsIPrev;
    xidecay = xidecay -dt*xidecay/tauidecay + forwardInputsIPrev;
    
    gE = (xedecay - xerise)/(tauedecay - tauerise);
    gI = (xidecay - xirise)/(tauidecay - tauirise);	


    %adaptation excitatory
    w = w + (dt/tau_w)*(a*(memVol(1:EneuronNum) - V_E) - w);           %adaptation current
    EVthreshold = EVthreshold + (dt/tau_T)*(V_T - EVthreshold);  %adapting threshold

    %cell dynamics excitatory
    v(1:EneuronNum) = memVol(1:EneuronNum) + (dt/tau_E)*(-memVol(1:EneuronNum) + V_E + DET*exp((memVol(1:EneuronNum)-EVthreshold)/DET)) ...
        + (dt/C)*(gE(1:EneuronNum).*(E_E - memVol(1:EneuronNum)) + gI(1:EneuronNum).*(E_I - memVol(1:EneuronNum)) - w);

    %cell dynamics inhibitory
    v(EneuronNum+1:neuronNum) = memVol(EneuronNum+1:neuronNum) + (dt/tau_I)*(-memVol(EneuronNum+1:neuronNum) + V_I) + ...
        (dt/C)*(gE(EneuronNum+1:neuronNum).*(E_E - memVol(EneuronNum+1:neuronNum)) + gI(EneuronNum+1:neuronNum).*(E_I - memVol(EneuronNum+1:neuronNum)));

    %refractory period
    v(lastAP>=i-tau_abs/dt) = Vreset;

    %spike recorded excitatory
    idx = v(1:EneuronNum)>Vthres;
    v(idx) = Vreset;
    lastAP(idx) = i;
    rast(idx,i) = find(idx);
    rast_binary(idx,i) = 1;
    forwardInputsE = forwardInputsE + [sum(weightsEE(:,idx),2);sum(weightsIE(:,idx),2)]'; %recurrent
    forwardInputsRE(1:REneuronNum) = forwardInputsRE(1:REneuronNum) + sum(wRE(:,idx),2)'; %to read-out
    forwardInputsSyllE = forwardInputsSyllE + sum(wSyllERNN(:,idx),2)'; %to syllables
    EVthreshold(idx) = EVthreshold(idx) + A_T;
    w(idx) = w(idx) + b;
    
    %spike recorded inhibitory
    idx = find(v(EneuronNum+1:neuronNum)>V_T)+EneuronNum;
    v(idx) = Vreset;
    lastAP(idx) = i;
    rast(idx,i) = idx;
    rast_binary(idx,i) = 1;
    forwardInputsI = forwardInputsI + [sum(weightsEI(:,idx-EneuronNum),2);sum(weightsII(:,idx-EneuronNum),2)]';


    
    
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
        
    gE_IRNN = (xIRNNedecay - xIRNNerise)/(tauedecay - tauerise);
    gI_IRNN = (xIRNNidecay - xIRNNirise)/(tauidecay - tauirise);

    %short-term depression
    x_IRNN = x_IRNN + dt*(1-x_IRNN)/tau_x_IRNN;

    %inhibitory dynamics
    v_IRNN = memVol_IRNN + (dt/tau_I)*(-memVol_IRNN + V_I) + ...
        (dt/C)*(gE_IRNN.*(E_E - memVol_IRNN) + gI_IRNN.*(E_I - memVol_IRNN));

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
    forwardInputsSyllI = forwardInputsSyllI + sum(wSyllIRNN(:,idx),2)'; %to syllables



    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   SYLLABLE NETWORK    %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %external input
    while true
        idx = i*dt > nextsyllx;
        if sum(idx) == 0
            break
        end
        idx = find(idx);
        nextsyllx(idx) = nextsyllx(idx) + exprnd(1,1,size(idx,2))./rsyllx(idx);
        forwardInputsSyllEPrev(idx) = forwardInputsSyllEPrev(idx) + Jiex;
    end  

    %connectivity
    xSyllerise = xSyllerise -dt*xSyllerise/tauerise + forwardInputsSyllEPrev;
    xSylledecay = xSylledecay -dt*xSylledecay/tauedecay + forwardInputsSyllEPrev;
    xSyllirise = xSyllirise -dt*xSyllirise/tauirise + forwardInputsSyllIPrev;
    xSyllidecay = xSyllidecay -dt*xSyllidecay/tauidecay + forwardInputsSyllIPrev;
        
    gE_syll = (xSylledecay - xSyllerise)/(tauedecay - tauerise);
    gI_syll = (xSyllidecay - xSyllirise)/(tauidecay - tauirise);

    %inhibitory dynamics
    v_syll = memVol_syll + (dt/tau_I)*(-memVol_syll + V_I) + ...
        (dt/C)*(gE_syll.*(E_E - memVol_syll) + gI_syll.*(E_I - memVol_syll));

    %refractory period
    v_syll(lastAP_syll>=i-tau_abs/dt) = Vreset;

    %spike recorded inhibitory
    idx = find(v_syll>V_T);
    v_syll(idx) = Vreset;
    lastAP_syll(idx) = i;
    rast_syll(idx,i) = idx;
    rast_binary_syll(idx,i) = 1;
    forwardInputsSyllI = forwardInputsSyllI + sum(weightsSyllRNN(:,idx),2)'; %recurrent   
    forwardInputsRI = forwardInputsRI + sum(wRSyll(:,idx),2)'; %to read-out
    forwardInputsI = forwardInputsI + sum(wERNNSyll(:,idx),2)'; %to ERNN

    
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%
    %%%   READ-OUT NETWORK   %%%
    %%%%%%%%%%%%%%%%%%%%%%%%%%%%

    %external input
    while true
        idx = i*dt > nextRx;
        if sum(idx) == 0
            break
        end
        idx = find(idx);
        nextRx(idx) = nextRx(idx) + exprnd(1,1,size(idx,2))./rRx(idx);
        forwardInputsREPrev(idx) = forwardInputsREPrev(idx) + Jex_R(idx);
    end

    %connectivity
    xRerise = xRerise -dt*xRerise/tauerise + forwardInputsREPrev;
    xRedecay = xRedecay -dt*xRedecay/tauedecay + forwardInputsREPrev;
    xRirise = xRirise -dt*xRirise/tauirise + forwardInputsRIPrev;
    xRidecay = xRidecay -dt*xRidecay/tauidecay + forwardInputsRIPrev;
        
    gRE = (xRedecay - xRerise)/(tauedecay - tauerise);
    gRI = (xRidecay - xRirise)/(tauidecay - tauirise);

    wR = wR + (dt/tau_w)*(a*(memVol_R(1:REneuronNum) - V_E) - wR);  %adaptation current            
    EVthresholdR = EVthresholdR + (dt/tau_T)*(V_T - EVthresholdR);  %adapting threshold

    %cell dynamics excitatory
    v_R(1:REneuronNum) = memVol_R(1:REneuronNum) + (dt/tau_E)*(-memVol_R(1:REneuronNum) + V_E + DET*exp((memVol_R(1:REneuronNum)-EVthresholdR)/DET)) ...
        + (dt/C)*(gRE(1:REneuronNum).*(E_E - memVol_R(1:REneuronNum)) + gRI(1:REneuronNum).*(E_I - memVol_R(1:REneuronNum)) - wR);

    %cell dynamics inhibitory
    v_R(REneuronNum+1:RneuronNum) = memVol_R(REneuronNum+1:RneuronNum) + (dt/tau_I)*(-memVol_R(REneuronNum+1:RneuronNum) + V_I) + ...
        (dt/C)*(gRE(REneuronNum+1:RneuronNum).*(E_E - memVol_R(REneuronNum+1:RneuronNum)) + gRI(REneuronNum+1:RneuronNum).*(E_I - memVol_R(REneuronNum+1:RneuronNum)));

    %refractory period
    v_R(lastAP_R>=i-tau_abs/dt) = Vreset;

    %spike recorded excitatory
    idx = v_R(1:REneuronNum)>Vthres;
    v_R(idx) = Vreset;
    lastAP_R(idx) = i;
    rast_R(idx,i) = find(idx);
    rast_binary_R(idx,i) = 1;
    forwardInputsRE = forwardInputsRE + [sum(weightsREE(:,idx),2);sum(weightsRIE(:,idx),2)]'; %recurrent 
    forwardInputsSyllE = forwardInputsSyllE + sum(wSyllR(:,idx),2)'; %to syllables
    EVthresholdR(idx) = EVthresholdR(idx) + A_T;
    wR(idx) = wR(idx) + b;

    %spike recorded inhibitory
    idx = find(v_R(REneuronNum+1:RneuronNum)>V_T)+REneuronNum;
    v_R(idx) = Vreset;
    lastAP_R(idx) = i;
    rast_R(idx,i) = idx;
    forwardInputsRI = forwardInputsRI + [sum(weightsREI(:,idx-REneuronNum),2);sum(weightsRII(:,idx-REneuronNum),2)]'; %recurrent    


    
    
    %E-RNN
    memVol = v;
    forwardInputsEPrev = forwardInputsE;
    forwardInputsIPrev = forwardInputsI;
    %I-RNN
    memVol_IRNN = v_IRNN;
    forwardInputsIRNNEPrev = forwardInputsIRNNE;
    forwardInputsIRNNIPrev = forwardInputsIRNNI;
    %Syllables
    memVol_syll = v_syll;
    forwardInputsSyllEPrev = forwardInputsSyllE;
    forwardInputsSyllIPrev = forwardInputsSyllI;
    %Read-out
    memVol_R = v_R;
    forwardInputsREPrev = forwardInputsRE;
    forwardInputsRIPrev = forwardInputsRI;    

end
