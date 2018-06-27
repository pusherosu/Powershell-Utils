$full = $false
$nCount = 0
New-Item -ItemType Directory -Force -Path .\test

do
{
	try
	{
		fsutil file createnew .\test\$nCount.txt 1048576
	}
	catch
	{
		Write-Host "Error. Insufficient space"
		$full = $true
		break
	}
	finally
	{
		$nCount++
	}
}
until ($full)
Remove-Item .\test -Force -Recurse
$wshell = New-Object -ComObject Wscript.Shell
$wshell.Popup("$nCount MB of space available on destination drive.",0,"Done",0x1)
