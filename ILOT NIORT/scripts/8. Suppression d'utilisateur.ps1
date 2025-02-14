# Utilisateur
$utilisateur = Read-Host "Nom de l'Utilisateur à supprimer"

# Suppression
Remove-ADUser -Identity $utilisateur -Confirm:$false

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1