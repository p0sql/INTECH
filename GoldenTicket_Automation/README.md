# Golden Ticket Automation

Theses scripts allow an attacker with domain admin rights to automate Golden Ticket creation in Active Directory.
The script main.ps1 download an obfuscated (Encoded Base64 and AES 128 bits encryption) Mimikatz by Xencrypt powershell script. Its pwned.ps1

main.ps1 have three functions :
 - Get-DomainInfos : Get domain informations (SID, user, Account Type, Domain Name) with WMI objects
 - Create-Bowser : Dump krbtgt NTLM Hash with DCsync (Use Mimikatz)
 - Create-Golden : Create the Golden Ticket (Use Mimikatz)


## Usage

    powershell -exec bypass
    .\main.ps1
  
![alt text](https://github.com/p0sql/INTECH/tree/master/GoldenTicket_Automation/image/usage.png?raw=true)
