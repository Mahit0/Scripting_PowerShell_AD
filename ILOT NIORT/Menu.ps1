    #Options
    Write-Host "Menu Active Directory"
    
    Write-Host "1. Cr�ation d'utilisateur"
    Write-Host "2. Cr�ation de groupe"
    Write-Host "3. Cr�ation d'OU"
    Write-Host "4. Description d'un groupe"
    Write-Host "5. Associer un utilisateur � un groupe"
    Write-Host "6. Modifier le Mot de Passe d'un utilisateur"
    Write-Host "7. D�sassocier un utilisateur � un groupe"
    Write-Host "8. Suppression d'utilisateur"
    Write-Host "9. Supression de groupe"
    Write-Host "10. Suppression d'OU"

    #Choix
    $choix = Read-Host "Tapez le num�ro de l'option" 
        switch ($choix){
        1 { .\scripts\1. Cr�ation d'utilisateur.ps1 }
        2 { .\scripts\2. Cr�ation de groupe.ps1 }
        3 { .\scripts\3. Cr�ation d'OU.ps1 }
        4 { .\scripts\4. Description d'un groupe.ps1 }
        5 { .\scripts\5. Associer un utilisateur � un groupe.ps1 }
        6 { .\scripts\6. Modifier le Mot de Passe d'un utilisateur.ps1 }
        7 { .\scripts\7. D�sassocier un utilisateur � un groupe.ps1 }
        8 { .\scripts\8. Suppression d'utilisateur.ps1 }
        9 { .\scripts\9. Supression de groupe.ps1 }
       10 { .\scripts\10. Suppression d'OU.ps1 }
    }
    #Netoyage
    clear-host