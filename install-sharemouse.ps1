# Define the URL for ShareMouse setup and the destination path
$url = "https://www.sharemouse.com/ShareMouseSetup.exe"
$dest = "$env:TEMP\ShareMouseSetup.exe"

# Download ShareMouse installer
Write-Output "Downloading ShareMouse installer..."
Invoke-WebRequest -Uri $url -OutFile $dest -UseBasicParsing

# Check if the download was successful
if (Test-Path -Path $dest) {
    Write-Output "Download complete. Running installer..."
    
    # Run the ShareMouse installer in silent mode
    Start-Process -FilePath $dest -ArgumentList "/silent" -Wait

    Write-Output "Installation complete."

    # Delete the scheduled task used to run this script with elevated privileges
    Write-Output "Cleaning up scheduled task..."
    schtasks /delete /tn InstallShareMouse /f
    Write-Output "Scheduled task deleted."
} else {
    Write-Output "Download failed. Please check the URL or network connection."
}
