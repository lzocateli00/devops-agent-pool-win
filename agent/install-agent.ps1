#Esse script esta sendo executado dentro do container
[CmdletBinding()] 
param(
  [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
  [string]$pathAgent = "C:\agent"
)


Write-Host "Starting: $($MyInvocation.MyCommand.Definition)"

if (-not (Test-Path $pathAgent)) {
  New-Item $pathAgent -ItemType directory | Out-Null
}
  
Set-Location $pathAgent


if (-not (Test-Path $pathAgent/bin/Agent.Listener.dll)) {
  $destinationPack = "$(Get-Location)\agent.zip"
  
  Write-Host "Downloading Azure Pipelines agent... $destinationPack" -ForegroundColor Cyan

  [Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12


  $agentVersion = "2.186.1"
  Write-Host "Invoking agent version: $agentVersion"

  Invoke-WebRequest `
    -Uri "https://vstsagentpackage.azureedge.net/agent/$agentVersion/vsts-agent-win-x64-$agentVersion.zip" `
    -OutFile $destinationPack

   
  Expand-Archive -Path $destinationPack -DestinationPath $pathAgent

  Remove-Item -Path $destinationPack

  ./install-azcli.ps1
    
}