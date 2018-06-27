$SendToPath = "$env:USERPROFILE\AppData\Roaming\Microsoft\Windows\SendTo"
$ShortcutPath = "$SendToPath\Convert to Docx.lnk"
$of = [environment]::getfolderpath("Desktop") + "\Convert-ToDoc.ps1"

$a = '
#########################################################################################################
#													                                                                              #
#	Note: on windows 10, it may also be necessary to delete the registry key at                     			#
#	HKCU\Software\Microsoft\CurrentVersion\Explorer\FileExts\.ps1\UserChoice	                        		#
#												                                                                              	#
#########################################################################################################

[CmdletBinding()]
param(
	[Parameter(Mandatory=$true)]
	[string]$source
)

process{
	$wd = New-Object -ComObject Word.Application
	$wd.Visible = $true

	$txt = $wd.Documents.Open(
		$source,
		$false,
		$false,
		$false
	)

	$dest = [environment]::getfolderpath("mydocuments") + "\" + ($source -replace ".pdf",".docx")
	$wd.Documents[1].SaveAs($dest)
	$wd.Documents[1].Close()
	$wd.Quit()
	[System.Runtime.Interopservices.Marshall]::ReleaseComObject($wd)
	Remove-Variable wd -ErrorAction SilentlyContinue
}
'

Out-File -FilePath $of -InputObject $a -Encoding ASCII -Width 50

New-PSDrive -name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
New-ItemProperty 'HKCR:\Microsoft.PowerShellScript.1\ShellEx\DropHandler' -Name '(Default)' -Value '{60254ca5-953b-11cf-8c96-00aa00b8708c}'
Set-ItemProperty 'HKCR:\Microsoft.PowerShellScript.1\Shell\Open\Command' -Name '(Default)' -Value '"C:\Windows\System32\WindowsPowerShell\v1.0\powershell.exe" -File "%1" %*'

try{
	$wshShell = New-Object -ComObject ("Wscript.Shell")
	$sc = $wshShell.CreateShortcut($ShortcutPath)	
	$sc.TargetPath = "$($of)"
	$sc.Description = "Convert PDF files to Docx. Requires Office to be installed."
	$sc.IconLocation = [environment]::getfolderpath("system") + "\imageres.dll,118" #C:\Windows\system32\imageres.dll,118"
	$sc.Save()
	"Symlink created successfully!"
	return	
}

catch{
	"Failed to create Symlink"
	return
}

finally{
	Remove-Variable SendToPath -ErrorAction SilentlyContinue
	Remove-Variable ShortcutPath -ErrorAction SilentlyContinue
	Remove-Variable sc -ErrorAction SilentlyContinue
	Remove-Variable wshShell -ErrorAction SilentlyContinue
	Remove-Variable of -ErrorAction SilentlyContinue
	Remove-Variable a -ErrorAction SilentlyContinue
  Remove-Item $myinvocation.mycommand.path -Force
}
