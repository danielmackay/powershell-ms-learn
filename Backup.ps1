Param(
    [string]$Path = './app',
    [string]$DestinationPath = './',
    [switch]$PathIsWebApp
)

if ($PathIsWebApp -eq $true) {
    try {
        $containesApplicationFiles = "$((Get-ChildItem $Path).Extension | Sort-Object -Unique)" -match '\.js|\.html|\.css'

        If (-Not $containesApplicationFiles){
            throw "Not a web app"
        } else {
            Write-Host "Source files look good, continuing"
        }
    } catch {
        throw "No backup created due to: $($_.Exception.Message)"
    }
}

if (-Not (Test-Path $Path)) {
    throw "The source directory $Path does not exist, please specify an existing directory"
}

$date = Get-Date -Format 'yyyy-MM-dd'
$destinationFile = "$($DestinationPath + 'backup-' + $date + '.zip')"

if (-Not (Test-Path $destinationFile)) {
    Compress-Archive -Path $Path -CompressionLevel Fastest -DestinationPath "$($DestinationPath + 'backup-' + $date)"
    Write-Host "Created backup at $destinationFile"
}
else {
    Write-Error "Today's backup already exists"
}