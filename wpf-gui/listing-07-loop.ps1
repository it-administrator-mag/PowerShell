$btnZenz = $window.FindName("CmdZenz")
$btnZenz.Add_Click({
$chkNerv1= $window.FindName("ChkNerv1")
$chkNerv2 = $window.FindName("ChkNerv2")
If($chkNerv1.IsChecked){
If($chkNerv2.IsChecked){
for ($i = 1; $i -le 10; $i++) {
Start-Sleep -Seconds 2
Write-Host "Ping"
$txtAusgabe.Text =
$txtAusgabe.Text + " XXX "
} }
}
}
