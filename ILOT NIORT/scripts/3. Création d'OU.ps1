# Variable
$nom = Read-Host "Entrez le nom de l'OU"

# Créer l'OU
New-ADOrganizationalUnit -Name $nom

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1
