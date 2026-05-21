$files = Get-ChildItem -Path lib -Recurse -Filter "*.dart"
Write-Host "Nombre de fichiers trouvés: $($files.Count)"
foreach ($file in $files) {
    $content = Get-Content $file.FullName -Raw
    $utf8 = New-Object System.Text.UTF8Encoding $false
    [System.IO.File]::WriteAllText($file.FullName, $content, $utf8)
    Write-Host "Converti: $($file.Name)"
}
