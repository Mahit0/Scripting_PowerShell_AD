<#
    .Description
    Crée le 13/12/2025
    Permet l'activation / la désactivation d'un compte utilisateur 
    Fait par Alexis , Mathéo , Yanis
#>


Write-Host "--------------Activation / Désactivation-------------" -ForegroundColor Red
Write-Host "1. Activation d'un compte utilisateur(prénom nom)" -ForegroundColor Red
Write-Host "2. Désactivation d'un compte utilisateur" -ForegroundColor Red
Write-Host "-----------------------------------------------------" -ForegroundColor Red

#Choix du menu 
$choix=Read-Host "Veuillez faire un choix 1 ou 2"



Switch($choix) {

    1 {
        #Saisie du nom d'utilisateur 
        $user= Read-Host "saisir un nom d'utilisateur"

        #Vérification si le compte user existe dans l'AD
        $aduser= Get-ADUser -f "sAMAccountName -eq '$user'"

        #Si le compte existe Active le compte
    if ($aduser -ne $null) {
        Enable-AdAccount -identity $user -Confirm 
        
        #Vérification du statut après opération
        if ($(get-aduser $user).enabled -eq $true) {
            Write-Host "compte activé"
        } else {
            Write-Host "echec"
        }
    } else {
        Write-Host "le compte n'existe pas"
            }
}

2 {

    #Saisie du nom d'utilisateur 
    $user= Read-Host "saisir un nom d'utilisateur"

    #Vérification si le compte user existe dans l'AD
    $aduser= Get-ADUser -f "sAMAccountName -eq '$user'"

    #Si le compte existe désactive le compte
    if ($aduser -ne $null) {
    Disable-AdAccount -identity $user -Confirm 

        #Vérification du statut après opération
        if ($(get-aduser $user).enabled -eq $false) {
            Write-Host "compte désactivé"
        } else {
            Write-Host "echec"
    }
   }else {
    Write-Host "le compte n'existe pas"
        }
}















}
