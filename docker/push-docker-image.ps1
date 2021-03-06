# https://docs.microsoft.com/en-us/azure/devops/pipelines/agents/docker?view=azure-devops#windows

[CmdletBinding()] 
param(
    [Parameter(Position = 0, Mandatory, ValueFromPipeline)]
    [string] $dockerId,
    [Parameter(Position = 1, ValueFromPipeline)]
    [string] $dockerToken
)

Clear-Host

$localScript = $MyInvocation.MyCommand.Source.Replace($MyInvocation.MyCommand.Name, "")
$scriptName = $MyInvocation.MyCommand.Name
Write-Host "Start script: $localScript$scriptName at: $(Get-Date)"


if ([string]::IsNullOrWhiteSpace($dockerToken)) {
    docker login -u $dockerId --password-stdin
}
else {
    docker login -u $dockerId -p $dockerToken
}


$imageName = "devops-agent-pool-win"
$imageTag = "1.0.0"
$DockerBuildTag = "$dockerId/${imageName}:$imageTag"

docker push $DockerBuildTag
