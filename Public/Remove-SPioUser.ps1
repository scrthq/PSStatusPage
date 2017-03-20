function Remove-SPioUser {
    [cmdletbinding(SupportsShouldProcess=$true,ConfirmImpact="High")]
    Param
    (
      [parameter(Mandatory=$true)]
      [string]
      $UserID,
      [parameter(Mandatory=$false)]
      [string]
      $APIKey = $Script:PSStatusPage.APIKey,
      [parameter(Mandatory=$false)]
      [string]
      $OrganizationID = $Script:PSStatusPage.OrganizationID
    )
    Begin 
        {
        $headers = @{
            Authorization = "OAuth $APIKey"
            }
        $result = @()
        }
    Process 
        {
            foreach ($User in $UserID) 
                {
                    $URI = "https://api.statuspage.io/v1/organizations/$($OrganizationID)/users/$($User).json"
                    if ($PSCmdlet.ShouldProcess("Removing User ID '$User' from Organization '$OrganizationID'"))
                        {
                            try
                                {
                                $response = Invoke-RestMethod -Method Delete -Uri $URI -Headers $headers -ContentType "application/json" -ErrorAction Stop
                                $result += $response
                                }
                            catch
                                {
                                try
                                    {
                                    $result = $_.Exception.Response.GetResponseStream()
                                    $reader = New-Object System.IO.StreamReader($result)
                                    $reader.BaseStream.Position = 0
                                    $reader.DiscardBufferedData()
                                    $resp = $reader.ReadToEnd()
                                    $response = $resp | ConvertFrom-Json
                                    }
                                catch
                                    {
                                    Write-Error $resp
                                    return
                                    }
                                }
                        }
                }
        }
    End
        {
            return $result
        }
}