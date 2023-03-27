$output = netsh wlan show profiles
$profiles = $output | Select-String "All User Profile\s*:\s*(.*)"
foreach ($profile in $profiles) {
    $profileName = $profile.Matches.Groups[1].Value
    $output = netsh wlan show profile name=$profileName key=clear
    $password = ($output | Select-String "Key Content\s*:\s*(.*)").Matches.Groups[1].Value.Trim()
    Write-Output "Profile: $profileName, Password: $password"
}
