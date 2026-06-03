$btnZenz = $window.FindName("CmdZenz")
$btnZenz.Add_Click({
$chkNerv1= $window.FindName("ChkNerv1")
$chkNerv2 = $window.FindName("ChkNerv2")
If($chkNerv1.IsChecked){
If($chkNerv2.IsChecked){
$window.DialogResult=$true
}
}
})
