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
