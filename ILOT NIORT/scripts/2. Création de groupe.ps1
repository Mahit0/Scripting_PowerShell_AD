# Variables
$nom = Read-Host "NomDuGroupe"
$type = Read-Host "Sécurité ou Distribution"

# Création / Automatisation
New-ADGroup -Name $nom -GroupScope $type

# Nettoyage + Retour Menu
clear-host
.\Menu.ps1