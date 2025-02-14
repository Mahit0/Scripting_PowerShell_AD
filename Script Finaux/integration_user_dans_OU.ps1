# Récupération du DN du domaine Active Directory
$DomainDN = (Get-ADDomain).DistinguishedName
$MainOUPath = "OU=AD_01,$DomainDN"
$GroupeOUPath = "OU=Groupe,$MainOUPath"

# Liste des services
$Services = @("Compta", "Commerc", "Service_info")

# Création des groupes dans chaque sous-OU Groupe
foreach ($Service in $Services) {
    $GroupName = "GRP_$Service"
    $GroupPath = "OU=$Service,$GroupeOUPath"

    if (-not (Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue)) {
        New-ADGroup -Name $GroupName -GroupScope Global -Path $GroupPath -PassThru
        Write-Host "Groupe '$GroupName' créé sous '$GroupPath'."
    } else {
        Write-Host "Groupe '$GroupName' existe déjà sous '$GroupPath'."
    }
}

# Définition des permissions
$GroupeCompta = "GRP_Compta"
$GroupeCommerc = "GRP_Commerc"
$GroupeServiceInfo = "GRP_Service_info"

$OUGroupCompta = "OU=Compta,OU=Groupe,$MainOUPath"
$OUGroupCommerc = "OU=Commerc,OU=Groupe,$MainOUPath"
$OUGroupServiceInfo = "OU=Service_info,OU=Groupe,$MainOUPath"

# Accorder Lecture/Écriture à Compta et Commerc
$RightsReadWrite = "GenericRead,GenericWrite"

Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c dsacls `"$OUGroupCompta`" /G `"$GroupeCompta`":$RightsReadWrite"
Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c dsacls `"$OUGroupCommerc`" /G `"$GroupeCommerc`":$RightsReadWrite"

# Accorder Contrôle total à Service_info
$RightsFullControl = "GA"

Start-Process -NoNewWindow -FilePath "cmd.exe" -ArgumentList "/c dsacls `"$OUGroupServiceInfo`" /G `"$GroupeServiceInfo`":$RightsFullControl"

Write-Host "Création des groupes et attribution des permissions terminées avec succès."
