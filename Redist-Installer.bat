@echo off
:: Permalink: https://git.io/redists


:: Run as Admin
set "params=%*"
cd /d "%~dp0" && ( if exist "%temp%\getadmin.vbs" del "%temp%\getadmin.vbs" ) && fsutil dirty query %systemdrive% 1>nul 2>nul || (  echo Set UAC = CreateObject^("Shell.Application"^) : UAC.ShellExecute "cmd.exe", "/k cd ""%~sdp0"" && %~s0 %params%", "", "runas", 1 >> "%temp%\getadmin.vbs" && "%temp%\getadmin.vbs" && exit /B )

title Redist Installer

md %temp%\Redist-Installer >nul 2>&1
cd %temp%\Redist-Installer

:: Some of the following files are pulled from Discord's CDN. This is because they have been pulled from M$'s website multiple times in the past.
echo Downloading 1/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/vs/16/release/vc_redist.x86.exe', 'vcredist2015_2017_2019_x86.exe')"
echo Downloading 2/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/vs/16/release/vc_redist.x64.exe', 'vcredist2015_2017_2019_x64.exe')"
echo Downloading 3/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/highdpimfc2013x64enu', '2013_x64.exe')"
echo Downloading 4/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://aka.ms/highdpimfc2013x86enu', '2013_x86.exe')"
echo Downloading 5/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x64.exe', '2012_x64.exe')"
echo Downloading 6/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/1/6/B/16B06F60-3B20-4FF2-B699-5E9B7962F9AE/VSU_4/vcredist_x86.exe', '2012_x86.exe')"
echo Downloading 7/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/5/B/C/5BC5DBB3-652D-4DCE-B14A-475AB85EEF6E/vcredist_x86.exe', '2010_x86.exe')"
echo Downloading 8/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/3/2/2/3224B87F-CFA0-4E70-BDA3-3DE650EFEBA5/vcredist_x64.exe', '2010_x64.exe')"
echo Downloading 9/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/839636091417919488/2008_x86.exe', '2008_x86.exe')"
echo Downloading 10/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/839636081263640586/2008_x64.exe', '2008_x64.exe')"
echo Downloading 11/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x86.EXE', '2005_x86.exe')"
echo Downloading 12/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://download.microsoft.com/download/8/B/4/8B42259F-5D70-43F4-AC2E-4B208FD8D66A/vcredist_x64.EXE', '2005_x64.exe')"
echo Downloading 13/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/804707669428535366/dxwebsetup.exe', 'DirectX.exe')"
echo Downloading 14/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/785666488219992084/DX90c_Addon_Installer.exe', 'DirectXA.exe')"
echo Downloading 15/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://go.microsoft.com/fwlink/?LinkId=863262', 'dotNET.exe')"
echo Downloading 16/16...
powershell -Command "(New-Object Net.WebClient).DownloadFile('https://cdn.discordapp.com/attachments/710609237805498500/1004773678103404686/msxmlenu.msi', 'msxmlenu.msi')"

echo Installing 1/16...
vcredist2015_2017_2019_x86.exe /install /quiet /norestart
echo Installing 2/16...
vcredist2015_2017_2019_x64.exe /install /quiet /norestart
echo Installing 3/16...
2013_x86.exe /install /quiet /norestart
echo Installing 4/16...
2013_x64.exe /install /quiet /norestart
echo Installing 5/16...
2012_x86.exe /install /quiet /norestart
echo Installing 6/16...
2012_x64.exe /install /quiet /norestart
echo Installing 7/16...
2010_x86.exe /install /quiet /norestart
echo Installing 8/16...
2010_x64.exe /install /quiet /norestart
echo Installing 9/16...
2008_x86.exe /install /quiet /norestart
echo Installing 10/16...
2008_x64.exe /install /quiet /norestart
echo Installing 11/16...
2005_x86.exe /Q
echo Installing 12/16...
2005_x64.exe /Q
echo Installing 13/16...
start /wait DirectX.exe /Q
echo Installing 14/16...
start /wait DirectXA.exe /VERYSILENT /SUPPRESSMSGBOXES /NORESTART /SP-
echo Installing 15/16...
start /wait dotNET.exe /Q
echo Installing 16/16...
start /wait msxmlenu.msi /qn /L* "%temp%\XML Parser 4.0.log" /norestart ALLUSERS=2 >nul 2>&1

cd %temp%
rmdir %temp%\Redist-Installer /s /q
exit
