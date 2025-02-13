# Script de fou furieux sur l'AD

#fonction pour connaitre les informations d'un ou plusieurs ordinateurs
function func_computer_information {
    $computer = Read-Host "Entrez le nom de l'ordinateur"
    Get-ADComputer -Filter "name -like '*$computer*'" -Properties * | Select-Object DistinguishedName, Name, Description, IPV4Address | Format-List
    Pause
    Func_PC
}

#fonction pour supprimer un ordinateur
function func_computer_remove {
    func_computer_exist
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
            b {return}
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
            1 {  }
            2 { }
            3 { }
            b { return}
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
            1 {  }
            2 { }
            3 { }
            4 { }
            5 { }
            b { return }
        }
    } while ($true)   
}

# Menu Principal
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

