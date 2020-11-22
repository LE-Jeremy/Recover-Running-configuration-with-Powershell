###Hi this script is dealing with getting running configuration in a cisco device using csv file for credential###
###If you don't have already install the modules necessary -----> https://www.powershelladmin.com/wiki/File:SSH-Sessions.zip and drop it manually to C:\Windows\System32\WindowsPowerShell\v1.0\Modules
Import-Module SSH-sessions
####Import##
$Info="C:\Users\Public\Get_info.csv"
$Import = import-Csv -Path $Info -delimiter ';'

###Connection to the switch###
for($i=0;$i -lt $Import.length;$i++){
    ###Temporary Variables
    $IP=$import.IP[$i]
    $Username=$import.username[$i]
    $Password=$import.password[$i]
   
    ###SSH Connection
    New-SShSession -computerName $IP -username $Username -Password $Password
    $Command = "show running-config"
    $Result = Invoke-Sshcommand -ComputerName $IP -Command "$Command" | Out-File "C:\Users\Public\$Username.txt"
    $Result
    Remove-SshSession -Remove
}
