#Esse script esta sendo executado dentro do container
[CmdletBinding()] 
param(
  [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
  [string]$pathAgent = "C:\agent"
)

Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"

if (-not [string]::IsNullOrWhiteSpace($env:AZP_TOKEN)) {
  Remove-Item $Env:AZP_TOKEN
}

# $dotnetRoot=""
# [Environment]::SetEnvironmentVariable("DOTNET_ROOT", $dotnetRoot, 'Machine')

Set-Location $pathAgent
    
Write-Host "Executing run.cmd in $PWD ..."

./run.cmd