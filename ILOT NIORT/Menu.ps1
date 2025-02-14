    #Options
    Write-Host "Menu Active Directory"
    
    Write-Host "1. Création d'utilisateur"
    Write-Host "2. Création de groupe"
    Write-Host "3. Création d'OU"
    Write-Host "4. Description d'un groupe"
    Write-Host "5. Associer un utilisateur à un groupe"
    Write-Host "6. Modifier le Mot de Passe d'un utilisateur"
    Write-Host "7. Désassocier un utilisateur à un groupe"
    Write-Host "8. Suppression d'utilisateur"
    Write-Host "9. Supression de groupe"
    Write-Host "10. Suppression d'OU"

    #Choix
    $choix = Read-Host "Tapez le numéro de l'option" 
        switch ($choix){
        1 { .\scripts\1. Création d'utilisateur.ps1 }
        2 { .\scripts\2. Création de groupe.ps1 }
        3 { .\scripts\3. Création d'OU.ps1 }
        4 { .\scripts\4. Description d'un groupe.ps1 }
        5 { .\scripts\5. Associer un utilisateur à un groupe.ps1 }
        6 { .\scripts\6. Modifier le Mot de Passe d'un utilisateur.ps1 }
        7 { .\scripts\7. Désassocier un utilisateur à un groupe.ps1 }
        8 { .\scripts\8. Suppression d'utilisateur.ps1 }
        9 { .\scripts\9. Supression de groupe.ps1 }
       10 { .\scripts\10. Suppression d'OU.ps1 }
    }
    #Netoyage
    clear-host