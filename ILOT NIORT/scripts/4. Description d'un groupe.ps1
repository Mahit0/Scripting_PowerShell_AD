# Recherche du groupe
$Recherche = Read-host "Entrez le nom du groupe"

# Récupérer le groupe
$groupe = Get-ADGroup -Identity $Recherche

# Condition / Description
if ($groupe) {
  Write-Host "Description du groupe '$Recherche': $($groupe.Description)"
} else {
  Write-Host "Groupe '$Recherche' inconnu"
}

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1