# Groupe à supprimer
$groupe = Read-Host "Entrez le nom du groupe à supprimer"

# Commande
Remove-ADGroup -Identity $groupe -Confirm:$false

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1