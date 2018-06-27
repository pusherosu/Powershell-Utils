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
