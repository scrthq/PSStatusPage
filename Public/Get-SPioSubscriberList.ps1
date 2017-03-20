function Get-SPioSubscriberList {
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
      $PageID = $Script:PSStatusPage.PageID
    )
$headers = @{
    Authorization = "OAuth $APIKey"
    }
$URI = "https://api.statuspage.io/v1/pages/$PageID"
if (!$IncidentID)
    {
    $URI = "$URI/subscribers.json"
    }
else
    {
    $URI = "$URI/incidents/$IncidentID/subscribers.json"
    }
try
    {
    $response = Invoke-RestMethod -Method Get -Uri $URI -Headers $headers -ContentType "application/json" -ErrorAction Stop
    }
catch
    {
    Write-Error $Error[0]
    }
return $response | Select-Object components,created_at,email,phone_country,phone_number,id,skip_confirmation_notification
}