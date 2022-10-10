Function Invoke-SQLCommand { 
        # New Branch

        [CmdletBinding()] 
        Param( 
                [Parameter(
                    Position = 1,
                    Mandatory=$true
                    )][String]
                $Server 
        ) 
            Write-Host "Invoking an SQL command on SQL server:" $Server
    } 
