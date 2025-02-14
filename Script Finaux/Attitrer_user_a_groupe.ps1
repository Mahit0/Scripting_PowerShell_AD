# Demander le nom de l'utilisateur et du groupe
$UserName = Read-Host "Entrez le nom de l'utilisateur (sAMAccountName)"
$GroupName = Read-Host "Entrez le nom du groupe (ex: GRP_Compta)"

# Vérifier si l'utilisateur existe
$User = Get-ADUser -Filter "sAMAccountName -eq '$UserName'" -ErrorAction SilentlyContinue
if (-not $User) {
    Write-Host " L'utilisateur '$UserName' n'existe pas !" -ForegroundColor Red
    exit
}

# Vérifier si le groupe existe
$Group = Get-ADGroup -Filter "Name -eq '$GroupName'" -ErrorAction SilentlyContinue
if (-not $Group) {
    Write-Host " Le groupe '$GroupName' n'existe pas !" -ForegroundColor Red
    exit
}

# Ajouter l'utilisateur au groupe
Add-ADGroupMember -Identity $GroupName -Members $UserName

Write-Host " L'utilisateur '$UserName' a été ajouté au groupe '$GroupName' avec succès !" -ForegroundColor Green
