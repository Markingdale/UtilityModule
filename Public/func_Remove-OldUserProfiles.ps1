
Function Remove-OldUserProfiles {

    [CmdletBinding()]
    Param(
        $Days = 365,

        $ComputerName = 'localhost',
        
        [switch]
        $Preview
    )


    $protected = @(
        "C:\WINDOWS\ServiceProfiles\NetworkService"
        "C:\WINDOWS\ServiceProfiles\LocalService"
        "C:\WINDOWS\system32\config\systemprofile"
        "C:\Users\Administrator"
    )


    foreach ($Profile in (Get-CimInstance -ComputerName $ComputerName -ClassName win32_userprofile)) {
        if (!($protected -contains $Profile.LocalPath) -and ($Profile.LocalPath -ne $env:USERPROFILE)){
            $ProfileFolderPath = "\\$($computername)\c$\Users\$($Profile.LocalPath.Split("\")[2])"
            $ProfileFolderInfo = Get-Item $ProfileFolderPath
            if ($ProfileFolderInfo.LastWriteTime -lt ((Get-Date).AddDays(-$Days))) {
                Write-Host "$(Get-Date $ProfileFolderInfo.LastWriteTime -format "yyyy MM-dd") | $($Profile.LocalPath)" -f Cyan
                if (!($Preview.IsPresent)) {
                    Write-Host " >> Removing $($Profile.LocalPath)" -f Cyan
                    Get-CimInstance -ComputerName $ComputerName -ClassName Win32_UserProfile | Where-Object {$_.LocalPath -eq $Profile.LocalPath} | Remove-CimInstance 
                }
            }#>
        }
    }
}
