
# Script de fou furieux sur l'AD

##Fonction de Menu principal où un choix est demandé##
function Func_AddOrRemoveGroupMember{
    do {
    #Rédaction du menu avec les options
    Write-Host "Bienvenu(e) dans ce script vous permettant d'ajouter / d'enlever des utilisateurs des groupes"
    Write-Host "1) Ajouter un utilisateur à un groupe"
    Write-Host "2) Retirer un utilisateur d'un groupe"
    Write-Host "b) Retourner au menu principal"
    #Selon le choix, l'action a réaliser change
    $choix = Read-Host -prompt "Faites votre choix" 
        switch ($choix){
        1 { Add_User_Group }
        2 { Remove_User_Group }
        b {return}
    }
    #On nettoie
    clear-host
} while ($true)
}

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
        1 { return }
        2 { return }
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
        2 { Func_MainMenu }
    }
    #On nettoie derrière soi car on est pas des sagouins
    clear-host
}

#fonction pour connaitre les informations d'un ou plusieurs ordinateurs
function func_computer_information {
    $computer = Read-Host "Entrez le nom de l'ordinateur"
    Get-ADComputer -Filter "name -like '*$computer*'" -Properties * | Select-Object DistinguishedName, Name, Description, IPV4Address | Format-List
    Pause
    Func_PC
}

#fonction pour supprimer un ordinateur
function func_computer_remove {
    $computer = Read-Host "Entrez le nom de l'ordinateur"
    $test_computer_exist= Get-ADComputer -Identity $computer -ErrorAction SilentlyContinue # variable de test pour savoir si l'ordinateur existe
    if (-not ($test_computer_exist)){# si aucun ordinateur trouvé avec ce nom
        Write-Host -foregroundcolor yellow "L'ordinateur n'existe pas"
        Pause
        func_submenu_computer #reviens au sous menu ordinateur
    }
    Remove-ADComputer -Identity $computer 
    Pause
    Func_PC
}

# Fonction pour sous-menu PC
function Func_PC {
    clear-host
    Write-Host "1) Informations sur les ordinateurs"
    Write-Host "2) Déplacer un ordinateur"
    Write-Host "3) Supprimer un ordinateur"
    Write-Host "b) Retourner au Menu Principal "
    do {
        $choixGRP = Read-Host "Faites votre choix"
        switch ($choixGRP) {
            1 {func_computer_information}
            2 { }
            3 {func_computer_remove}
            b { return }
        }
    } while ($true)
}

# Fonction pour sous-menu groupe
function Func_GRP {
    clear-host
    Write-Host "1) Info sur les groupes"
    Write-Host "2) Création de groupe"
    Write-Host "3) Ajout/retrait d'un groupe"
    Write-Host "b) Retourner au Menu Principal "
    do {
        $choixGRP = Read-Host "Faites votre choix"
        switch ($choixGRP) {
            1 { ./info_groupe.ps1 }
            2 {
            ./creation_groupe.ps1
            }
            3 { Func_AddOrRemoveGroupMember }
            b { return }
        }
    } while ($true)
}

# Fonction pour sous-menu User
function Func_User {
    clear-host
    Write-Host "1) Création d'utilisateur"
    Write-Host "2) Modification du mot de passe"
    Write-Host "3) Déplacer un utilisateur"
    Write-Host "4) Verrouillage et déverouilage d'un compte"
    Write-Host "5) Information utilisateur"
    Write-Host "b) Retourner au Menu Principal "
    do {
        $choixUser = Read-Host "Faites votre choix"
        switch ($choixUser) {
            1 {  #NewADUser

$UserNom = Read-Host "Renseignez le nom du nouvel utilisateur"
$UserPrenom = Read-Host "Renseignez le prénom du nouvel utilisateur"
$UserLogin = Read-Host "login"
$UserPass = Read-Host "Mot de passe" -AsSecureString
$VerifPass = Read-Host "Rentrez à nouveau le mot de passe" -AsSecureString

if ($UserPass -like $VerifPass) {
    New-ADUser -Name "$UserNom $UserPrenom" -GivenName $UserPrenom -accountpassword $VerifPass -SamAccountName $UserLogin
}
else {
    Write-Host "Erreur de saisie"
}
            }
            2 {  #ChangePass

                    $LoginUser = Read-Host "Renseigner le login exact de l'utilisateur"
                    $UserPass = Read-Host "Mot de passe" -AsSecureString
                    $VerifPass = Read-Host "Rentrez à nouveau le mot de passe" -AsSecureString
                    if ($UserPass -like $VerifPass) {
                            Set-ADAccountPassword -Identity $LoginUser -NewPassword $VerifPass
                            Write-Host "Le mot de passe a été changé avec succès"
                    }
                    Else {
                            Write-Host "Erreur de saisie"
                    } }
            3 { }
            4 { ./activation-desactivation-user.ps1 }
            5 { ./infos_user.ps1 }
            b { return }
        }
    } while ($true)   
}

# Menu Principal
function Func_MainMenu {
do {
    clear-host
    Write-Host "Bienvenue sur ce script de gestion de l'AD" -ForegroundColor Green
    Write-Host "1) Gestion utilisateur"
    Write-Host "2) Gestion des ordinateurs"
    Write-Host "3) Gestion des groupes"
    Write-Host "q) Bah quitter sale fou"
    Write-Host ""
    $choix = Read-Host "Faites votre choix"
switch ($choix) {
    1 { Func_User }
    2 { Func_PC }
    3 { Func_GRP }
    q { exit }
}
}while ($true)
}

Func_MainMenu
