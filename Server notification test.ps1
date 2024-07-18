$server = "0.0.0.0"  # Replace with your server's private IP address
$emailTo = ""
$emailFrom = ""
$smtpServer = ""
$SMTPPort = 587
$SMTPUsername = ""  # Add your SMTP username
$SMTPPassword = ""  # Add your SMTP password

$response = Test-Connection -ComputerName $server -Count 2 -Quiet

if (-not $response) {
    $subject = "Server Down Notification Test"
    $body = "The Test sauna VPN IP address $server is down."
    
    $message = New-Object system.net.mail.mailmessage
    $message.From = $emailFrom
    $message.To.add($emailTo)
    $message.Subject = $subject
    $message.Body = $body
    
    $smtp = New-Object Net.Mail.SmtpClient($smtpServer, $SMTPPort)
    $smtp.EnableSsl = $true  # Set this to $false if your SMTP server doesn't use SSL
    $smtp.Credentials = New-Object System.Net.NetworkCredential($SMTPUsername, $SMTPPassword)
    
    try {
        $smtp.Send($message)
        Write-Output "Email sent successfully."
    } catch {
        Write-Output "Failed to send email. Error: $_"
    }
} else {
    Write-Output "Server is up."
}
