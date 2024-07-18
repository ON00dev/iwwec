@echo off
setlocal

REM Nome do executável
set EXE_NAME=iwwerc.exe

REM Caminho do destino
set DEST_DIR=%ProgramFiles%\iwwerC
set DEST_EXE=%DEST_DIR%\%EXE_NAME%

REM Cria o diretório de destino se não existir
if not exist "%DEST_DIR%" (
    mkdir "%DEST_DIR%"
)

REM Copia o executável para o diretório de destino
copy "dist\%EXE_NAME%" "%DEST_EXE%"

REM Adiciona o diretório ao PATH do sistema, se não estiver presente
setlocal enabledelayedexpansion
set "CURRENT_PATH=%PATH%"
for %%A in ("%PATH:;=" "%") do (
    if /I "%%~A"=="%DEST_DIR%" (
        echo Directory already in PATH.
        goto :EOF
    )
)

REM Adiciona o diretório ao PATH do sistema
echo Adding directory to PATH...
setx PATH "%CURRENT_PATH%;%DEST_DIR%"

echo Complete installation. You can use the 'iwwerc' command from anywhere.
pause