###################################
# Author : Mattéo AUBRY           #
# Name : .\Création_groupe.ps1    #
# Date : 13/02/2025               #
# Version : 1.0                   #
###################################

# Importe le module Active Directory
Import-Module ActiveDirectory

# Demande le nom du groupe qui souhaite être créé
$group_name = Read-Host "Veuillez entrer le nom du groupe que vous souhaitez créer"

# Vérifie si le groupe existe déjà
$group_verif = Get-ADGroup -Filter "SamAccountName -eq '$group_name'"

# Si le groupe existe, affiche un message d'erreur
if ($group_verif) {
    Write-Host "Le groupe $group_name existe déjà :/" -ForegroundColor Red
} else {
    # Sinon, demande à l'utilisateur de choisir le scope du groupe
    Write-Host "--------------Choix du Group Scope--------------" -ForegroundColor DarkBlue
    Write-Host "1. Domaine local" -ForegroundColor DarkBlue
    Write-Host "2. Global" -ForegroundColor DarkBlue
    Write-Host "3. Universel" -ForegroundColor DarkBlue
    Write-Host "------------------------------------------------" -ForegroundColor DarkBlue
    $group_scope = Read-Host "Veuillez choisir votre Group Scope"
    $targetOU = "OU=Groupes,OU=_AD01,DC=AD01,DC=lcl"

    # En fonction du choix de l'utilisateur, demande à l'utilisateur de choisir le type du groupe
    switch ($group_scope) {
        1 {
            Write-Host "--------------Choix du Group Type--------------" -ForegroundColor DarkCyan
            Write-Host "1. Groupe de sécurité" -ForegroundColor DarkCyan
            Write-Host "2. Groupe de distribution" -ForegroundColor DarkCyan
            Write-Host "-----------------------------------------------" -ForegroundColor DarkCyan
            $group_type = Read-Host "Veuillez choisir votre Group Type"
            if ($group_type -eq 1) {
                New-ADGroup -Name $group_name -SamAccountName $group_name -GroupCategory Security -GroupScope DomainLocal
                Move-ADObject -Identity (Get-ADGroup -Filter "SamAccountName -eq '$group_name'").DistinguishedName -TargetPath $targetOU
                Write-Host "Le groupe $group_name a bien été créé :). Il est situé dans l'OU suivant $targetOU"
            } else {
                New-ADGroup -Name $group_name -SamAccountName $group_name -GroupCategory Distribution -GroupScope DomainLocal
                Move-ADObject -Identity (Get-ADGroup -Filter "SamAccountName -eq '$group_name'").DistinguishedName -TargetPath $targetOU
                Write-Host "Le groupe $group_name a bien été créé :). Il est situé dans l'OU suivant $targetOU"
            }
        }
        2 {
            Write-Host "--------------Choix du Group Type--------------" -ForegroundColor DarkCyan
            Write-Host "1. Groupe de sécurité" -ForegroundColor DarkCyan
            Write-Host "2. Groupe de distribution" -ForegroundColor DarkCyan
            Write-Host "-----------------------------------------------" -ForegroundColor DarkCyan
            $group_type = Read-Host "Veuillez choisir votre Group Type"
            if ($group_type -eq 1) {
                New-ADGroup -Name $group_name -SamAccountName $group_name -GroupCategory Security -GroupScope Global
                Move-ADObject -Identity (Get-ADGroup -Filter "SamAccountName -eq '$group_name'").DistinguishedName -TargetPath $targetOU
                Write-Host "Le groupe $group_name a bien été créé :). Il est situé dans l'OU suivant $targetOU"
            } else {
                New-ADGroup -Name $group_name -SamAccountName $group_name -GroupCategory Distribution -GroupScope Global
                Move-ADObject -Identity (Get-ADGroup -Filter "SamAccountName -eq '$group_name'").DistinguishedName -TargetPath $targetOU
                Write-Host "Le groupe $group_name a bien été créé :). Il est situé dans l'OU suivant $targetOU"
            }
        }
        3 {
            Write-Host "--------------Choix du Group Type--------------" -ForegroundColor DarkCyan
            Write-Host "1. Groupe de sécurité" -ForegroundColor DarkCyan
            Write-Host "2. Groupe de distribution" -ForegroundColor DarkCyan
            Write-Host "-----------------------------------------------" -ForegroundColor DarkCyan
            $group_type = Read-Host "Veuillez choisir votre Group Type"
            if ($group_type -eq 1) {
                New-ADGroup -Name $group_name -SamAccountName $group_name -GroupCategory Security -GroupScope Universal
                Move-ADObject -Identity (Get-ADGroup -Filter "SamAccountName -eq '$group_name'").DistinguishedName -TargetPath $targetOU
                Write-Host "Le groupe $group_name a bien été créé :). Il est situé dans l'OU suivant $targetOU"
            } else {
                New-ADGroup -Name $group_name -SamAccountName $group_name -GroupCategory Distribution -GroupScope Universal
                Move-ADObject -Identity (Get-ADGroup -Filter "SamAccountName -eq '$group_name'").DistinguishedName -TargetPath $targetOU
                Write-Host "Le groupe $group_name a bien été créé :). Il est situé dans l'OU suivant $targetOU"
            }
        }
        default {
            # Si l'utilisateur ne choisit pas une option valide, affiche un message d'erreur
            Write-Host "EHOOOOOOO on t'a dit 1, 2 ou 3. Fais pas chier et choisis une de ces propositions et rien d'autre 😡!"
        }
    }
}