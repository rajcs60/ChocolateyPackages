#In order perform an unattended installation the setup.iss file must be in the same directory as the installer
 
$chocTempDir = Join-Path $env:TEMP "chocolatey"
$tempDir = Join-Path $chocTempDir "couchbase-server-community"
   
if (![System.IO.Directory]::Exists($tempDir)) {
  [System.IO.Directory]::CreateDirectory($tempDir)
}
 
$scriptPath = Split-Path -parent $MyInvocation.MyCommand.Definition
$setupConfig = Join-Path $scriptPath "setup.iss"
 
$ahkFile = Join-Path $scriptPath "chocolateyInstall.ahk"
$ahkExe = 'AutoHotKey'
 
Start-Process $ahkExe $ahkFile
 
Install-ChocolateyPackage `
  -PackageName "couchbase-server-community" `
  -FileType "EXE" `
  -SilentArgs "/S /f1""$setupConfig""" `
  -Url64bit "http://packages.couchbase.com/releases/4.5.0/couchbase-server-community_4.5.0-windows_amd64.exe"  `
  -ChecksumType64 "sha256" `
  -Checksum64 "292D068B8625B42C8E363A39EE2EFC15FCC1B3DFD53AF48EC8B9C7D316312F2B" `
  -ValidExitCodes @(0)