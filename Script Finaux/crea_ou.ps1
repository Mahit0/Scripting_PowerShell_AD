Write-host "Menu OU" -ForegroundColor Green

Write-host "1. Création d'OU" -ForegroundColor Green
Write-host "2. Renommer un OU" -ForegroundColor Green
Write-host "3. Description de l'OU" -ForegroundColor Green
Write-host "4. Suppression de l'OU" -ForegroundColor Green
Write-host "-------------------------" -ForegroundColor Green


$choix = Read-Host "Choisissez une option"
switch($choix) {
	1 {
	$nom = Read-Host "Entrez le nom de votre OU"
		do {
		New-ADOrganizationalUnit -Name "$nom" -Path "OU=DC=LAB,DC=INTRA"
		then
		Read-Host "Nom Incorrect"
		}
	}
	2 {
	$nom = Read-Host "Entrez le nom de votre OU"
	$newnom = Read-Host "Entrez le nouveau nom de votre OU"
		do {
		Rename-ADObject -Identity "OU=$nom,OU=IT,DC=enterprise,DC=COM" -NewName $newnom
		then
		Read-Host "Nom Incorrect"
		}
	}

	4 {
	$nom = Read-Host "Entrez le nom de votre OU"
		do {
		Get-ADOrganizationalUnit -filter "Name -eq "$nom" | Set-ADOrganizationalUnit  -ProtectedFromAccidentalDeletion $False
		then
		Read-Host "Nom Incorrect"
		}
	}
}
