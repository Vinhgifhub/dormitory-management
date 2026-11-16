@echo off
setlocal EnableExtensions EnableDelayedExpansion

if not exist "%~dp0PTIT_KTX.exe" (
    echo PTIT_KTX.exe is missing.
    pause
    exit /b 1
)
if not exist "%~dp0app\PTIT_KTX.cfg" (
    echo app\PTIT_KTX.cfg is missing.
    pause
    exit /b 1
)

set "APPDRIVE="
for %%D in (Z Y X W V U T S R Q P O N M L K J I H G F E) do (
    if exist "%%D:\PTIT_KTX.exe" (
        fc /b "%~dp0PTIT_KTX.exe" "%%D:\PTIT_KTX.exe" >nul 2>&1
        if not errorlevel 1 (
            fc /b "%~dp0app\PTIT_KTX.cfg" "%%D:\app\PTIT_KTX.cfg" >nul 2>&1
            if not errorlevel 1 (
                set "APPDRIVE=%%D:"
                goto launch
            )
        )
    )
)

for %%D in (Z Y X W V U T S R Q P O N M L K J I H G F E) do (
    if not exist "%%D:\" (
        subst "%%D:" "%~dp0" >nul 2>&1
        if not errorlevel 1 (
            set "APPDRIVE=%%D:"
            goto launch
        )
    )
)

echo Could not find or create an ASCII drive mapping for the app.
pause
exit /b 1

:launch
pushd "!APPDRIVE!\"
start "" "!APPDRIVE!\PTIT_KTX.exe"
popd
