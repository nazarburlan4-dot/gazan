$mp3_url = "https://raw.githubusercontent.com/nazarburlan4-dot/gazan/main/acheronXzagorami.mp3"
$vlc_url = "https://get.videolan.org/vlc/last/win64/vlc-portable-3.0.20-win64.zip"
$tmp = $env:TMP
$mp3 = "$tmp\g.mp3"
$vlc_zip = "$tmp\vlc.zip"
$vlc_dir = "$tmp\vlc"

if (!(Test-Path $mp3)) {
    (New-Object Net.WebClient).DownloadFile($mp3_url, $mp3)
}
if (!(Test-Path "$vlc_dir\vlc.exe")) {
    # Скачиваем и распаковываем VLC
    (New-Object Net.WebClient).DownloadFile($vlc_url, $vlc_zip)
    Expand-Archive $vlc_zip -DestinationPath $vlc_dir -Force
    # После распаковки появляется подпапка vlc-portable-3.0.20, переносим её содержимое на уровень выше
    $subfolder = Get-ChildItem $vlc_dir -Directory | Where-Object { $_.Name -like "vlc-portable*" } | Select-Object -First 1
    if ($subfolder) {
        Move-Item "$($subfolder.FullName)\*" $vlc_dir -Force
        Remove-Item $subfolder.FullName -Recurse -Force
    }
}
# Запускаем vlc.exe (теперь он точно в $vlc_dir)
Start-Process "$vlc_dir\vlc.exe" -ArgumentList "--start-time=88", "--play-and-exit", "`"$mp3`"" -WindowStyle Hidden
