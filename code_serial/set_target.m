function target = set_target(boolean,RneuronNum,T,dt)

target = -1*ones(RneuronNum,T/dt+1);

if boolean==1  %AAB or ABA% saved in serial
    
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
    
elseif boolean == 2 %time discretization test saved in discr 20ms and 30ms mix stims
    
    %motif A
    target(1:100,1/dt:20/dt) = 50;
    target(201:300,20/dt:40/dt) = 50;
    target(101:200,40/dt:60/dt) = 50;
    target(201:300,60/dt:80/dt) = 50;
    target(101:200,80/dt:110/dt) = 50;
    target(201:300,110/dt:140/dt) = 50;
    target(1:100,140/dt:170/dt) = 50;
    target(101:200,170/dt:200/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:20/dt)+340/dt) = 50;
    target(201:300,(20/dt:40/dt)+340/dt) = 50;
    target(101:200,(40/dt:60/dt)+340/dt) = 50;
    target(201:300,(60/dt:80/dt)+340/dt) = 50;
    target(101:200,(80/dt:110/dt)+340/dt) = 50;
    target(201:300,(110/dt:140/dt)+340/dt) = 50;
    target(1:100,(140/dt:170/dt)+340/dt) = 50;
    target(101:200,(170/dt:200/dt)+340/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:20/dt)+690/dt) = 50;
    target(201:300,(20/dt:40/dt)+690/dt) = 50;
    target(101:200,(40/dt:60/dt)+690/dt) = 50;
    target(201:300,(60/dt:80/dt)+690/dt) = 50;
    target(101:200,(80/dt:110/dt)+690/dt) = 50;
    target(201:300,(110/dt:140/dt)+690/dt) = 50;
    target(1:100,(140/dt:170/dt)+690/dt) = 50;
    target(101:200,(170/dt:200/dt)+690/dt) = 50;
    
elseif boolean == 3 %time discretization test saved in discr2 25ms stims
   
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

elseif boolean == 4 %time discretization test saved in discr3 20ms stims
   
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
    target(201:300,(100/dt:120/dt)+690/dt) = 50;
    target(1:100,(120/dt:140/dt)+690/dt) = 50;
    target(101:200,(140/dt:160/dt)+690/dt) = 50;
    target(1:100,(160/dt:180/dt)+690/dt) = 50;
    target(101:200,(180/dt:200/dt)+690/dt) = 50;

elseif boolean == 5 %time discretization test saved in discr4 40ms stims

    target(1:100,(1/dt:40/dt)) = 50;
    target(101:200,(40/dt:80/dt)) = 50;
    target(201:300,(80/dt:120/dt)) = 50;
    target(101:200,(120/dt:160/dt)) = 50;
    target(1:100,(160/dt:200/dt)) = 50;

    target(1:100,(1/dt:40/dt)+340/dt) = 50;
    target(101:200,(40/dt:80/dt)+340/dt) = 50;
    target(201:300,(80/dt:120/dt)+340/dt) = 50;
    target(101:200,(120/dt:160/dt)+340/dt) = 50;
    target(1:100,(160/dt:200/dt)+340/dt) = 50;

    target(1:100,(1/dt:40/dt)+690/dt) = 50;
    target(101:200,(40/dt:80/dt)+690/dt) = 50;
    target(201:300,(80/dt:120/dt)+690/dt) = 50;
    target(101:200,(120/dt:160/dt)+690/dt) = 50;
    target(1:100,(160/dt:200/dt)+690/dt) = 50;

elseif boolean == 6 %time discretization test saved in discr6 15ms stims
   
    %motif A
    target(1:100,1/dt:15/dt) = 50;
    target(201:300,15/dt:30/dt) = 50;
    target(101:200,30/dt:45/dt) = 50;
    target(201:300,45/dt:60/dt) = 50;
    target(101:200,60/dt:75/dt) = 50;
    target(201:300,75/dt:90/dt) = 50;
    target(1:100,90/dt:105/dt) = 50;
    target(101:200,105/dt:120/dt) = 50;
    target(1:100,120/dt:135/dt) = 50;
    target(101:200,135/dt:150/dt) = 50;
    target(201:300,150/dt:165/dt) = 50;
    target(1:100,165/dt:180/dt) = 50;
    target(101:200,180/dt:200/dt) = 50;
    
    %motif A
    target(1:100,(1/dt:15/dt)+340/dt) = 50;
    target(201:300,(15/dt:30/dt)+340/dt) = 50;
    target(101:200,(30/dt:45/dt)+340/dt) = 50;
    target(201:300,(45/dt:60/dt)+340/dt) = 50;
    target(101:200,(60/dt:75/dt)+340/dt) = 50;
    target(201:300,(75/dt:90/dt)+340/dt) = 50;
    target(1:100,(90/dt:105/dt)+340/dt) = 50;
    target(101:200,(105/dt:120/dt)+340/dt) = 50;
    target(1:100,(120/dt:135/dt)+340/dt) = 50;
    target(101:200,(135/dt:150/dt)+340/dt) = 50;
    target(201:300,(150/dt:165/dt)+340/dt) = 50;
    target(1:100,(165/dt:180/dt)+340/dt) = 50;
    target(101:200,(180/dt:200/dt)+340/dt) = 50;

    %motif A
    target(1:100,(1/dt:15/dt)+690/dt) = 50;
    target(201:300,(15/dt:30/dt)+690/dt) = 50;
    target(101:200,(30/dt:45/dt)+690/dt) = 50;
    target(201:300,(45/dt:60/dt)+690/dt) = 50;
    target(101:200,(60/dt:75/dt)+690/dt) = 50;
    target(201:300,(75/dt:90/dt)+690/dt) = 50;
    target(1:100,(90/dt:105/dt)+690/dt) = 50;
    target(101:200,(105/dt:120/dt)+690/dt) = 50;
    target(1:100,(120/dt:135/dt)+690/dt) = 50;
    target(101:200,(135/dt:150/dt)+690/dt) = 50;
    target(201:300,(150/dt:165/dt)+690/dt) = 50;
    target(1:100,(165/dt:180/dt)+690/dt) = 50;
    target(101:200,(180/dt:200/dt)+690/dt) = 50;   
end

end