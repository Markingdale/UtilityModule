function Get-ServerSvc {
    [CmdletBinding()]
    Param(
        [Parameter(Mandatory)]
        [string]
        $service,

        [string]
        $searchbase = "OU=Servers,DC=sdale,DC=org"
    )

    $serviceUp = @()
    $servers = Get-ADcomputer -SearchBase $searchbase -SearchScope subtree -Filter `
        {name -notlike "*SCCM-DP" -and name -notlike "*AXIS*" -and name -notlike "*ENERGY*"}

    foreach ($s in $servers) {
        if ((Test-Port -ComputerName $s.name -Port 5985).PortOpened) {
            Write-Host "Host $($s.name) is up." -fore Green
            $svc = try {
                Get-Service -ComputerName $s.name $service  -ErrorAction Stop
                } catch [Microsoft.PowerShell.Commands.ServiceCommandException]{
                    continue 
                }
                
                if ($svc.status -eq "running") {
                    Write-Host "  >> $service is $($svc.Status) on $($s.name)!" 
                    $serviceUp += $s
                }
        } else {
            Write-Host "  Host $($s.name) is not responding ..." -fore Red
        }
    }

    return $serviceUp
}

