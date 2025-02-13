<#

.SYNOPSIS 

Script Creation_de_Groupe_dans_OU;

.DESCRIPTION 

Auteur : samsam, Dro 

Date creation : 13/02/2025

Dernier modificateur : Dro

Date derniere modification : 13/02/2025

#>

# Importer le module Active Directory
Import-Module ActiveDirectory

# Définition du DN du domaine et des OU
$DomainDN = (Get-ADDomain).DistinguishedName
$MainOUPath = "OU=AD_01,$DomainDN"
$GroupeOUPath = "OU=Groupe,$MainOUPath"

# Liste des services
$Services = @("Compta", "Commerce", "Service_info")

# Création des groupes dans chaque sous-OU Groupe
foreach ($Service in $Services) {
    $GroupName = "GRP_$Service"
    New-ADGroup -Name $GroupName -GroupScope Global -Path "OU=$Service,$GroupeOUPath" -PassThru
}

# Définition des permissions
$GroupeCompta = "GRP_Compta"
$GroupeCommerce = "GRP_Commerce"
$GroupeServiceInfo = "GRP_Service_info"

$OUGroupCompta = "OU=Compta,OU=Groupe,$MainOUPath"
$OUGroupCommerce = "OU=Commerce,OU=Groupe,$MainOUPath"
$OUGroupServiceInfo = "OU=Service_info,OU=Groupe,$MainOUPath"

# Accorder Lecture/Écriture à Compta et Commerce
$RightsReadWrite = "GenericRead,GenericWrite"

Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c dsacls `"$OUGroupCompta`" /G `"$GroupeCompta`":$RightsReadWrite"
Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c dsacls `"$OUGroupCommerce`" /G `"$GroupeCommerce`":$RightsReadWrite"

# Accorder Contrôle total à Service_info
$RightsFullControl = "GA"

Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c dsacls `"$OUGroupServiceInfo`" /G `"$GroupeServiceInfo`":$RightsFullControl"

Write-Host "Création des groupes et attribution des permissions terminées avec succès."
