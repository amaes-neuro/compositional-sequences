function target = set_target(boolean,RneuronNum,T,dt)

target = -1*ones(RneuronNum,T/dt+1);

if boolean %AAB%
    
    %motif A 
    target(1:100,10/dt:40/dt) = 45;
    target(101:200,40/dt:80/dt) = 45;
    target(201:300,80/dt:120/dt) = 45;
    target(101:200,120/dt:160/dt) = 45;
    target(1:100,160/dt:200/dt) = 45;
    
    %motif A
    target(1:100,(1/dt:40/dt)+350/dt) = 45;
    target(101:200,(40/dt:80/dt)+350/dt) = 45;
    target(201:300,(80/dt:120/dt)+350/dt) = 45;
    target(101:200,(120/dt:160/dt)+350/dt) = 45;
    target(1:100,(160/dt:200/dt)+350/dt) = 45;

    %motif B
    target(301:400,(1/dt:50/dt)+700/dt) = 45;
    target(401:500,(50/dt:120/dt)+700/dt) = 45;
    target(501:600,(120/dt:200/dt)+700/dt) = 45;
    
else %BAAB%
    
    %motif B
    target(301:400,(1/dt:50/dt)) = 45;
    target(401:500,(50/dt:120/dt)) = 45;
    target(501:600,(120/dt:200/dt)) = 45;
    
    %motif A
    target(1:100,(1/dt:40/dt)+250/dt) = 45;
    target(101:200,(40/dt:80/dt)+250/dt) = 45;
    target(201:300,(80/dt:120/dt)+250/dt) = 45;
    target(101:200,(120/dt:160/dt)+250/dt) = 45;
    target(1:100,(160/dt:200/dt)+250/dt) = 45;
    
    %motif A
    target(1:100,(1/dt:40/dt)+500/dt) = 45;
    target(101:200,(40/dt:80/dt)+500/dt) = 45;
    target(201:300,(80/dt:120/dt)+500/dt) = 45;
    target(101:200,(120/dt:160/dt)+500/dt) = 45;
    target(1:100,(160/dt:200/dt)+500/dt) = 45;
    
    %motif B
    target(301:400,(1/dt:50/dt)+750/dt) = 45;
    target(401:500,(50/dt:120/dt)+750/dt) = 45;
    target(501:600,(120/dt:200/dt)+750/dt) = 45;
    
end

end