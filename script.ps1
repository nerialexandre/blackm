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

# Obtém automaticamente o nome do arquivo da URL
$nomeArquivo = Split-Path $url -Leaf

# Caminho final do arquivo
$arquivo = Join-Path $destino $nomeArquivo

# Faz o download
Invoke-WebRequest -Uri $url -OutFile $arquivo

Write-Host ""
Write-Host "Concluído!"
Write-Host "Arquivo salvo em:"
Write-Host $arquivo