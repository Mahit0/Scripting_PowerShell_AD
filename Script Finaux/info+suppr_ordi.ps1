#fonction pour connaitre les informations d'un ou plusieurs ordinateurs
function func_computer_information {
    do {
    $Menu = Read-Host "Veuillez faire un choix
    1) Afficher la liste de toutes les machines
    2) Recherche par nom
    3)Quit
    "
    switch ($Menu) {
        1 { 
            #Affiche tout les noms d'ordinateur
            Get-ADComputer -Filter * -Properties * | Select-Object name 
         }
        2 {
            do {
                #Affiiche la demande de saisie
                $saisie = Read-Host "Entrer le nom de l'ordinateur rechercher"
                #Verifie si la saisie existe
                $saisieValide = Get-ADComputer -Filter "name -eq '$saisie'"
                if ($saisieValide) {
                    #Affiche les informations nom, date de creation, Description...
                    Get-ADComputer -Filter * -Properties * | Select-Object name, Created, Description, OperatingSystem, LastLogonDate, MemberOf | Where-Object name -eq $saisie
                    break
                }
                else {
                    Write-Host "Ordinateur inexistant" -ForegroundColor red
                    Start-sleep 1
                    continue
                }
            } while ($saisie)
        }
        3 {
            Write-Host "Au revoir"
            Start-Sleep 2
            exit
        }
        Default {
            Write-Host "Erreur de Saisie" -ForegroundColor red
            Start-Sleep 1
        }
    }
} while ($Menu -notmatch '^[1-3]')
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
