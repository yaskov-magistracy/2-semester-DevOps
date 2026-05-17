pipeline {
    agent any

    stages {
        stage('Disk usage') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            echo "Current disk state:"
                            df -hT
                        '''
                    } else {
                        powershell '''
                            Write-Host "Current disk state:"
                            Get-CimInstance Win32_LogicalDisk -Filter "DriveType=3" |
                                Select-Object DeviceID,
                                    @{Name="SizeGB";Expression={[math]::Round($_.Size / 1GB, 2)}},
                                    @{Name="UsedGB";Expression={[math]::Round(($_.Size - $_.FreeSpace) / 1GB, 2)}},
                                    @{Name="FreeGB";Expression={[math]::Round($_.FreeSpace / 1GB, 2)}},
                                    @{Name="UsedPercent";Expression={[math]::Round((($_.Size - $_.FreeSpace) / $_.Size) * 100, 2)}} |
                                Format-Table -AutoSize
                        '''
                    }
                }
            }
        }

        stage('Top memory process') {
            steps {
                script {
                    if (isUnix()) {
                        sh '''
                            echo "Process using the most memory:"
                            ps -eo pid,comm,rss,%mem --sort=-rss | head -n 2
                        '''
                    } else {
                        powershell '''
                            Write-Host "Process using the most memory:"
                            Get-Process |
                                Sort-Object WorkingSet64 -Descending |
                                Select-Object -First 1 Id,ProcessName,
                                    @{Name="MemoryMB";Expression={[math]::Round($_.WorkingSet64 / 1MB, 2)}} |
                                Format-Table -AutoSize
                        '''
                    }
                }
            }
        }
    }
}
