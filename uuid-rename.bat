@echo off
setlocal enabledelayedexpansion

REM Check if a folder path is provided as an argument
if "%~1"=="" (
    echo No folder path provided.
    exit /b 1
)

set "folder_path=%~1"

REM Check if the provided path is a valid directory
if not exist "%folder_path%" (
    echo The provided path is not a valid directory.
    exit /b 1
)

REM Function to generate a UUID
:generate_uuid
setlocal enabledelayedexpansion
for /f "tokens=2 delims={}" %%A in ('"powershell [guid]::NewGuid().ToString()"') do (
    endlocal & set "uuid=%%A"
)
exit /b 0

REM Rename files in the specified folder
cd /d "%folder_path%"
for %%F in (*) do (
    call :generate_uuid
    set "file_extension=%%~xF"
    ren "%%F" "!uuid!!file_extension!"
    echo Renamed "%%F" to "!uuid!!file_extension!"
)

echo Files renamed successfully.
endlocal
exit /b 0
