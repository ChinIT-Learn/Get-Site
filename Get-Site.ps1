Function Get-Site {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, ValueFromPipeline, Position)]
        [string[]]$ipAddress
    )    
    
    BEGIN {
        $IPHT = @()
        $fromA = [system.net.ipaddress]::Parse("xxx.xxx.xxx.xxx").GetAddressBytes()
        [array]::Reverse($fromA)
        $fromB = [system.net.ipaddress]::Parse("xxx.xxx.xxx.xxx").GetAddressBytes()
        [array]::Reverse($fromB)    
        $fromA = [system.BitConverter]::ToUInt32($fromA, 0)
        $fromB = [system.BitConverter]::ToUInt32($fromB, 0)
        $toA = [system.net.ipaddress]::Parse("xxx.xxx.xxx.xxx").GetAddressBytes()
        [array]::Reverse($toA)
        $toB = [system.net.ipaddress]::Parse("xxx.xxx.xxx.xxx").GetAddressBytes()
        [array]::Reverse($toB)
        $toA = [system.BitConverter]::ToUInt32($toA, 0)
        $toB = [system.BitConverter]::ToUInt32($toB, 0)
    }

    PROCESS {
            $ipAddress | ForEach-Object {
            $ip = [system.net.ipaddress]::Parse("$_").GetAddressBytes()
            [array]::Reverse($ip)
            $ip = [system.BitConverter]::ToUInt32($ip, 0)
            if (($fromA -le $ip -and $ip -le $toA) -eq $true) {
                $IPHT +=  "$_ SiteA"
            } Elseif (($fromB -le $ip -and $ip -le $toB) -eq $true) {
                $IPHT += "$_ SiteB"
            } Else {
                Write-Output "Unknown Range for $_"
            }
        }
    }

    END {
        $IPHT
    }
}
