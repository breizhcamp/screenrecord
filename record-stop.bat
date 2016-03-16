@if "%DEBUG%" == "" @echo off

set "HERE=%~dp0"
%HERE%\arch\win32\VLCPortable\App\VLC\vlc --one-instance vlc://quit