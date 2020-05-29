# Golden Ticket Automation

Theses scripts allow an attacker with domain admin rights to automate Golden Ticket creation in Active Directory.
The script main.ps1 download an obfuscated (Encoded Base64 and AES 128 bits encryption) Mimikatz by Xencrypt powershell script. Its pwned.ps1 (You can change it if you want and use a share or http server).

**The script main.ps1 use Elixir to download pwned.ps1 and put it directly in memory, its a fileless attack.**

main.ps1 have three functions :
 - Get-DomainInfos : Get domain informations (SID, user, Account Type, Domain Name) with WMI objects
 - Create-Bowser : Dump krbtgt NTLM Hash with DCsync (Use Mimikatz)
 - Create-Golden : Create the Golden Ticket (Use Mimikatz)


## Usage

    powershell -exec bypass
    .\main.ps1

> Example

<p align="center">
  <img src="https://raw.githubusercontent.com/p0sql/INTECH/master/GoldenTicket_Automation/image/usage.png">
</p>
