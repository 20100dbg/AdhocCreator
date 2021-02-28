@echo off

title Wifi AdHoc Network Creator 0.1

rem 1 - Vérifie les droits admin (obligatoire pour créer le réseau)
rem NET FILE 1>NUL 2>NUL & IF ERRORLEVEL 1 (ECHO need admin rights & pause & exit /b)

rem 2 - Demande le nom du réseau (SSID)
set /p ssid=Nom du reseau : 

rem 3 - Demande le mot de passe (facultatif)
set /p key=Utiliser un mot de passe ? (facultatif, min 8 car) : 

rem 4 - Inscription du profil
cd %~dp0
netsh wlan add profile MonProfil.xml

rem 5a - Modification du profil
netsh wlan set profileparameter name=MonProfil SSIDname=%ssid% connectionType=IBSS

rem 5b - Modification du profil
if not "%key%"=="" (
netsh wlan set profileparameter name=MonProfil authentication=WPA2PSK encryption=AES keyType=passphrase useOneX=no keyMaterial=%key%
)

rem 6 - Connexion au profil
netsh wlan connect name=MonProfil ssid=%ssid%

rem 7 - bonus : affichage des interfaces (montre le réseau connecté)
netsh wlan show interfaces
pause