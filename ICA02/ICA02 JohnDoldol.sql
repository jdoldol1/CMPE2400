select 
		LEFT(@@SERVERNAME, 12) as 'Server',
		SUBSTRING(@@VERSION, 14, 22) as 'Version',
		@@ERROR as 'Errors',
		@@CONNECTIONS as 'Connections'
		


		



