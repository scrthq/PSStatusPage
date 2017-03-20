function Set-PSStatusPageConfig {
    [cmdletbinding()]
    param(
        [string]$APIKey,
        [string]$PageID,
        [string]$OrganizationID,
        [string]$Path = "$ModuleRoot\$env:USERNAME-$env:COMPUTERNAME-PSStatusPage.xml"
    )

Switch ($PSBoundParameters.Keys)
    {
    'APIKey'{$Script:PSStatusPage.APIKey = $APIKey}
    'PageID'{$Script:PSStatusPage.PageID = $PageID}
    'OrganizationID'{$Script:PSStatusPage.OrganizationID = $OrganizationID}
    }
Function Encrypt {
    param([string]$string)
    if($String -notlike '')
        {
        ConvertTo-SecureString -String $string -AsPlainText -Force
        }
    }
#Write the global variable and the xml
$Script:PSStatusPage | Select-Object -Property @{N='APIKey';E={Encrypt $_.APIKey}},@{N='PageID';E={Encrypt $_.PageID}},@{N="OrganizationID";E={Encrypt $_.OrganizationID}} | Export-Clixml -Path $Path -Force
}