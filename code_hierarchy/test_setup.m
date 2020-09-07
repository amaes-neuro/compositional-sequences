%% E-RNN to Read-outs test weights

wRE(:,:) = 0.30; %init

wRE = load('wRE_learning.mat'); 
wRE = wRE.wRE;


%% E-RNN slow to Syllables test weights

wSyllE(:,:) = 0.10; %init

wSyllE = load('wSyllE_learning.mat'); 
wSyllE = wSyllE.wSyllE;


%% Syllables to Read-outs test weights

%first interneuron network
wRSyll(1:300,101:200) = 50;
wRSyll(601:675,101:200) = 50;
wRSyll(301:600,1:100) = 50;
wRSyll(676:750,1:100) = 50;
wRSyll(:,201:300) = 20; %silent syllable

%second interneuron network
% wRSyll(1:300,401:500) = 50;
% wRSyll(601:675,401:500) = 50;
% wRSyll(301:600,301:400) = 50;
% wRSyll(676:750,301:400) = 50;
% wRSyll(:,501:600) = 20; %silent syllable


%% Syllables to ERNN and back

%first interneuron network
wERNNSyll(1:1900,201:300) = 20;
wSyllERNN(201:300,1801:1900) = 1.5;
wSyllERNN(201:300,1901:2000) = 0.40;

%second interneuron network
% wERNNSyll(1:1900,501:600) = 20;
% wSyllERNN(501:600,1801:1900) = 1.5;
% wSyllERNN(501:600,1901:2000) = 0.40;

%% Read-outs to syllables 

%first interneuron network
wSyllR(1:100,1:300) = 0.40;
wSyllR(101:200,301:600) = 0.40;

%second interneuron network
% wSyllR(301:400,1:300) = 0.40;
% wSyllR(401:500,301:600) = 0.40;
