function NatNetCollect(natnetclient)

	% get the asset descriptions for the asset names
	model = natnetclient.getModelDescription;
	if ( model.RigidBodyCount < 1 )
        fprintf('\n No rigid bodies found');
		return
	end

	% Poll for the rigid body data for a single frame
    %(the number of frames can be changed by changing the idx length)
	for idx = 1 : 1  
		java.lang.Thread.sleep(20); %Pause to avoid issues
		data = natnetclient.getFrame; %Method to get current frame
		
        %Check if any data was actually received
		if (isempty(data.RigidBody(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
        end
                
        %Clear command window for cleaner output
        clc;
        
        %Print the X and Z coordinates for every rigid body
		for i = 1:model.RigidBodyCount
			fprintf( 'Name:"%s"  \n', model.RigidBody( i ).Name )
			fprintf( 'X:%0.1fmm  \n', data.RigidBody( i ).x * 1000 )
			%fprintf( 'Y:%0.1fmm  ', data.RigidBody( i ).y * 1000 )
			fprintf( 'Z:%0.1fmm\n', data.RigidBody( i ).z * 1000 )			
        end
        
    end
    
end


