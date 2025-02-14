# Variables
$username = Read-Host "Entrez le nom d'utilisateur"
$password = Read-Host "Entrez le mot de passe"
$fullname = "Entrez Nom et Prénom"

# Automatisation / Création
New-ADUser -Name $username -AccountPassword $password -GivenName $fullname -Enabled $true
