function Set-PSStatusPageConfig {
    [cmdletbinding()]
    param(
        [string]$APIKey,
        [string]$PageID,
        [string]$Path = "$ModuleRoot\$env:USERNAME-$env:COMPUTERNAME-PSStatusPage.xml"
    )

Switch ($PSBoundParameters.Keys)
    {
    'APIKey'{$Script:PSStatusPage.APIKey = $APIKey}
    'PageID'{$Script:PSStatusPage.PageID = $PageID}
    }
Function Encrypt {
    param([string]$string)
    if($String -notlike '')
        {
        ConvertTo-SecureString -String $string -AsPlainText -Force
        }
    }
#Write the global variable and the xml
$Script:PSStatusPage | Select -Property @{N='APIKey';E={Encrypt $_.APIKey}},@{N='PageID';E={Encrypt $_.PageID}} | Export-Clixml -Path $Path -Force
}