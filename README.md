# icmpExfiltrater
This file is a proof of concept and should be used for testing purposes only.   
Malicious use is prohibitted.    

Script can be used to assist testing security controls ability to detect/alert based on data exfiltration via the ICMP protocol.      

# Notes
Data exfiltraion via this method is <b>very slow</b> and noisy, so it is highly suggested that only small files are used during testing.  
# How to use

## Sender
On the sending side, when you run the script, you will be prompted for a destination IP adress. After entering a destination IP a file browser window will appear allowing you to select a source file.

![image](https://github.com/user-attachments/assets/b965ec32-de68-4a64-a4e6-934a07008675)

![image](https://github.com/user-attachments/assets/df8efa57-3cdf-4aca-9d9d-bf4b1f246c8a)

## Receiver
On the receiving end, run a apcket capture program such as tcpdump or tshark to capture the incoming ICMP data. Once the transfer is complete you can use a program like tshark to extract the data back to its normal form. See the data recovery information below  

## Recover exfiltrated data
You can use Tshark to extract the paylod from the icmp data field. Tshark is installed on Windows when Wireshark program is installed. Tshark is installed seperate from the Wireshark program. On Linux simply use your systems prefered package manger to install Tshark.  

Replace <b>icmp.pcap</b> with your captured icmp data from the receving side and <b>ip.src==</b> with your sorce sending IP address  

<b>Linux:</b>  
<code>tshark -r icmp.pcap -Y ip.src==8.8.8.8 -T fields -e data | xxd -r -p > data2</code>  

<b>Windows:</b>  
<code>tshark -r icmp.pcap -Y ip.src==8.8.8.8 -T fields -e data | powershell -c format-hex data2</code>
