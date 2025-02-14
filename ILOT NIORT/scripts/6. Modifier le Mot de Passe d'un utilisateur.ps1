# Utilisateur
$username = Read-Host "Entrez le nom d'utilisateur"

# Nouveau mot de passe
$password = Read-Host "Entrez le nouveau mot de passe"

# Modifier le mot de passe
Set-ADAccountPassword -Identity $username -NewPassword $password -ChangeAtLogon

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1