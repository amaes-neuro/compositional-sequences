%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%% Simulating Network 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%E-RNN init
rast = zeros(neuronNum,T/dt + 1);          %Matrix storing spike times for raster plots
rast_binary = zeros(neuronNum,T/dt + 1);   %same but with binary numbers
lastAP  = -50 * ones(1,neuronNum);         %last action potential for refractor period calculation (just big number negative put)
memVol = Vreset+(V_T-Vreset)*rand(1,neuronNum);
v = zeros(1,neuronNum);

%E-RNN slow init
rast_slow = zeros(neuronNum_slow,T/dt + 1);          %Matrix storing spike times for raster plots
rast_binary_slow = zeros(neuronNum_slow,T/dt + 1);   %same but with binary numbers
lastAP_slow  = -50 * ones(1,neuronNum_slow);         %last action potential for refractor period calculation (just big number negative put)
memVol_slow = Vreset+(V_T-Vreset)*rand(1,neuronNum_slow);
v_slow = zeros(1,neuronNum_slow);

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

perturb = false;
for i =2:T/dt

    
%     %capacity simulation
%     if i<1000/dt
%         seq_nb = 1;
%     else
%         seq_nb = 0;
%     end
%     
%     if i>1000/dt && i<1020/dt
%         rx_slow(1,1:100) = rex+10;
%         rx(1,1:100) = rex + 10;
%     else
%         rx_slow(1,1:100) = rex;
%         rx(1,1:100) = rex;
%     end
      
    %start and/or perturb
    if i<=20/dt
        rx_slow(1,1:100) = rex + 5;
        rx(1,1:100) = rex + 5;
    elseif perturb && i>=200/dt && i<300/dt %i>=300/dt && i<400/dt
        %rx_slow(1,1:EneuronNum_slow) = rex-4; 
        rsyllx(1,1:100) = 5;
    else
        rsyllx(1,1:100) = 2;
        rx_slow(1,1:EneuronNum_slow) = rex;
        rx(1,1:1900) = rex;
        rx(1,1901:2000) = rex + 1;
    end       

    
    %E-RNN
    forwardInputsE = zeros(1,neuronNum);
    forwardInputsI = zeros(1,neuronNum);
    %E-RNN slow
    forwardInputsE_slow = zeros(1,neuronNum_slow);
    forwardInputsI_slow = zeros(1,neuronNum_slow);
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

    
    
    %%%%%%%%%%%%%%%%%%%%%
    %%%   E-RNN slow  %%%
    %%%%%%%%%%%%%%%%%%%%%

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
    xerise_slow = xerise_slow -dt*xerise_slow/tauerise + forwardInputsEPrev_slow;
    xedecay_slow = xedecay_slow -dt*xedecay_slow/tauedecay + forwardInputsEPrev_slow;
    xirise_slow = xirise_slow -dt*xirise_slow/tauirise + forwardInputsIPrev_slow;
    xidecay_slow = xidecay_slow -dt*xidecay_slow/tauidecay + forwardInputsIPrev_slow;
    
    gE_slow = (xedecay_slow - xerise_slow)/(tauedecay - tauerise);
    gI_slow = (xidecay_slow - xirise_slow)/(tauidecay - tauirise);

    %adaptation and plasticity excitatory
    w_slow = w_slow + (dt/tau_w)*(a*(memVol_slow(1:EneuronNum_slow) - V_E) - w_slow);     %adaptation current
    EVthreshold_slow = EVthreshold_slow + (dt/tau_T)*(V_T - EVthreshold_slow);  %adapting threshold

    %cell dynamics excitatory
    v_slow(1:EneuronNum_slow) = memVol_slow(1:EneuronNum_slow) + (dt/tau_E)*(-memVol_slow(1:EneuronNum_slow) + V_E + DET*exp((memVol_slow(1:EneuronNum_slow)-EVthreshold_slow)/DET)) ...
        + (dt/C)*(gE_slow(1:EneuronNum_slow).*(E_E - memVol_slow(1:EneuronNum_slow)) + gI_slow(1:EneuronNum_slow).*(E_I - memVol_slow(1:EneuronNum_slow)) - w_slow);

    %cell dynamics inhibitory
    v_slow(EneuronNum_slow+1:neuronNum_slow) = memVol_slow(EneuronNum_slow+1:neuronNum_slow) + (dt/tau_I)*(-memVol_slow(EneuronNum_slow+1:neuronNum_slow) + V_I) + ...
        (dt/C)*(gE_slow(EneuronNum_slow+1:neuronNum_slow).*(E_E - memVol_slow(EneuronNum_slow+1:neuronNum_slow)) + gI_slow(EneuronNum_slow+1:neuronNum_slow).*(E_I - memVol_slow(EneuronNum_slow+1:neuronNum_slow)));

    %refractory period
    v_slow(lastAP_slow>=i-tau_abs/dt) = Vreset;

    %spike recorded excitatory
    idx = v_slow(1:EneuronNum_slow)>Vthres;
    v_slow(idx) = Vreset;
    lastAP_slow(idx) = i;
    rast_slow(idx,i) = find(idx);
    rast_binary_slow(idx,i) = 1;
    forwardInputsE_slow = forwardInputsE_slow + [sum(weightsEE_slow(:,idx),2);sum(weightsIE_slow(:,idx),2)]'; %recurrent
    forwardInputsSyllE = forwardInputsSyllE + sum(wSyllE(:,idx),2)';
    EVthreshold_slow(idx) = EVthreshold_slow(idx) + A_T;
    w_slow(idx) = w_slow(idx) + b;
    
    %spike recorded inhibitory
    idx = find(v_slow(EneuronNum_slow+1:neuronNum_slow)>V_T)+EneuronNum_slow;
    v_slow(idx) = Vreset;
    lastAP_slow(idx) = i;
    rast_slow(idx,i) = idx;
    rast_binary_slow(idx,i) = 1;
    forwardInputsI_slow = forwardInputsI_slow + [sum(weightsEI_slow(:,idx-EneuronNum_slow),2);sum(weightsII_slow(:,idx-EneuronNum_slow),2)]'; %recurrent
 

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

    %external attentional inhibitory input, comment code when learning
    %a single sequence
%    if seq_nb && j<=300
%        while true 
%            idx = i*dt > nextattenx;
%            if sum(idx) == 0
%                break
%            end
%            idx = find(idx);
%            nextattenx(idx) = nextattenx(idx) + exprnd(1,1,size(idx,2))./rattenx(idx);
%            forwardInputsSyllIPrev(idx) = forwardInputsSyllIPrev(idx) + Jiex;
%        end
%    elseif ~seq_nb && j>300
%        while true 
%            idx = i*dt > nextattenx;
%            if sum(idx) == 0
%                break
%            end
%            idx = find(idx);
%            nextattenx(idx) = nextattenx(idx) + exprnd(1,1,size(idx,2))./rattenx(idx);
%            forwardInputsSyllIPrev(idx) = forwardInputsSyllIPrev(idx) + Jiex;
%        end
%    end

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
    %E-RNN slow
    memVol_slow = v_slow;
    forwardInputsEPrev_slow = forwardInputsE_slow;
    forwardInputsIPrev_slow = forwardInputsI_slow;
    %Syllables
    memVol_syll = v_syll;
    forwardInputsSyllEPrev = forwardInputsSyllE;
    forwardInputsSyllIPrev = forwardInputsSyllI;
    %Read-out
    memVol_R = v_R;
    forwardInputsREPrev = forwardInputsRE;
    forwardInputsRIPrev = forwardInputsRI;    

end
