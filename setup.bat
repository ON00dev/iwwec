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

REM Adiciona o diretório de destino ao PATH apenas se não estiver presente
for %%A in ("%PATH:;=" "%") do (
    if /I "%%~A"=="%DEST_DIR%" (
        goto :EOF
    )
)

REM Adiciona o diretório ao PATH do sistema
setx PATH "%PATH%;%DEST_DIR%"

echo Complete installation. You can use the 'iwwerc' command from anywhere.
pause
