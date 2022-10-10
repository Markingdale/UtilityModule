Function Invoke-SQLCommand { 
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
