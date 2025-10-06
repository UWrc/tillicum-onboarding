# Establishing your connection to the University of Washington VPN

To connect to University of Washington's OnDemand services for Hyak Klone and Tillicum from an off-campus location you first need to connect to the VPN. 

Follow the [**<ins>Husky OnNet instructions</ins>**](https://itconnect.uw.edu/tools-services-support/networks-connectivity/husky-onnet/installing-configuring-and-using-husky-onnet/).

**Note:** these instructions are different for Windows and MacOS. Follow the instructions that correspond to your operating system. 

## **MacOS Tahoe**

At this time, Big-IP Edge client is not yet supported on MacOS 26 (Tahoe).
Please download and install F5 Access from the App Store and configure the servers similar to the F5 Access iOS instructions under “Selecting a Server on iOS” from the [**<ins>Selecting a Husky OnNet Server page</ins>**](https://uwconnect.uw.edu/it?id=kb_article_view&sysparm_article=KB0034248)

From the F5 Access menu, select Manage VPN Configurations:
1. Click the “+” icon to add a new configuration. 
1. **VPN Name:** Enter a name for the new server, e.g. "UW Campus Network Traffic Only". 
1. **Server:** Enter the appropriate https:// server address for your connection ( e.g. <ins>https://huskyonnet.uw.edu/</ins> ). 
1. Leave Username, Password, and Client Certificate blank. 
1. Check boxes "Web Logon", and "Show VPN Configuration in Menu". 
1. Click Apply.

If you encounter issues connecting to the VPN, send an email to **<ins>help@uw.edu</ins>**. 