# Demande à l'utilisateur quel type de groupe il veut consulter
Write-Host "Quels type de groupe voulez-vous consulter ?"
Write-Host "1: groupe global"
Write-Host "2: groupe domaine local"
Write-Host "3: groupe universel"

# Boucle jusqu'à ce que l'utilisateur entre une valeur valide (1, 2 ou 3)
do {
    $type = Read-Host "Entrez 1, 2 ou 3"
} while ($type -notmatch "^[1-3]$")  # Vérifie que l'entrée est valide (1, 2 ou 3)

$infoGroupe = $null

# Affiche les groupes selon le type sélectionné
switch ($type) {
    "1" { 
        Write-Host "Groupes globaux :"
        Get-ADGroup -filter 'GroupScope -eq "Global"' | Select-Object -ExpandProperty Name
    }
    "2" { 
        Write-Host "Groupes de domaine local :"
        Get-ADGroup -filter 'GroupScope -eq "DomainLocal"' | Select-Object -ExpandProperty Name
    }
    "3" { 
        Write-Host "Groupes universels :"
        Get-ADGroup -filter 'GroupScope -eq "Universal"' | Select-Object -ExpandProperty Name
    }
}

# Demande tant que $infoGroupe est null
while ($null -eq $infoGroupe) {
    # Sélectionne le groupe en fonction du type choisi
    $groupeSelectionne = Read-Host "Veuillez saisir le nom du groupe à consulter" 
    $infoGroupe = Get-ADGroup -Identity $groupeSelectionne -Properties Member, Memberof, whencreated, whenchanged, description -ErrorAction SilentlyContinue

    # Si le groupe n'est pas trouvé, demande à l'utilisateur de réessayer
    if ($null -eq $infoGroupe) {
        Write-Host "Le groupe '$groupeSelectionne' n'a pas ete trouve dans Active Directory. Essayez a nouveau."
    }
}

# Affichage des informations du groupe
Write-Host "Informations du groupe : $groupeSelectionne" 
Write-Host "Description du groupe : $($infoGroupe.description)"
Write-Host "Date de creation du groupe : $($infoGroupe.whencreated)"
Write-Host "Dernière modification du groupe : $($infoGroupe.whenchanged)"

# Affichage des membres du groupe
Write-Host "Membres du groupe :" 
if ($infoGroupe.Member.Count -gt 0) {
    $infoGroupe.Member | ForEach-Object { 
        $membreNom = (Get-ADObject -Identity $_ -Properties Name).Name
        Write-Host "- $membreNom"
    }
} else {
    Write-Host "Aucun membre trouve." 
}

# Affichage des groupes dont il est membre
Write-Host "Groupes dont $groupeSelectionne est membre :" 
if ($infoGroupe.MemberOf.Count -gt 0) {
    $infoGroupe.MemberOf | ForEach-Object {
        $groupeParent = (Get-ADGroup -Identity $_ -Properties Name).Name
        Write-Host "- $groupeParent"
    }
} else {
    Write-Host "Ce groupe n'est membre d'aucun autre groupe." 
}
