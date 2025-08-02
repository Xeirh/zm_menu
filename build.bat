echo off
set GAME_FOLDER=C:\Program Files (x86)\Steam\steamapps\common\Call of Duty Black Ops II
set OAT_BASE=C:\Users\xexde\OneDrive\Documents\OpenAssetTools
set MOD_BASE=%cd%
set MOD_NAME=zm_menu
"%OAT_BASE%\linker.exe" ^
--verbose ^
--base-folder "%OAT_BASE%" ^
--gdt-search-path "%cd%\zone_source" ^
--add-asset-search-path "%MOD_BASE%" ^
--asset-search-path "%MOD_BASE%" ^
--source-search-path "%MOD_BASE%\zone_source" ^
--output-folder "%MOD_BASE%\zone" mod

if %ERRORLEVEL% NEQ 0 pause

set err=%ERRORLEVEL%

if %err% EQU 0 (
XCOPY "%MOD_BASE%\zone\mod.ff" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.ff" /Y
XCOPY "%MOD_BASE%\zone\mod.iwd" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.iwd" /Y
XCOPY "%MOD_BASE%\mod.json" "%LOCALAPPDATA%\Plutonium\storage\t6\mods\%MOD_NAME%\mod.json" /Y
) ELSE (
COLOR C
echo FAIL!
)
pause