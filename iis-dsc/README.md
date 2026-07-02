# Configuration „MeineWebsite“

## Beschreibung

Dieses Beispiel zeigt eine einfache **PowerShell Desired State Configuration (DSC)**, mit der zwei Server automatisch als Webserver konfiguriert werden. Die Konfiguration installiert zunächst den IIS-Webserver und kopiert anschließend die Inhalte einer zentralen Netzwerkfreigabe in das Standard-Webverzeichnis.

Dadurch erhalten beide Zielsysteme eine identische Konfiguration und denselben Webinhalt.

## Voraussetzungen

- Windows PowerShell 5.1 oder neuer
- DSC aktiviert (Local Configuration Manager)
- Administrative Berechtigungen auf den Zielsystemen
- Netzwerkzugriff auf die Freigabe `\\dc01\Daten`
- Die Zielserver sind per WinRM erreichbar

## Funktionsweise

Die Konfiguration wird auf die beiden Computer

- `s1.contoso.int`
- `s2.contoso.int`

angewendet.

Dabei erfolgen folgende Schritte:

1. Installation der Windows-Rolle **Web-Server (IIS)**.
2. Überprüfung, ob das Webverzeichnis vorhanden ist.
3. Rekursives Kopieren sämtlicher Dateien aus der Freigabe `\\dc01\Daten`.
4. Ablage der Dateien im IIS-Standardverzeichnis `C:\inetpub\wwwroot`.

## Verwendete DSC-Ressourcen

| Ressource | Aufgabe |
|-----------|---------|
| `WindowsFeature` | Installiert den IIS-Webserver |
| `File` | Erstellt das Zielverzeichnis und kopiert die Webinhalte |

## Wichtige Parameter

### WindowsFeature

| Parameter | Bedeutung |
|-----------|-----------|
| `Ensure = "Present"` | Stellt sicher, dass IIS installiert ist |
| `Name = "Web-Server"` | Installiert die Windows-Rolle IIS |

### File

| Parameter | Bedeutung |
|-----------|-----------|
| `Ensure = "Present"` | Stellt sicher, dass die Dateien vorhanden sind |
| `Type = "Directory"` | Verarbeitet ein Verzeichnis |
| `Recurse = $true` | Kopiert alle Unterverzeichnisse |
| `SourcePath` | Netzwerkfreigabe mit den Webdateien |
| `DestinationPath` | Zielverzeichnis des IIS |

## Kompilieren der Konfiguration

```powershell
. .\MeineWebsite.ps1

MeineWebsite
```

Dadurch entsteht ein Ordner **MeineWebsite**, der für jeden Zielserver eine MOF-Datei enthält.

## Anwenden

```powershell
Start-DscConfiguration -Path .\MeineWebsite -Wait -Force -Verbose
```

## Ergebnis

Nach erfolgreicher Ausführung

- ist IIS auf beiden Servern installiert,
- befinden sich die Webdateien unter `C:\inetpub\wwwroot`,
- besitzen beide Server denselben Webseiteninhalt.

## Hinweise

- Die Netzwerkfreigabe muss für das Computerkonto beziehungsweise das verwendete Benutzerkonto lesbar sein.
- In produktiven Umgebungen empfiehlt es sich, zusätzlich den gewünschten Zustand der IIS-Websites, Anwendungspools sowie SSL-Zertifikate ebenfalls per DSC zu verwalten.
- Die Konfiguration lässt sich problemlos um weitere DSC-Ressourcen wie `Service`, `Registry`, `Script` oder das Modul **xWebAdministration** erweitern.
