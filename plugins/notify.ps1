param(
  [Parameter(ValueFromRemainingArguments = $true)]
  [string[]]$Text
)

$msg = ($Text -join " ").Trim()
if (-not $msg) { $msg = "OpenCode task completed" }

try {
  [Windows.UI.Notifications.ToastNotificationManager, Windows.UI.Notifications, ContentType = WindowsRuntime] | Out-Null
  [Windows.Data.Xml.Dom.XmlDocument, Windows.Data.Xml.Dom, ContentType = WindowsRuntime] | Out-Null
  $xml = New-Object Windows.Data.Xml.Dom.XmlDocument
  $xml.LoadXml(@"
<toast>
  <visual>
    <binding template="ToastGeneric">
      <text>OpenCode</text>
      <text>$([System.Security.SecurityElement]::Escape($msg))</text>
    </binding>
  </visual>
</toast>
"@)
  $toast = [Windows.UI.Notifications.ToastNotification]::new($xml)
  [Windows.UI.Notifications.ToastNotificationManager]::CreateToastNotifier("OpenCode").Show($toast)
} catch {
  Add-Type -AssemblyName System.Windows.Forms | Out-Null
  $notify = New-Object System.Windows.Forms.NotifyIcon
  $notify.Icon = [System.Drawing.SystemIcons]::Information
  $notify.Visible = $true
  $notify.ShowBalloonTip(4000, "OpenCode", $msg, [System.Windows.Forms.ToolTipIcon]::Info)
  Start-Sleep -Milliseconds 500
  $notify.Dispose()
}
