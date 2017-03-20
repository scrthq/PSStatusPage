function Remove-SPioSubscriber {
    Param
    (
      [parameter(Mandatory=$true)]
      [string]
      $SubscriberID,
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
    $URI = "$URI/subscribers/$SubscriberID.json"
    }
else
    {
    $URI = "$URI/incidents/$IncidentID/subscribers/$SubscriberID.json"
    }
try
    {
    $response = Invoke-RestMethod -Method Delete -Uri $URI -Headers $headers -ContentType "application/json" -ErrorAction Stop
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
return $response
}