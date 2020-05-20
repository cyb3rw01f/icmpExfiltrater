# icmpExfiltrater
This is a Proof of Concept. This file is for testing purposes only. Malicious use of this script is prohibitted.  

 This script canm be used to assist testing a security controls ability to detect/alert based on data exfiltration via the ICMP protocol.  

# Notes
This is very slow and noisy so it is highly suggested that only small files are used for testing.

# How to use

## Sender
On the sending side  

## Receiver
On the receiving end run a apcket capture program such as tcpdump or tshark to capture the incoming ICMP data. Once the transfer is complete you can use a program like tshark to extract the data back to its normal form. See the data recovery information below  

## Recover exfiltrated data
You can use Tshark to extract the paylod from the icmp data field. Tshark is installed on Windows when Wireshark program is installed. Tshark is installed seperate from the Wireshark program. On Linux simply use your systems prefered package manger to install Tshark.  

Replace <b>icmp.pcap<>/b with your captured icmp data from the receving side <b>ip.src==</b> with your sorce sending IP address  

<b>Linux:</b>  
<code>tshark -r icmp.pcap -Y ip.src==8.8.8.8 -T fields -e data | xxd -r -p > data2</code>  

<b>Windows:</b>  
<code>tshark -r icmp.pcap -Y ip.src==8.8.8.8 -T fields -e data | powershell -c format-hex data2</code>
