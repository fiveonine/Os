#myprocinfo.ps1

$loop = 1
$meny = @("1- Hvem er jeg og hva er dette scriptet?
2- Hvor lenge er det siden siste boot?
3- Hvor mange tråder og prosesser finnes?
4- Hvor mange context switcher fant sted siste sekund?
5- Hvor stor andel av cpu-tiden ble benyttet i kernelmode og i usermode siste sekund?
6- Hvor mange interupts fant sted siste sekund?
9- Avslutt dette scriptet")
$os = Get-WmiObject -class Win32_OperatingSystem

#funksjoner
function info() {
	clear
	Write-Host "Du heter $($env:username) og dette er myprocinfi.ps1 skrevet av Sveinung Aaker Gundersen."
	Write-host "(Press enter)"
	Read-Host
}

function boot() {
	clear
	$uptime = (Get-Date) - $os.ConvertToDateTime($os.LastBootUpTime)
	Write-Host "Det er $($uptime.Days) dager $($uptime.Hours) timer og $($uptime.Minutes) minutter siden siste boot."
	Write-host "(Press enter)"
	Read-Host
}

function traad() {
	clear
	$traad = (Get-Process | select -ExpandProperty Threads).count
	Write-Host "Det finnes $($traad) tråder og $($os.NumberOfProcesses) prosesser."
	Write-host "(Press enter)"
	Read-Host
}

function context() {
	clear
	$switch = (Get-WmiObject Win32_perfFormatteddata_perfos_system).contextswitchespersec
	Write-Host "I løpet av det siste sekundet har det forekommet $($switch) context switcher."
	Write-host "(Press enter)"
	Read-Host
}

function cpu() {
	clear
	$kernel = ((Get-Counter "\Processor(_total)\% Privileged Time").CounterSamples).CookedValue
	$user =((Get-Counter "\Processor(_total)\% User Time").CounterSamples).CookedValue
	Write-Host "Det siste sekundet har $($kernel)% blitt brukt i kernelmode, og $($user)% i usermode"
	Write-host "(Press enter)"
	Read-Host
}

function interupts() {
	clear
	$interupt = ((Get-Counter "\Processor(_total)\Interrupts/sec").CounterSamples).CookedValue
	Write-Host "Det siste sekundet har det forekommet $($interupt) interupts."
	Write-host "(Press enter)"
	Read-Host
}

#main loop

while ($loop) {
	Clear
	Write-host $meny
	$inn = Read-Host
	switch ($inn) {
		1 {info}
		2 {boot}
		3 {traad}
		4 {context}
		5 {cpu}
		6 {interupts}
		9 {$loop = 0}
		default {clear; Write-Host "$($inn) er ikke et gyldig meny-valg..."; Read-Host}
	}
}
