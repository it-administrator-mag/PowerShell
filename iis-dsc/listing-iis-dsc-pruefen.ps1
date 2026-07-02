Configuration MeineWebsite
{
  Node ("s1.contoso.int", "s2.contoso.int")
  {
  #IIS-Installation sicherstellen
WindowsFeature IIS
{
Ensure = "Present"
Name = "Web-Server"
  }
  #Existenz Webdateien sicherstellen
File Beispieldatei
  {
  Ensure = "Present"
  Type = "Directory"
  Recurse= $true
  SourcePath = "\\dc01\Daten"
  Destinationpath = "C:\inetpub\wwwroot"
  }
  }
}
