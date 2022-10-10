Function Edit-Group { 
    [CmdletBinding()] 
    Param( 
            [Parameter(Position = 1,Mandatory=$true)]
            [String]
            $Group 
    ) 

    try {
        Get-ADGroup $Group
    } catch {
        Write-Host "Problem finding group: $Group."
    }

}