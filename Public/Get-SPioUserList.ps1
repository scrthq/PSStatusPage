function Get-SPioUserList {
    Param
    (
      [parameter(Mandatory=$false)]
      [string]
      $IncidentID,
      [parameter(Mandatory=$false)]
      [string]
      $APIKey = $Script:PSStatusPage.APIKey,
      [parameter(Mandatory=$false)]
      [string]
      $OrganizationID = $Script:PSStatusPage.OrganizationID
    )
$headers = @{
    Authorization = "OAuth $APIKey"
    }
$URI = "https://api.statuspage.io/v1/organizations/$($OrganizationID)/users.json"
try
    {
    $response = Invoke-RestMethod -Method Get -Uri $URI -Headers $headers -ContentType "application/json" -ErrorAction Stop
    }
catch
    {
    Write-Error $Error[0]
    }
return $response
}