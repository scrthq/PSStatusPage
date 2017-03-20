function Get-SPioIncidentList {
    Param
    (
      [parameter(Mandatory=$false)]
      [switch]
      $UnresolvedOnly,
      [parameter(Mandatory=$false)]
      [switch]
      $ScheduledOnly,
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
if ($UnresolvedOnly)
    {
    $URI = "$URI/incidents/unresolved.json"
    }
elseif ($ScheduledOnly)
    {
    $URI = "$URI/incidents/scheduled.json"
    }
else
    {
    $URI = "$URI/incidents.json"
    }
try
    {
    $response = Invoke-RestMethod -Method Get -Uri $URI -Headers $headers -ContentType "application/json" -ErrorAction Stop
    }
catch
    {
    Write-Error $Error[0]
    }
return $response | Sort-Object Name
}