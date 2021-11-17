param([Parameter(Mandatory)][string]$filename)

Get-Content $filename |
% { ($_ -split ';') -ne "" } |
% { $name,$version =  $_ -split '\s+'
    $versionWithoutPlusSuffix = ($version | Select-String -Pattern '[\d\.]+').Matches.Value -split '\.'

    [PSCustomObject]@{
        Name            = $name.ToUpper()
        Version         = $version 
        VersionSortable = $versionWithoutPlusSuffix | % { $_.PadLeft(5,'0') } | Join-String
    }
} |
Sort-Object  -Property Name,VersionSortable -Descending -Unique |
Group-Object -Property Name | 
% { $_.Group[0] } |
Select-Object -Property Name,Version
