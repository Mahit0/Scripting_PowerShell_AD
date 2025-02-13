# Récupération du DN du domaine Active Directory
$DomainDN = (Get-ADDomain).DistinguishedName

# Création de l'OU principale AD_01 si elle n'existe pas
$MainOU = "AD_01"
$MainOUPath = "OU=$MainOU,$DomainDN"

if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$MainOUPath'" -ErrorAction SilentlyContinue)) {
    New-ADOrganizationalUnit -Name $MainOU -Path $DomainDN -ProtectedFromAccidentalDeletion $true
    Write-Host "OU '$MainOU' créée."
} else {
    Write-Host "OU '$MainOU' existe déjà."
}

# Création des OU secondaires sous AD_01 si elles n'existent pas
$OUPaths = @("Utilisateurs", "Groupe", "Ordinateur", "Archive")

foreach ($OU in $OUPaths) {
    $OUPath = "OU=$OU,$MainOUPath"
    if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$OUPath'" -ErrorAction SilentlyContinue)) {
        New-ADOrganizationalUnit -Name $OU -Path $MainOUPath -ProtectedFromAccidentalDeletion $true
        Write-Host "OU '$OU' créée sous '$MainOU'."
    } else {
        Write-Host "OU '$OU' existe déjà."
    }
}

# Création des sous-OU pour chaque service dans chaque OU secondaire
$Services = @("Compta", "Commerc", "Service_info")

foreach ($OU in $OUPaths) {
    foreach ($Service in $Services) {
        $SubOUPath = "OU=$Service,OU=$OU,$MainOUPath"
        if (-not (Get-ADOrganizationalUnit -Filter "DistinguishedName -eq '$SubOUPath'" -ErrorAction SilentlyContinue)) {
            New-ADOrganizationalUnit -Name $Service -Path "OU=$OU,$MainOUPath" -ProtectedFromAccidentalDeletion $true
            Write-Host "Sous-OU '$Service' créée sous '$OU'."
        } else {
            Write-Host "Sous-OU '$Service' existe déjà sous '$OU'."
        }
    }
}

Write-Host "Création des OU terminée avec succès."
