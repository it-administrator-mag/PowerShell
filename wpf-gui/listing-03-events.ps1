$window = [Windows.Mark-up.XamlReader]::
Load($reader)
$btnFauch = $window.FindName("CmdFauch")
$txtVictim = $window.FindName
("TxtVictimName")
$btnFauch.Add_Click({
$txtVictim.Text = "Fauch!"
})
$window.ShowDialog()
