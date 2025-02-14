# Variable Utilisateur
$utilisateur = Read-Host "Entrez le nom d'utilisateur"

# Variable Groupe
$groupe = Read-Host "Entrez le nom du groupe à associer"

# Ajouter l'utilisateur au groupe
Add-ADGroupMember -Identity $groupe -Members $utilisateur

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1