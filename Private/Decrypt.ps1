function Decrypt {
    param($String)
    if($String -is [System.Security.SecureString])
    {
        [System.Runtime.InteropServices.marshal]::PtrToStringAuto(
            [System.Runtime.InteropServices.marshal]::SecureStringToBSTR(
                $string))
    }
}