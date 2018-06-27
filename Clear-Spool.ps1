$spoolpath = [environment]::getfolderpath("system") + "\spool\PRINTERS\*"

Stop-Service spooler
Remove-Item $spoolpath
Start-Service spooler
