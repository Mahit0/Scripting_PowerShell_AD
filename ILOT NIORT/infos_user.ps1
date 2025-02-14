#########################################
# Author : Mattéo AUBRY                 #
# Name : .\Info_user.ps1                #
# Date : 14/02/2025                     #
# Version : 1.0                         #
#########################################

Import-Module ActiveDirectory

$username = Read-Host "Veuillez saisir le nom d'utilisateur sur lequel vous voulez des infos "

Write-Host "--------------Infos dispo pour $username-------------------" -ForegroundColor DarkGray
Write-Host "1. Afficher la derniere connexion de l'utilisateur" -ForegroundColor DarkGray
Write-Host "2. Localisation de l'utilisateur dans l'AD" -ForegroundColor DarkGray
Write-host "3. Affichage du nom complet de la personne" -ForegroundColor DarkGray
Write-Host "4. Affichage des groupes de l'utilisateur" -ForegroundColor DarkGray
Write-Host "----------------------------------------------------------" -ForegroundColor DarkGray
$choix = Read-Host "Veuillez choisir une info parmis ceux qui sont proposer ci-dessus"

switch ($choix) {
    1 {
        Write-Host "Voici la dernière connexion de $username" -ForegroundColor Green
        #Affiche la dernière connexion + dernière ligne du resultat 
        Get-ADUser -filter "SamAccountName -eq '$username'" -properties * | Select-Object whenChanged 
    }
    2 {
        Write-Host "Voici la localisation de $username dans l'AD" -ForegroundColor Green
        #Affiche la localisation de l'utilisateur dans l'AD
        Get-ADUser -filter "SamAccountName -eq '$username'" -properties * | Select-Object DistinguishedName
    }
    3 {
        Write-Host "Voici le nom complet de $username" -ForegroundColor Green
        #Affiche le nom complet de l'utilisateur dans l'AD 
        Get-ADUser -filter "SamAccountName -eq '$username'" | Select-Object Name 
    }
    4 {
        Write-Host "Voicis les groupes dont $username fait partie" -ForegroundColor Green
        #Affiche les groupes dont l'utilisateur fait partie
        Get-ADUser -filter "SamAccountName -eq '$username'" -properties MemberOf | Select-Object -ExpandProperty MemberOf | ForEach-Object {
            ($_ -split ',')[0] -replace '^CN='
        }
    }
}