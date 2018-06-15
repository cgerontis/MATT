function NatNetCollect(natnetclient)

	% get the asset descriptions for the asset names
	model = natnetclient.getModelDescription;
	if ( model.RigidBodyCount < 1 )
        fprintf('\n No rigid bodies found');
		return
	end

	% Poll for the rigid body data a regular intervals (~1 sec) for 10 sec.
	fprintf( '\nPrinting rigid body frame data approximately every second for 10 seconds...\n\n' )
	for idx = 1 : 1  
		java.lang.Thread.sleep(20);
		data = natnetclient.getFrame; % method to get current frame
		
		if (isempty(data.RigidBody(1)))
			fprintf( '\tPacket is empty/stale\n' )
			fprintf( '\tMake sure the server is in Live mode or playing in playback\n\n')
			return
		end
		fprintf( 'Frame:%6d  ' , data.Frame )
		%fprintf( 'Time:%0.2f\n' , data.Timestamp )
        clc;
		for i = 1:model.RigidBodyCount
			fprintf( 'Name:"%s"  \n', model.RigidBody( i ).Name )
			fprintf( 'X:%0.1fmm  \n', data.RigidBody( i ).x * 1000 )
			%fprintf( 'Y:%0.1fmm  ', data.RigidBody( i ).y * 1000 )
			fprintf( 'Z:%0.1fmm\n', data.RigidBody( i ).z * 1000 )			
        end
        
    end
    
end


