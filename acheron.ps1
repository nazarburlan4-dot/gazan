$url_mp3 = "https://raw.githubusercontent.com/nazarburlan4-dot/gazan/main/acheronXzagorami.mp3"
$url_vlc = "https://get.videolan.org/vlc/last/win64/vlc-portable-3.0.20-win64.zip"
$tmp = $env:TMP
$mp3 = "$tmp\g.mp3"
$vlc_zip = "$tmp\vlc.zip"
$vlc_dir = "$tmp\vlc"

if (!(Test-Path $mp3)) { (New-Object Net.WebClient).DownloadFile($url_mp3, $mp3) }
if (!(Test-Path "$vlc_dir\vlc.exe")) {
    (New-Object Net.WebClient).DownloadFile($url_vlc, $vlc_zip)
    Expand-Archive $vlc_zip $vlc_dir -Force
}
Start-Process "$vlc_dir\vlc-portable-3.0.20\vlc.exe" -ArgumentList "--start-time=88", "--play-and-exit", $mp3
