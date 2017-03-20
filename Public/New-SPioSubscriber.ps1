function New-SPioSubscriber {
    Param
    (
      [parameter(Mandatory=$false)]
      [string]
      $SubscriberEmail,
      [parameter(Mandatory=$false)]
      [string]
      $SubscriberPhoneNumber,
      [parameter(Mandatory=$false)]
      [ValidateSet("Afghanistan","Albania","Algeria","AmericanSamoa","Andorra","Angola","Anguilla","AntiguaandBarbuda","Argentina","Armenia","Aruba","AustraliaCocosChristmasIsland","Austria","Azerbaijan","Bahamas","Bahrain","Bangladesh","Barbados","Belarus","Belgium","Belize","Benin","Bermuda","Bolivia","BosniaandHerzegovina","Botswana","Brazil","Brunei","Bulgaria","BurkinaFaso","Burundi","Cambodia","Cameroon","Canada","CapeVerde","CaymanIslands","CentralAfrica","Chad","Chile","China","Colombia","Comoros","Congo","CongoDemRep","CostaRica","Croatia","Cyprus","CzechRepublic","Denmark","Djibouti","Dominica","DominicanRepublic","Egypt","ElSalvador","EquatorialGuinea","Estonia","Ethiopia","FaroeIslands","Fiji","FinlandAlandIslands","France","FrenchGuiana","FrenchPolynesia","Gabon","Gambia","Georgia","Germany","Ghana","Gibraltar","Greece","Greenland","Grenada","Guadeloupe","Guam","Guatemala","Guinea","Guyana","Haiti","Honduras","HongKong","Hungary","Iceland","India","Indonesia","Iran","Iraq","Ireland","Israel","Italy","Jamaica","Japan","Jordan","Kenya","KoreaRepublicof","Kuwait","Kyrgyzstan","Laos","Latvia","Lebanon","Lesotho","Liberia","Libya","Liechtenstein","Lithuania","Luxembourg","Macao","Macedonia","Madagascar","Malawi","Malaysia","Maldives","Mali","Malta","Martinique","Mauritania","Mauritius","Mexico","Monaco","Mongolia","Montenegro","Montserrat","MoroccoWesternSahara","Mozambique","Namibia","Nepal","Netherlands","NewZealand","Nicaragua","Niger","Nigeria","Norway","Oman","Pakistan","PalestinianTerritory","Panama","Paraguay","Peru","Philippines","Poland","Portugal","PuertoRico","Qatar","ReunionMayotte","Romania","RussiaKazakhstan","Rwanda","Samoa","SanMarino","SaudiArabia","Senegal","Serbia","Seychelles","SierraLeone","Singapore","Slovakia","Slovenia","SouthAfrica","Spain","SriLanka","StKittsandNevis","StLucia","StVincentGrenadines","Sudan","Suriname","Swaziland","Sweden","Switzerland","Syria","Taiwan","Tajikistan","Tanzania","Thailand","Togo","Tonga","TrinidadandTobago","Tunisia","Turkey","TurksandCaicosIslands","Uganda","Ukraine","UnitedArabEmirates","UnitedKingdom","UnitedStates","Uruguay","Uzbekistan","Venezuela","Vietnam","VirginIslandsBritish","VirginIslandsUS","Yemen","Zambia","Zimbabwe")]
      [string]
      $SubscriberPhoneCountry,
      [parameter(Mandatory=$false)]
      [ValidateSet("T","F")]
      [string]
      $SkipConfirmationNotification,
      [parameter(Mandatory=$false)]
      [string[]]
      $ComponentID,
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

$countryHash = @{
    Afghanistan = "af"
    Albania = "al"
    Algeria = "dz"
    AmericanSamoa = "as"
    Andorra = "ad"
    Angola = "ao"
    Anguilla = "ai"
    AntiguaandBarbuda = "ag"
    Argentina = "ar"
    Armenia = "am"
    Aruba = "aw"
    AustraliaCocosChristmasIsland = "au"
    Austria = "at"
    Azerbaijan = "az"
    Bahamas = "bs"
    Bahrain = "bh"
    Bangladesh = "bd"
    Barbados = "bb"
    Belarus = "by"
    Belgium = "be"
    Belize = "bz"
    Benin = "bj"
    Bermuda = "bm"
    Bolivia = "bo"
    BosniaandHerzegovina = "ba"
    Botswana = "bw"
    Brazil = "br"
    Brunei = "bn"
    Bulgaria = "bg"
    BurkinaFaso = "bf"
    Burundi = "bi"
    Cambodia = "kh"
    Cameroon = "cm"
    Canada = "ca"
    CapeVerde = "cv"
    CaymanIslands = "ky"
    CentralAfrica = "cf"
    Chad = "td"
    Chile = "cl"
    China = "cn"
    Colombia = "co"
    Comoros = "km"
    Congo = "cg"
    CongoDemRep = "cd"
    CostaRica = "cr"
    Croatia = "hr"
    Cyprus = "cy"
    CzechRepublic = "cz"
    Denmark = "dk"
    Djibouti = "dj"
    Dominica = "dm"
    DominicanRepublic = "do"
    Egypt = "eg"
    ElSalvador = "sv"
    EquatorialGuinea = "gq"
    Estonia = "ee"
    Ethiopia = "et"
    FaroeIslands = "fo"
    Fiji = "fj"
    FinlandAlandIslands = "fi"
    France = "fr"
    FrenchGuiana = "gf"
    FrenchPolynesia = "pf"
    Gabon = "ga"
    Gambia = "gm"
    Georgia = "ge"
    Germany = "de"
    Ghana = "gh"
    Gibraltar = "gi"
    Greece = "gr"
    Greenland = "gl"
    Grenada = "gd"
    Guadeloupe = "gp"
    Guam = "gu"
    Guatemala = "gt"
    Guinea = "gn"
    Guyana = "gy"
    Haiti = "ht"
    Honduras = "hn"
    HongKong = "hk"
    Hungary = "hu"
    Iceland = "is"
    India = "in"
    Indonesia = "id"
    Iran = "ir"
    Iraq = "iq"
    Ireland = "ie"
    Israel = "il"
    Italy = "it"
    Jamaica = "jm"
    Japan = "jp"
    Jordan = "jo"
    Kenya = "ke"
    KoreaRepublicof = "kr"
    Kuwait = "kw"
    Kyrgyzstan = "kg"
    Laos = "la"
    Latvia = "lv"
    Lebanon = "lb"
    Lesotho = "ls"
    Liberia = "lr"
    Libya = "ly"
    Liechtenstein = "li"
    Lithuania = "lt"
    Luxembourg = "lu"
    Macao = "mo"
    Macedonia = "mk"
    Madagascar = "mg"
    Malawi = "mw"
    Malaysia = "my"
    Maldives = "mv"
    Mali = "ml"
    Malta = "mt"
    Martinique = "mq"
    Mauritania = "mr"
    Mauritius = "mu"
    Mexico = "mx"
    Monaco = "mc"
    Mongolia = "mn"
    Montenegro = "me"
    Montserrat = "ms"
    MoroccoWesternSahara = "ma"
    Mozambique = "mz"
    Namibia = "na"
    Nepal = "np"
    Netherlands = "nl"
    NewZealand = "nz"
    Nicaragua = "ni"
    Niger = "ne"
    Nigeria = "ng"
    Norway = "no"
    Oman = "om"
    Pakistan = "pk"
    PalestinianTerritory = "ps"
    Panama = "pa"
    Paraguay = "py"
    Peru = "pe"
    Philippines = "ph"
    Poland = "pl"
    Portugal = "pt"
    PuertoRico = "pr"
    Qatar = "qa"
    ReunionMayotte = "re"
    Romania = "ro"
    RussiaKazakhstan = "ru"
    Rwanda = "rw"
    Samoa = "ws"
    SanMarino = "sm"
    SaudiArabia = "sa"
    Senegal = "sn"
    Serbia = "rs"
    Seychelles = "sc"
    SierraLeone = "sl"
    Singapore = "sg"
    Slovakia = "sk"
    Slovenia = "si"
    SouthAfrica = "za"
    Spain = "es"
    SriLanka = "lk"
    StKittsandNevis = "kn"
    StLucia = "lc"
    StVincentGrenadines = "vc"
    Sudan = "sd"
    Suriname = "sr"
    Swaziland = "sz"
    Sweden = "se"
    Switzerland = "ch"
    Syria = "sy"
    Taiwan = "tw"
    Tajikistan = "tj"
    Tanzania = "tz"
    Thailand = "th"
    Togo = "tg"
    Tonga = "to"
    TrinidadandTobago = "tt"
    Tunisia = "tn"
    Turkey = "tr"
    TurksandCaicosIslands = "tc"
    Uganda = "ug"
    Ukraine = "ua"
    UnitedArabEmirates = "ae"
    UnitedKingdom = "gb"
    UnitedStates = "us"
    Uruguay = "uy"
    Uzbekistan = "uz"
    Venezuela = "ve"
    Vietnam = "vn"
    VirginIslandsBritish = "vg"
    VirginIslandsUS = "vi"
    Yemen = "ye"
    Zambia = "zm"
    Zimbabwe = "zw"
    }

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
$subscriber=@{}
if ($SubscriberEmail)
    {
    $subscriber.Add("email",$SubscriberEmail)
    }
if ($SubscriberPhoneNumber)
    {
    $subscriber.Add("phone_number",$SubscriberPhoneNumber)
    }
if ($SubscriberPhoneCountry)
    {
    $subscriber.Add("phone_country",$countryHash.Item("$SubscriberPhoneCountry"))
    }
if ($SkipConfirmationNotification -eq "T" -or $SkipConfirmationNotification -eq "F")
    {
    $subscriber.Add("skip_confirmation_notification",$SkipConfirmationNotification)
    }
if ($ComponentID)
    {
    $subscriber.Add("component_ids",@($ComponentID))
    }
$body = @{
    subscriber=$subscriber
    } | ConvertTo-Json

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