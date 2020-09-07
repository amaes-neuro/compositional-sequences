function target = set_target(boolean,RneuronNum,T,dt)

target = -1*ones(RneuronNum,T/dt+1);

if boolean == 1 %AAB% % data saved in wRE_relearning.mat and wSyllE_relearning.mat
    
    %motif A 
    target(1:100,10/dt:40/dt) = 50;
    target(101:200,40/dt:80/dt) = 50;
    target(201:300,80/dt:120/dt) = 50;
    target(101:200,120/dt:160/dt) = 50;
    target(1:100,160/dt:200/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:40/dt)+690/dt) = 50;
    target(101:200,(40/dt:80/dt)+690/dt) = 50;
    target(201:300,(80/dt:120/dt)+690/dt) = 50;
    target(101:200,(120/dt:160/dt)+690/dt) = 50;
    target(1:100,(160/dt:200/dt)+690/dt) = 50;

    %motif B
    target(301:400,(1/dt:50/dt)+340/dt) = 50;
    target(401:500,(50/dt:120/dt)+340/dt) = 50;
    target(501:600,(120/dt:200/dt)+340/dt) = 50;
    
elseif boolean == 0 %BAAB% % data saved in wRE_capacity.mat and wSyllE_capacity.mat
    
    %motif B
    target(301:400,(1/dt:50/dt)) = 45;
    target(401:500,(50/dt:120/dt)) = 45;
    target(501:600,(120/dt:200/dt)) = 45;
    
    %motif A
    target(1:100,(1/dt:40/dt)+240/dt) = 45;
    target(101:200,(40/dt:80/dt)+240/dt) = 45;
    target(201:300,(80/dt:120/dt)+240/dt) = 45;
    target(101:200,(120/dt:160/dt)+240/dt) = 45;
    target(1:100,(160/dt:200/dt)+240/dt) = 45;
    
    %motif A
    target(1:100,(1/dt:40/dt)+490/dt) = 45;
    target(101:200,(40/dt:80/dt)+490/dt) = 45;
    target(201:300,(80/dt:120/dt)+490/dt) = 45;
    target(101:200,(120/dt:160/dt)+490/dt) = 45;
    target(1:100,(160/dt:200/dt)+490/dt) = 45;
    
    %motif B
    target(301:400,(1/dt:50/dt)+740/dt) = 45;
    target(401:500,(50/dt:120/dt)+740/dt) = 45;
    target(501:600,(120/dt:200/dt)+740/dt) = 45;
 
elseif boolean == 2 %time discretization test 20ms data saved in wRE_20ms.mat wSyllE_20ms.mat
   
    %motif A
    target(1:100,1/dt:20/dt) = 50;
    target(201:300,20/dt:40/dt) = 50;
    target(101:200,40/dt:60/dt) = 50;
    target(201:300,60/dt:80/dt) = 50;
    target(101:200,80/dt:100/dt) = 50;
    target(201:300,100/dt:120/dt) = 50;
    target(1:100,120/dt:140/dt) = 50;
    target(101:200,140/dt:160/dt) = 50;
    target(1:100,160/dt:180/dt) = 50;
    target(101:200,180/dt:200/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:20/dt)+340/dt) = 50;
    target(201:300,(20/dt:40/dt)+340/dt) = 50;
    target(101:200,(40/dt:60/dt)+340/dt) = 50;
    target(201:300,(60/dt:80/dt)+340/dt) = 50;
    target(101:200,(80/dt:100/dt)+340/dt) = 50;
    target(201:300,(100/dt:120/dt)+340/dt) = 50;
    target(1:100,(120/dt:140/dt)+340/dt) = 50;
    target(101:200,(140/dt:160/dt)+340/dt) = 50;
    target(1:100,(160/dt:180/dt)+340/dt) = 50;
    target(101:200,(180/dt:200/dt)+340/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:20/dt)+690/dt) = 50;
    target(201:300,(20/dt:40/dt)+690/dt) = 50;
    target(101:200,(40/dt:60/dt)+690/dt) = 50;
    target(201:300,(60/dt:80/dt)+690/dt) = 50;
    target(101:200,(80/dt:100/dt)+690/dt) = 50;
    target(201:300,(100/dt:20/dt)+690/dt) = 50;
    target(1:100,(120/dt:140/dt)+690/dt) = 50;
    target(101:200,(140/dt:160/dt)+690/dt) = 50;
    target(1:100,(160/dt:180/dt)+690/dt) = 50;
    target(101:200,(180/dt:200/dt)+690/dt) = 50;
    
elseif boolean == 3 %time discretization test 25ms data saved in wRE_25ms.mat wSyllE_25ms.mat
   
    %motif A
    target(1:100,1/dt:25/dt) = 50;
    target(201:300,25/dt:50/dt) = 50;
    target(101:200,50/dt:75/dt) = 50;
    target(201:300,75/dt:100/dt) = 50;
    target(101:200,100/dt:125/dt) = 50;
    target(201:300,125/dt:150/dt) = 50;
    target(1:100,150/dt:175/dt) = 50;
    target(101:200,175/dt:200/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:25/dt)+340/dt) = 50;
    target(201:300,(25/dt:50/dt)+340/dt) = 50;
    target(101:200,(50/dt:75/dt)+340/dt) = 50;
    target(201:300,(75/dt:100/dt)+340/dt) = 50;
    target(101:200,(100/dt:125/dt)+340/dt) = 50;
    target(201:300,(125/dt:150/dt)+340/dt) = 50;
    target(1:100,(150/dt:175/dt)+340/dt) = 50;
    target(101:200,(175/dt:200/dt)+340/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:25/dt)+690/dt) = 50;
    target(201:300,(25/dt:50/dt)+690/dt) = 50;
    target(101:200,(50/dt:75/dt)+690/dt) = 50;
    target(201:300,(75/dt:100/dt)+690/dt) = 50;
    target(101:200,(100/dt:125/dt)+690/dt) = 50;
    target(201:300,(125/dt:150/dt)+690/dt) = 50;
    target(1:100,(150/dt:175/dt)+690/dt) = 50;
    target(101:200,(175/dt:200/dt)+690/dt) = 50;

elseif boolean == 4 %time discretization test 40ms data saved in wRE_25ms.mat wSyllE_25ms.mat
   
    %motif A
    target(1:100,1/dt:40/dt) = 50;
    target(101:200,40/dt:80/dt) = 50;
    target(201:300,80/dt:120/dt) = 50;
    target(101:200,120/dt:160/dt) = 50;
    target(1:100,160/dt:200/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:40/dt)+340/dt) = 50;
    target(101:200,(40/dt:80/dt)+340/dt) = 50;
    target(201:300,(80/dt:120/dt)+340/dt) = 50;
    target(101:200,(120/dt:160/dt)+340/dt) = 50;
    target(1:100,(160/dt:200/dt)+340/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:40/dt)+690/dt) = 50;
    target(101:200,(40/dt:80/dt)+690/dt) = 50;
    target(201:300,(80/dt:120/dt)+690/dt) = 50;
    target(101:200,(120/dt:160/dt)+690/dt) = 50;
    target(1:100,(160/dt:200/dt)+690/dt) = 50;

end

end