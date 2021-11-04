Get-ChildItem -Filter *.vcf | 
Foreach-Object {
	"Updating $_..."
	$in=Get-Content $_
	$regex = '\d*\W*(\d{3})\W*(\d{3})\W*(\d{4})', ': $1-$2-$3'
	$in | Foreach {$_ -replace $regex} | out-file $_
}
