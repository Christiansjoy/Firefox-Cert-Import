#Created by: Christian Joy, Last Modified 20150901 https://github.com/Christiansjoy
#Please leave this by section in when distributing the script, this script however does not carry a license.

#This script import cert/s into Firefoxes certificate store as a trusted root cert.  
#Basically it gets the certs and runs through each firefox profile it finds and imports them.  
#This script therfore needs to be run under the user account you want to affect.
#Ive found no adverse affects from running this via a user login script GPO each login.

#Path to where the included files and certs are
$ToolsPath = "\\server\shares\Sources\Certs\"

#Sets the path of the certs and executable for certutil, you can add and remove here and the lines starting with cmd /c below as needed.  I could use a for loop, but haven't.
$Cert1 = $ToolsPath + "Cert1.cer"
$Cert2 = $ToolsPath + "Cert2.cer"
#You can get your own version of certutil if you want, Mozilla does not release a compiled version though
$Certutil = $Toolspath + "certutil.exe"

#Gets and sets the required path for your Firefox profiles
$HomeDrive = [environment]::GetEnvironmentVariable("HOMEDRIVE")
$Homepath = [environment]::GetEnvironmentVariable("HOMEPATH")
$ProfilePath = $Homedrive + $Homepath + "\AppData\Roaming\Mozilla\Firefox\Profiles\"

#Looks for firefox profiles, exits if none found, otherwise gets the name of each subfolder as the profile path
If ((test-path $ProfilePath) -eq $false) {[Environment]::Exit(0)}
$ProfileDir = (Get-Childitem $ProfilePath)
$Profiles = ($Profilepath + $ProfileDir)

#Runs through each found profile and imports the certs, cmd /c is so it waits for each command to run before continuing.  The "Cert1" and "Cert2" is their name, can be changed if wanted.
Foreach ($Profile in $Profiledir){
$Certdb =  $Profilepath + $Profile.name
If((test-path $CertDB) -eq $true) {
cmd /c $Certutil -A -n "Cert1" -i $Cert1 -d $Certdb -t "TCu,TCu,TCu"
cmd /c $Certutil -A -n "Cert2" -i $Cert2 -d $Certdb -t "TCu,TCu,TCu"
}
}