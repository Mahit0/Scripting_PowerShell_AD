<#
.Synopsis
Auteur : Yanis Morizot 
Date : 13/02/2025 
usage : Deverrouiller un compte et reinitialiser un MDP
.Description
yolo
#>

#Demander a l'utilisateur le nom du compte à deverrouiller : 
$UserName=read-host "Veuillez entrer le SAMAccountName (PrenomNom) du compte a deverouiller"

#verifier si le compte existe :  
$aduser = Get-ADUser -f "sAMAccountName -eq '$UserName'"
if ($aduser -ne $null) {
    Write-Host "Le compte existe"

    #Deverrouiller le compte :
    Unlock-ADAccount $UserName 
    "Compte Deverrouillé"

    #Demander à l'utilisateur si il souhaite réinitialiser le MDP du compte : 
    $choix=Read-Host "souhaitez-vous réinitialiser le MDP de l'utilisateur ? oui/non"

    if ($choix -eq "oui") {

        #MDP temporaire defini dans une variable
        $Pwd = ConvertTo-SecureString "M0tDeP@sse" -AsPlainText

        #Reinitialiser le MDP avec cette variable
        Set-ADAccountPassword $UserName -NewPassword $Pwd -Reset

        #Obliger l'utilisateur a changer son MDP a la prochaine connexion
        Set-ADuser $UserName -ChangePasswordAtLogon $True

        #Retour visuel 
        "MDP Reinitialisé"
        "MDP Temporaire : M0tDeP@sse"
        "Travail Terminé"
    }
    else { "Travail Terminé"}

} else {
    Write-Host "le compte n'existe pas"
}
  

