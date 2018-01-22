Param
(
	[Parameter(Mandatory=$true)][string]$URL
)

try {
	Write-Host "Obtaining geolocation information for $URL" -ForegroundColor Green
	$IPAddress = Resolve-DnsName $URL
	$URI = 'http://ipinfo.io/' + $IPAddress.IP4Address
	Invoke-RestMethod -Uri $URI
}

catch {
	Write-Host "Address not found." -ForegroundColor Red
}

$URL = $URL.Trim("www.")

try {
	If ($whois = New-WebServiceProxy -uri "http://www.webservicex.net/whois.asmx?WSDL") {Write-Host "Gathering $URL data..." -ForegroundColor Green}
	else {Write-Host "Error" -ForegroundColor Red}
	$whois.getwhois("=$URL").Split("<<<")[0]
} 

catch {
	Write-Host "Please enter valid domain name (e.g. microsoft.com)." -ForegroundColor Red
} 

"I just pulled my six-year-old out of T-ball cause I found out they're giving trophies to every boy on every team for simply playing the game. Trophies should be earned. Teaching children that everyone's equal is a dangerous philosophy."