function maintainPosition(natnet, bodyID, MATT, time)
%calling this function attemps to lock PATT in place by checking the
%optitrack position instead of the MATT position
%x and z are the desired optitrack z and x positions to be maintained
    margin = 5; %margin of error in mm
    delay = 0.25; %Time for every cycle in seconds
    command = '';
    
    [MX,MY] = getMATTposition(MATT);
    
    
    data = natnet.getFrame;
    desiredX = data.RigidBody(bodyID).x * 1000;
    desiredZ = data.RigidBody(bodyID).z * 1000;
    %main loop, runs for 10000 cycles
    for J = 1:(time*(1/delay))
        data = natnet.getFrame;
        %keep checking the optitrack position of the object
        x = data.RigidBody(bodyID).x * 1000;
        z = data.RigidBody(bodyID).z * 1000;
%         fprintf('DesiredX: %d\n',desiredX)
%         fprintf('DesiredZ: %d\n',desiredZ)
%         fprintf('Current X: %d\n',x)
%         fprintf('Current Z: %d\n',z)
     
        if(NatNetIsMoving(natnet,1,1) == 0 && (abs(desiredX-x) > margin || abs(desiredZ-z) > margin))
        
           % MX = MX - (z - desiredZ);
            %MY = MY - (x - desiredX);
             MX = MX+(z-desiredZ);
             MY = MY+(-1*(x-desiredX));
             command = strcat('X',num2str(MX),'Y',num2str(MY));
            fprintf(MATT,'%s\r\n',command)
            fprintf('%s\r\n',command)
        end
        pause(delay)
    end
end