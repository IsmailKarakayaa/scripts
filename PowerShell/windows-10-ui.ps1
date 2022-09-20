# PS: Run script as administrator and restart your computer to apply changes if script ran succesfully

# Variables 
$context = 'HKCU:\SOFTWARE\Classes\CLSID'
$contextFolder = '{86ca1aa0-34aa-4e8b-a509-50c905bae2a2}'
$contextKey = 'InprocServer32'

$explorer = 'HKLM:\SOFTWARE\Microsoft\Windows\CurrentVersion\Shell Extensions'
$explorerFolder = 'Blocked'
$explorerStringKey = '{e2bf9676-5f8f-435c-97eb-11607a5bedf7}'


# Enable Windows 10 Context Menu
function EnableWindows10ContextMenu {
    try {
        if(Test-Path $context\$contextFolder\$contextKey) {
            Write-Host The required key for context menu already exists: $context\$contextFolder\$contextKey  -foregroundcolor green
        }
        else {
            new-item -Path $context -Name $contextFolder -ErrorAction SilentlyContinue
            Write-Host Created key folder $contextFolder 
        
            new-item -Path $context\$contextFolder -Name $contextKey -Value ""
            Write-Host Created key $contextKey
    
            Write-Host Enabled Windows 10 context menu -ForegroundColor Green
        }
    }
    catch {
        Write-Host "An error occured while enabling the Windows 10 context menu: " -foregroundcolor red
        Write-Host $_ -foregroundcolor red
    }
}

# Enable Windows 10 Explorer UI
function EnableWindows10ExplorerUI {
    try {
        if(Get-ItemProperty $explorer\$explorerfolder | Get-Member $explorerStringKey -ErrorAction SilentlyContinue) {
            Write-Host The required key string for explorer ui already exists: $explorer\$explorerFolder\$explorerStringKey  -foregroundcolor green
        }
        
        else {
            New-item -Path $explorer -Name $explorerFolder -ErrorAction SilentlyContinue
            New-ItemProperty -Path $explorer\$explorerFolder -PropertyType 'String' -Name $explorerStringKey -ErrorAction Stop
            Write-Host Created key string $explorerStringKey at $explorer\$explorerFolder
            Get-ItemProperty $explorer\$explorerFolder
    
            Write-Host Enabled Windows 10 Explorer UI -ForegroundColor green
        }
    }
    catch {
        Write-Host "An error occured while enabling the Windows 10 Explorer UI: " -foregroundcolor red
        Write-Host $_ -foregroundcolor red
    }
}

EnableWindows10ContextMenu
EnableWindows10ExplorerUI

Read-Host -Prompt "Press Enter to exit"
