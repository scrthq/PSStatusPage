Function Get-PSStatusPageConfig {
    [cmdletbinding(DefaultParameterSetName = 'source')]
    param(
        [parameter(ParameterSetName='source')]
        [ValidateSet("PSStatusPage","PSStatusPage.xml")]
        $Source = "PSStatusPage",

        [parameter(ParameterSetName='path')]
        [parameter(ParameterSetName='source')]
        $Path = "$ModuleRoot\$env:USERNAME-$env:COMPUTERNAME-PSStatusPage.xml"
    )
if($PSCmdlet.ParameterSetName -eq 'source' -and $Source -eq "PSStatusPage" -and -not $PSBoundParameters.ContainsKey('Path'))
    {
    $Script:PSStatusPage
    }
else
    {
    function Decrypt {
        param($String)
        if($String -is [System.Security.SecureString])
            {
            [System.Runtime.InteropServices.marshal]::PtrToStringAuto(
                [System.Runtime.InteropServices.marshal]::SecureStringToBSTR(
                    $string))
            }
        }
    Import-Clixml -Path $Path | Select-Object -Property @{N='APIKey';E={Decrypt $_.APIKey}},@{N='PageID';E={Decrypt $_.PageID}},@{N="OrganizationID";E={Decrypt $_.OrganizationID}}
    }
}