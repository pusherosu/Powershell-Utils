# Play a random MP3 file. Create a scheduled task to run script at a 
# specific time. Instant alarm clock

$SongPath = Get-ChildItem -path "path\to\top\level\mp3\folder" -Recurse | Where {$_.extension -like ".mp3"} | Get-Random | Select -expand FullName

Add-Type -Name Window -Namespace Console -MemberDefinition '
[DllImport("Kernel32.dll")]
public static extern IntPtr GetConsoleWindow();

[DllImport("user32.dll")]
public static extern bool ShowWindow(IntPtr hWnd, Int32 nCmdShow);
'

function Hide-Console
{
    $consolePtr = [Console.Window]::GetConsoleWindow()
    #0 hide
    [Console.Window]::ShowWindow($consolePtr, 0)
}

#Hide-Console
Write-Host($SongPath)

Add-Type -AssemblyName presentationCore
$mediaPlayer = New-Object system.windows.media.mediaplayer
$mediaPlayer.open($SongPath)
$mediaPlayer.Play()

Add-Type -AssemblyName PresentationFramework | Out-Null
[System.Windows.MessageBox]::Show('WAKE UP!!!','Alarm Clock','OK','Question')
$mediaPlayer.Stop()
Exit
