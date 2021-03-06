Push-Location (Split-Path -Path $MyInvocation.MyCommand.Definition -Parent)

# Load posh-git module from current directory
Import-Module C:\tools\poshgit\dahlbyk-posh-git-5bb4844\posh-git

# If module is installed in a default location ($env:PSModulePath),
# use this instead (see about_Modules for more information):
# Import-Module posh-git


# Set up a simple prompt, adding the git prompt parts inside git repos
function global:prompt {
    $realLASTEXITCODE = $LASTEXITCODE

    Write-Host($pwd.ProviderPath) -nonewline

    Write-VcsStatus

    $global:LASTEXITCODE = $realLASTEXITCODE
    return "> "
}

Pop-Location

Start-SshAgent -Quiet
import-module phatgit
 Set-Location -Path $env:userprofile

 function Delete-MergedBranches ($Commit = 'HEAD', [switch]$Force) {
    git branch --merged $Commit |
        ? { $_ -notmatch '(^\*)|(^. master$)' } |
        % { git branch $(if($Force) { '-D' } else { "-d" }) $_.Substring(2) }
}