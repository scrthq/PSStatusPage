function New-SPioUser {
    Param
    (
      [parameter(Mandatory=$true)]
      [string]
      $Email,
      [parameter(Mandatory=$true)]
      [SecureString]
      $Password,
      [parameter(Mandatory=$true)]
      [string]
      $FirstName,
      [parameter(Mandatory=$true)]
      [string]
      $LastName,
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
$user=@{
    email = $Email
    password = "$(Decrypt $Password)"
    first_name = $FirstName
    last_name = $LastName
}
$body = @{
    user=$user
    } | ConvertTo-Json -Depth 2

try
    {
    $response = Invoke-RestMethod -Method Post -Uri $URI -Headers $headers -Body $body -ContentType "application/json" -ErrorAction Stop
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