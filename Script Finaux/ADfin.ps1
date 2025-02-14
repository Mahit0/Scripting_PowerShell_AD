# Importer le module ActiveDirectory si ce n'est pas déjà fait
Import-Module ActiveDirectory

$fullName = ""
$userName = ""
$password = ""
$choix = ""
$validation = $false

# Message de bienvenue
Write-Host "Bienvenue dans l'éditeur des Utilisateurs AD"
Write-Output ""
Write-Host "Voici les actions disponibles :"
Write-Output ""
Write-Host "1: Création d'utilisateur"
Write-Host "2: Modification de mot de passe"
Write-Host "3: Déplacement d'utilisateur"
Write-Output ""

# Demander l'action voulue
$choix = Read-Host "Quelle action voulez-vous faire "
echo ""

if ($choix -match "^[1-3]$") {
    switch ($choix) {
        1 {
            # Demander à l'utilisateur les informations nécessaires
            $fullName = Read-Host "Entrez le nom d'affichage de l'utilisateur"
            # Créé une boucle qui demande le nom d'utilisateur s'il n'est pas valide
            do {
                $userName = Read-Host "Entrez le nom d'utilisateur (login)"
                # Tenter de récupérer l'utilisateur dans Active Directory
                try {
                    $user = Get-ADUser -Identity $userName -ErrorAction Stop
                    Write-Host "L'utilisateur $userName existe déjà dans Active Directory."
                    $validation = $false
                } catch {
                    $validation = $true 
				}
					
            } while ($validation -ne $true)
			
					do {
						# les critères de complexité
						function Verif-mdp {
							param ([string]$MDP)
							
							# Critères de validation :
							$LongueurMin = 8
							$ContientMajuscule = $MDP -cmatch "[A-Z]"
							$ContientMinuscule = $MDP -cmatch "[a-z]"
							$ContientChiffre = $MDP-match "\d"

							if ($MDP.Length -ge $LongueurMin -and $ContientMajuscule -and $ContientMinuscule -and $ContientChiffre) {
								return $true
							} else {
								return $false
							}
						}

						# Demander un mot de passe tant qu'il n'est pas valide


						$MDPsecure = Read-Host "Veuillez saisir le mot de passe de l'utilisateur (min: 8 caracteres, 1 majuscule, 1 minuscule, 1 chiffre)" -AsSecureString
						
						# Convertir le SecureString en texte clair (obligatoire pour valider la vérification de complexité)
						$MDPclair = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($MDPsecure))

						if (-not (Verif-mdp $MDPclair)) {
							Write-Host "Mot de passe non valide. Veuillez essayer à nouveau." -ForegroundColor Red
						} Else {
							# Créer l'utilisateur dans Active Directory
							New-ADUser -Name $fullName `
								-SamAccountName $userName `
								-UserPrincipalName "$userName@ad01.lcl" `
								-Path "CN=Users,DC=ad01,DC=lcl" `
								-AccountPassword $MDPsecure `
								-Enabled $true `
								-PassThru
							Write-Host "L'utilisateur $fullName a ete cree avec succes." -ForegroundColor Green
						}
					} while (-not (Verif-mdp $MDPclair))
					
					
                
        }
		
		
        2 {
            do {
				#Demande le login
                $userName = Read-Host "Entrez le nom d'utilisateur (login) de l'utilisateur dont vous modifiez le Mot de passe"
                # Tenter de récupérer l'utilisateur dans Active Directory
                try {
                    $user = Get-ADUser -Identity $userName -ErrorAction Stop
                    $validation = $true
                } catch {
                    $validation = $false 
					Write-Host "L'utilisateur $userName n'existe pas dans Active Directory."
				}
					
            } while ($validation -ne $true)
			
					do {
						# les critères de complexité
						function Verif-mdp {
							param ([string]$MDP)
							
							# Critères de validation :
							$LongueurMin = 8
							$ContientMajuscule = $MDP -cmatch "[A-Z]"
							$ContientMinuscule = $MDP -cmatch "[a-z]"
							$ContientChiffre = $MDP-match "\d"

							if ($MDP.Length -ge $LongueurMin -and $ContientMajuscule -and $ContientMinuscule -and $ContientChiffre) {
								return $true
							} else {
								return $false
							}
						}

						# Demander un mot de passe tant qu'il n'est pas valide


						$MDPsecure = Read-Host "Veuillez saisir le nouveau mot de passe de l'utilisateur (min: 8 caracteres, 1 majuscule, 1 minuscule, 1 chiffre)" -AsSecureString
						
						# Convertir le SecureString en texte clair (obligatoire pour valider la vérification de complexité)
						$MDPclair = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto([System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($MDPsecure))

						if (-not (Verif-mdp $MDPclair)) {
							Write-Host "Mot de passe non valide. Veuillez essayer à nouveau." -ForegroundColor Red
						} Else {
							# Change le mdp de l'utilisateur dans Active Directory
							Set-ADAccountPassword -Identity "$username" -NewPassword (ConvertTo-SecureString "$MDPsecure" -AsPlainText -Force) -Reset
							write-Host "Le mot de passe de l'utilisateur a ete change avec succes"-ForegroundColor Green
						}
					} while (-not (Verif-mdp $MDPclair))
					
					
                
		}
        
		
		
		
		
		
		
		
        3 {
			# Fonction pour corriger l'affichage des OU
			function ConvertTo-OUPath($dn) {
				return ($dn -replace ",DC=.*", "") -replace "OU=", "" -replace ",", "/"
			}

			# Afficher les OU disponibles
			Write-Host "Liste des Unités d'Organisation disponibles dans Active Directory :"
			$ouList = Get-ADOrganizationalUnit -Filter * | Sort-Object DistinguishedName

			# Création d'un tableau pour stocker les OU
			$ouDictionary = @{}
			$index = 1

			foreach ($ou in $ouList) {
				$formattedOU = ConvertTo-OUPath $ou.DistinguishedName
				$ouDictionary[$index] = $ou.DistinguishedName
				Write-Host "$index : $formattedOU"
				$index++
			}

			do {
				# Demander à l'utilisateur de choisir une OU cible par son numéro
				$ouChoice = Read-Host "Entrez le numero de l'OU cible"
				$validationOU = $true
				# Vérifier si le choix est valide
				if (-not $ouDictionary.ContainsKey([int]$ouChoice)) {
					Write-Host "Choix invalide. Vérifiez le numéro et réessayez."
					$validationOU = $false
					exit
				}
			} while ($validationOU -eq $false)
				
				# Récupérer le Distinguished Name correspondant
				$targetOU = $ouDictionary[[int]$ouChoice]
			do {
				# Demander le nom d'utilisateur à déplacer
				$userName = Read-Host "Entrez le nom d'utilisateur (sAMAccountName) à déplacer"

				# Vérifier si l'utilisateur existe
				try {
					$user = Get-ADUser -Identity $userName -ErrorAction Stop
					
					# Déplacer l'utilisateur vers la nouvelle OU
					Move-ADObject -Identity $user.DistinguishedName -TargetPath $targetOU
					Write-Host "L'utilisateur $userName a été déplacé avec succès vers $targetOU."
					$validationOUuser = $true
				} catch {
					Write-Host "Erreur : L'utilisateur $userName n'existe pas ou une erreur est survenue."
					$validationOUuser = $false
				}
			} while ($validationOUuser -eq $false)
        }
	}
	}





























