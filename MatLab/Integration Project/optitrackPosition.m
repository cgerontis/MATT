function optitrackPosition(natnet, bodyID, MATT,desiredX,desiredZ)
%calling this function guides MATT to a certain Optitrack position instead
%of a MATT position
%x and z are the desired optitrack z and x positions to be maintained

    persistent offsetX
    persistent offsetY

    margin = 10; %margin of error in mm
    command = '';
    
    [MX,MY] = getMATTposition(MATT);
    pause(0.1);
    
    data = natnet.getFrame;
    x = data.RigidBody(bodyID).x * 1000;
    z = data.RigidBody(bodyID).z * 1000;
    %desiredX = data.RigidBody(bodyID).x * 1000;
    %desiredZ = data.RigidBody(bodyID).z * 1000;
    %main loop, runs for 10000 cycles
    while(abs(desiredX-x) > margin || abs(desiredZ-z) > margin)
        data = natnet.getFrame;
        %keep checking the optitrack position of the object
        x = data.RigidBody(bodyID).x * 1000;
        z = data.RigidBody(bodyID).z * 1000;
%         fprintf('DesiredX: %d\n',desiredX)
%         fprintf('DesiredZ: %d\n',desiredZ)
%         fprintf('Current X: %d\n',x)
%         fprintf('Current Z: %d\n',z)
     
        if(NatNetIsMoving(natnet,1,1) == 0  ...
                && (abs(desiredX-x) > margin || abs(desiredZ-z) > margin))
        
           % MX = MX - (z - desiredZ);
            %MY = MY - (x - desiredX);
            
            if(data.RigidBody(1).MeanError ~= 0)
                offsetX =  MX + z;
                offsetY = MY - x;
            end

            MX = offsetX - desiredZ;
            MY = offsetY + desiredX;
             
        
            command = '';
            command = strcat('X',num2str(MX),'Y',num2str(MY));
            fprintf(MATT,'%s\r\n',command)
            fprintf('%s\r\n',command)
            pause(1)
            
        end
        pause(0.1)
        
    end
end