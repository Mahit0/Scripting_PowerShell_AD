<#
.NOTES
  Version:        1.0
  Author:         <Phoebe La GOAT>
  Creation Date:  <13/02/2025>
  Purpose/Change: Ajouter / Retirer un membre d'un groupe

.Description
Ce script permet de rajouter ou de retirer un utilisateur d'un groupe
.SYNOPSIS
Ajout/retrait membre groupe

#>

##Création de la fonction pour le rajout au groupe##
function Add_User_Group {
    #Demande d'input utilisatur pour l'utilisateur et le groupe souhaité
    $USER_TO_ADD = Read-Host "Merci d'entrer l'utilisateur concerné"
    $GRP_TO_ADD=Read-host "Merci d'entrer le groupe souhaité"
    #Utilisation de try avant de faire la commande, pour vérifier si ça renvoie une erreur ou non
    try {
        Add-ADGroupMember $GRP_TO_ADD $USER_TO_ADD -ErrorAction Stop
        Write-Host "L'utilisateur $USER_TO_ADD a bien été ajouté au groupe $GRP_TO_ADD" -ForegroundColor Green
    }
    catch {
        Write-Host "Cela n'a pas fonctionné à mon grand damn" -ForegroundColor Red
    }
    #Demande si l'utilisateur souhaite revenir au menu pour effectuer d'autres actions
    Write-Host "Voulez-vous effectuez d'autres actions?"
    Write-Host "1) Oui"
    Write-Host "2) Non"
    $choice = Read-Host -prompt "Faites votre choix" 
        switch ($choice){
        1 { return}
        2 { exit }
    }
    #On nettoie derrière soi car on est pas des sagouins
    clear-host
}
##Création de la fonction pour la supression d'un utilisateur d'un groupe##
function Remove_User_Group {
    #Demande d'input utilisatur pour l'utilisateur et le groupe souhaité
    $USER_TO_RM = Read-Host "Merci d'entrer l'utilisateur concerné"
    $GRP_TO_RM=Read-host "Merci d'entrer le groupe souhaité"
    #Utilisation de try avant de faire la commande, pour vérifier si ça renvoie une erreur ou non
    try {
        Remove-ADGroupMember $GRP_TO_RM $USER_TO_RM -ErrorAction Stop
        Write-Host "L'utilisateur $USER_TO_RM a bien été supprimé du groupe $GRP_TO_RM" -ForegroundColor Green
    }
    catch {
        Write-Host "Cela n'a pas fonctionné à mon grand damn" -ForegroundColor Red
    }
    #Demande si l'utilisateur souhaite revenir au menu pour effectuer d'autres actions
    Write-Host "Voulez-vous effectuez d'autres actions?"
    Write-Host "1) Oui"
    Write-Host "2) Non"
    $choice = Read-Host -prompt "Faites votre choix" 
        switch ($choice){
        1 { return}
        2 { exit }
    }
    #On nettoie derrière soi car on est pas des sagouins
    clear-host
}

##Menu principal où un choix est demandé##
do {
    #Rédaction du menu avec les options
Write-Host "Bienvenu(e) dans ce script vous permettant d'ajouter / d'enlever des utilisateurs des groupes"
Write-Host "1) Ajouter un utilisateur à un groupe"
Write-Host "2) Retirer un utilisateur d'un groupe"
Write-Host "q) Quitter"
    #Selon le choix, l'action a réaliser change
$choix = Read-Host -prompt "Faites votre choix" 
    switch ($choix){
        1 { Add_User_Group }
        2 { Remove_User_Group }
        q {exit}
    }
    #On nettoie
    clear-host
} while ($true)