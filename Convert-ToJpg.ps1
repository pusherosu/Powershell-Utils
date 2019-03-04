# Convert-ToJpg.ps1
# Converts all bitmap images in the working directory into jpeg images
# Uncomment the Remove-Item line to delete the original

function Convert-ToJpg
{
	$file = New-Object System.Drawing.Bitmap($_.FullName);
	$file.Save($_.Directory.FullName + "\" + $_.BaseName + ".bmp","bmp");
	$file.Dispose()
	#Remove-Item ($_.FullName) #Uncomment this line if you also want to delete the original image
}

[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms");
Get-ChildItem "." | Where-Object {$_.Extension -eq ".jpg"} | %{ConvertTo-Jpg}
