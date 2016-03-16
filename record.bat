@if "%DEBUG%" == "" @echo off
@rem ##########################################################################
@rem
@rem  Screen record script for Windows
@rem
@rem ##########################################################################

set "HERE=%~dp0"

@rem %date% dépend de la locale.... sans commentaires
set filename=%HERE%videos\%time:~0,2%%time:~3,2%%time:~6,2%.mp4

echo Enregistrement du desktop dans %filename%
echo Pour arreter, lancer record-stop.bat

%HERE%\arch\win32\VLCPortable\App\VLC\vlc screen:// --one-instance -I dummy --dummy-quiet --screen-left=0 --screen-top=0 --screen-width=1280 --screen-height=1024 --no-video :screen-fps=5 :screen-caching=300 --sout "#transcode{vcodec=h264,vb=800,fps=5,scale=1,acodec=none}:duplicate{dst=std{access=file,mux=mp4,dst='%filename%'}}"