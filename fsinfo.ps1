function hrbytes
{
	$bytes=$args[0]
	$suffix=0
	while($bytes -gt 1024)
	{
		$bytes=($bytes/1024)
		$suffix++
	}
	$bytes=[math]::round($bytes,2)
	switch($suffix)
	{
		{$_ -eq 0} {"$bytes B" }
		{$_ -eq 1} {"$bytes kB" }
		{$_ -eq 2} {"$bytes mB" }
		{$_ -eq 3} {"$bytes GB" }
		{$_ -eq 4} {"$bytes TB" }
	}
}

$directory=Get-item $args[0]

$free=$directory.PsDrive.free
$total=$($directory.PsDrive.free+$directory.PsDrive.Used)
$percent=((1-($free/$total))*100)
write-host "Partisjonen $directory befinner seg pa er $([math]::round($percent,2))% full."

$filer=$(Get-ChildItem $directory -Recurse | Where-Object { ! $_.PSIsContainer } | sort -Descending length)
$antall=$($filer).count
write-host  "Det finnes $antall filer."

$storst=$filer[0].FullName
$size=$filer[0].Length
write-host "Den storste er " $storst "som er $(hrbytes $size) stor."

$snitt=$($filer | Measure-Object -average length).average
write-host "Den gjennomsnittlige filstorrelsen er $(hrbytes $snitt)"