param(
    $KB
)

#$SearchUpdates = @($(dism /online /get-packages) -match "Package_for")
$SearchUpdate = $(dism /online /get-packages) -match "Package_for_KB$KB"
if ($SearchUpdate -and $SearchUpdate -match ":") {
    $packageId = ($SearchUpdate -split ":")[1].Trim()
    Write-Host "Try uninstalling update KB$KB as packageid: $packageId"
    DISM.exe /Online /Remove-Package /PackageName:$packageId /quiet /norestart | Out-String
} else {
    Write-Host "Update KB:$KB seems to be not installed"
    exit 1605 # 1605 is the ms code for not installed
}
exit $LASTEXITCODE
