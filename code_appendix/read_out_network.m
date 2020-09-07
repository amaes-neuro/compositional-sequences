%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                        %%%
%%%     %%%%%%%%%%%%%                %%%%%%%%%%%%%         %%%
%%%     %%% E-RNN %%%                %%% I-RNN %%%         %%%
%%%     %%%%%%%%%%%%%                %%%%%%%%%%%%%         %%%
%%%           |                          |                 %%%
%%%           |                          | wSyllIRNN       %%%
%%%           |                          V                 %%%
%%%           | wRE     wSyllR     %%%%%%%%%%%%%%%%%       %%%
%%%           |       |----------> %%% Syllables %%%       %%%
%%%           |       |            %%%%%%%%%%%%%%%%%       %%%
%%%           |       |                  |                 %%%
%%%           V       |                  |                 %%%
%%%     %%%%%%%%%%%%%%%%                 | wRSyll          %%%
%%%     %%% Read-out %%% <---------------|                 %%% 
%%%     %%%%%%%%%%%%%%%%                                   %%%
%%%           ^                                            %%%
%%%           |                                            %%%
%%%           |                                            %%%        
%%%       Supervisor                                       %%%
%%%                                                        %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


wRE = zeros(REneuronNum,EneuronNum);
wSyllIRNN = zeros(SyllIneuronNum,IRNN_size);
wRSyll = zeros(RneuronNum,SyllIneuronNum);
wSyllR = zeros(SyllIneuronNum,REneuronNum);

wERNNSyll = zeros(neuronNum,SyllIneuronNum);
wSyllERNN = zeros(SyllIneuronNum,neuronNum);