%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%                                                             %%%
%%%     %%%%%%%%%%%%%                %%%%%%%%%%%%%%%%%%         %%%
%%%     %%% E-RNN %%%                %%% E-RNN slow %%%         %%%
%%%     %%%%%%%%%%%%%                %%%%%%%%%%%%%%%%%%         %%%
%%%           |                          |                      %%%
%%%           |                          | wSyllE               %%%
%%%           |                          V                      %%%
%%%           | wRE     wSyllR     %%%%%%%%%%%%%%%%%            %%%
%%%           |       |----------> %%% Syllables %%%            %%%
%%%           |       |            %%%%%%%%%%%%%%%%%            %%%
%%%           |       |                  |                       %%%
%%%           V       |                  |                      %%%
%%%     %%%%%%%%%%%%%%%%                 | wRSyll               %%%
%%%     %%% Read-out %%% <---------------|                      %%% 
%%%     %%%%%%%%%%%%%%%%                                        %%%
%%%           ^                                                 %%%
%%%           |                                                 %%%
%%%           |                                                 %%%        
%%%       Supervisor                                            %%%
%%%                                                             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


wRE = zeros(REneuronNum,EneuronNum);
wSyllE = zeros(SyllIneuronNum,EneuronNum_slow);
wRSyll = zeros(RneuronNum,SyllIneuronNum);
wSyllR = zeros(SyllIneuronNum,REneuronNum);

wERNNSyll = zeros(neuronNum,SyllIneuronNum);
wSyllERNN = zeros(SyllIneuronNum,neuronNum);