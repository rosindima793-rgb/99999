param(
  [string]$TargetRepo = 'https://github.com/rosindima793-rgb/99999.git',
  [string]$Branch = 'main'
)

Write-Host "Preparing to push to $TargetRepo on branch $Branch"

# Ensure working tree is clean
$status = git status --porcelain
if ($status) {
  Write-Host "Working tree is not clean. Commit or stash changes before pushing." -ForegroundColor Red
  exit 1
}

# Add remote if missing
$remotes = git remote
if ($remotes -notmatch 'target') {
  git remote add target $TargetRepo
}

git push target HEAD:$Branch --follow-tags
Write-Host "Pushed to target repository." -ForegroundColor Green
