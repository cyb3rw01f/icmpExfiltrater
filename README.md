# icmpExfiltrater
This is a Proof of Concept. This file is for testing purposes only. Malicious use of this script is prohibitted.  

 This script canm be used to assist testing a security controls ability to detect/alert based on data exfiltration via the ICMP protocol.  

# Notes
This is very slow and noisy so it is highly suggested that only small files are used for testing.

# How to use

## Sender
On the sending side  

## Receiver
On the receiving end run a tcpdump/tshark session to capture the incoming ICMP data. Once the transfer is complete you can use the below tshark command to extract the data back to its normal form.  

## Recover exfiltrated data
Using Tshark to extract the paylod from the icmp data field. Replace ip.src== with your sorce sending IP addr
tshark -r icmp.pcap -Y ip.src==8.8.8.8 -T fields -e data | xxd -r -p > data2  
