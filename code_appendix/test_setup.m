%% E-RNN to Read-outs test weights

wRE(:,:) = 0.30;

wRE = load('wRE_learning.mat'); 
wRE = wRE.wRE;

%% I-RNN to Syllables test weights

wSyllIRNN(:,:) = 0.1; %test

wSyllIRNN = load('wSyllIRNN_learning.mat'); 
wSyllIRNN = wSyllIRNN.wSyllIRNN;


%% Syllables to Read-outs test weights

%first interneuron network
wRSyll(1:300,101:200) = 50;
wRSyll(601:675,101:200) = 50;
wRSyll(301:600,1:100) = 50;
wRSyll(676:750,1:100) = 50;
wRSyll(:,201:300) = 15; %silent syllable

%second interneuron network
% wRSyll(1:300,401:500) = 50;
% wRSyll(601:675,401:500) = 50;
% wRSyll(301:600,301:400) = 50;
% wRSyll(676:750,301:400) = 50;
% wRSyll(:,501:600) = 15; %silent syllable


%% Syllables to ERNN and back

%first interneuron network
wERNNSyll(1:1900,201:300) = 25;
wSyllERNN(201:300,1801:1900) = 1.5;
wSyllERNN(201:300,1901:2000) = 0.15;

%second interneuron network
% wERNNSyll(1:1900,501:600) = 25;
% wSyllERNN(501:600,1801:1900) = 1.5;
% wSyllERNN(501:600,1901:2000) = 0.15;

%% Read-outs to syllables 

%first interneuron network
wSyllR(1:100,1:300) = 0.1;
wSyllR(101:200,301:600) = 0.1;

%second interneuron network
% wSyllR(301:400,1:300) = 0.1;
% wSyllR(401:500,301:600) = 0.1;
