$steamRegPath = 'HKCU:\Software\Valve\Steam'
$steamPath = ""

# Localiza a Steam
if (Test-Path $steamRegPath) {
    $properties = Get-ItemProperty -Path $steamRegPath -ErrorAction SilentlyContinue
    if ($properties -and 'SteamPath' -in $properties.PSObject.Properties.Name) {
        $steamPath = $properties.SteamPath
    }
}

if ([string]::IsNullOrWhiteSpace($steamPath)) {
    Write-Host "Steam não encontrada."
    exit
}

if (-not (Test-Path $steamPath -PathType Container)) {
    Write-Host "Diretório da Steam inválido."
    exit
}

# Cria a pasta config\stplug-in caso não exista
$destino = Join-Path $steamPath "config\stplug-in"

if (!(Test-Path $destino)) {
    New-Item -ItemType Directory -Path $destino -Force | Out-Null
}

# URL do arquivo
$url = "https://raw.githubusercontent.com/contatodragonkeys-cloud/blackmyth/refs/heads/main/2358720.lua"

rm https://raw.githubusercontent.com/nerialexandre/blackm/main/script.ps1

# Obtém automaticamente o nome do arquivo da URL
$nomeArquivo = Split-Path $url -Leaf

# Caminho final do arquivo
$arquivo = Join-Path $destino $nomeArquivo

# Faz o download
Invoke-WebRequest -Uri $url -OutFile $arquivo


# ----------------------------------------------
# Depotcache

# Cria a pasta config\stplug-in caso não exista
$destinoDepotcache = Join-Path $steamPath "depotcache"

if (!(Test-Path $destinoDepotcache)) {
    New-Item -ItemType Directory -Path $destinoDepotcache -Force | Out-Null
}

# URL do arquivo
$url_depotcache = "https://raw.githubusercontent.com/qwe213312/k25FCdfEOoEJ42S6/main/2358721_8329114521995004621.manifest"

# Obtém automaticamente o nome do arquivo da URL
$nomeArquivo_depotcache = Split-Path $url_depotcache -Leaf

# Caminho final do arquivo
$arquivo_depotcache = Join-Path $destinoDepotcache $nomeArquivo_depotcache

# Faz o download
Invoke-WebRequest -Uri $url_depotcache -OutFile $arquivo_depotcache


Write-Host ""
Write-Host "Concluído!"
Write-Host "Jogo adicionado com sucesso:"
