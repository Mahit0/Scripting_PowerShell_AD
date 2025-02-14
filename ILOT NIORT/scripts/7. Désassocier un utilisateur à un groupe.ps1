# Nom de l'utilisateur
$utilisateur = Read-Host "Entrez le nom d'utilisateur"

# Nom du groupe
$groupe = Read-Host "Quel est le nom du groupe auquel l'utilisateur souhaite être dissocier ?"

# Commande Final
Remove-ADGroupMember -Identity $groupe -Members $utilisateur

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1