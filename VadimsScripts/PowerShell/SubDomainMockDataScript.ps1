function Generate-SubDomain{
    $SubDomain = ""
    for ($i; $i -le 25; $i++) {
        if($i % 2 -eq 0){
            $SubDomain+=[char](Get-Random -Minimum 97 -Maximum 122)
        }
        else{
            $SubDomain+=[char](Get-Random -Minimum 48 -Maximum 57)
        }
    }
    return $SubDomain
   }


$banner = @'
 __     __ _             _  _     
 \ \   / /| |  __ _   __| |( )___ 
  \ \ / / | | / _` | / _` | |/ __|
   \ V /  | || (_| || (_| |  \__ \
    \_/   |_| \__,_| \__,_|  |___/

    ____  _________       _____ ______  ___
   / __ \/ ____/   |     / ___//  _/  |/  /
  / / / / / __/ /| |     \__ \ / // /|_/ /
 / /_/ / /_/ / ___ |    ___/ // // /  / /
/_____/\____/_/  |_|   /____/___/_/  /_/

   +--------------------------------------+
   |       [ DNS TRAFFIC SIMULATOR ]      |
   |   Generate. Resolve. Observe.         |
   +--------------------------------------+
'@

Write-Host $banner -ForegroundColor Cyan

Write-Host "THE TEST HAS BEGUN"

$RootDomain=".fafo69.xyz"

for ($x; $x -le 50; $x++){
   $FQDN = (Generate-SubDomain)+$RootDomain
   nslookup $FQDN > NUL 2>&1
}

Write-Host "THE TEST HAS CONCLUDED"