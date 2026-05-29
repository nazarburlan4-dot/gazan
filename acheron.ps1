$f="$env:TMP\g.mp3"
$url="https://raw.githubusercontent.com/nazarburlan4-dot/gazan/main/acheronXzagorami.mp3"
if(!(Test-Path $f)){(New-Object Net.WebClient).DownloadFile($url,$f)}
$p=New-Object -ComObject WMPlayer.OCX
$m=$p.newMedia($f)
$p.currentPlaylist=$p.newPlaylist('pl','')
$p.currentPlaylist.appendItem($m)
$p.controls.currentPosition=88
$p.controls.play()