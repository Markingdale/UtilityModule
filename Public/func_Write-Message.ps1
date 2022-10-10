Function Write-Message { 
    [CmdletBinding()]
    Param( 
            [Parameter(Position = 0, Mandatory = $true)][String]$Message, 
            [Parameter(Position = 1, Mandatory = $true)][String]$Title
    ) 
    Process { 
        Write-Host "Title:" -ForegroundColor yellow
        Write-Host ">>>$Title"
        Write-Host "Message:" -ForegroundColor Yellow
        Write-Host ">>>$Message"
    } 
}