# Suppression de l'OU
$OUPath = Read-host "Entrez le nom de l'OU"

# Supprime l'OU
Remove-ADOrganizationalUnit -Identity $OUPath -Confirm:$false

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1