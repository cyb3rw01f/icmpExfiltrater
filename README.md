# icmpExfiltrater
PowerShell script  that can Exfiltrate data using ICMP - POC


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

Using Tshark to extract the paylod from the icmp data field. Replace ip.src== with your sorce sending IP addr
tshark -r icmp.pcap -Y ip.src==8.8.8.8 -T fields -e data | xxd -r -p > data2
