SET SUFFIX=%TIME:~0,-6%
SET SUFFIX=%SUFFIX::=%
SET SUFFIX=%SUFFIX: =0%
SET SUFFIX=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%_%SUFFIX%
SET ZIP=c:\progra~1\7-zip\7z.exe
SET BRCC32=d:\appl\borland\delphi22\bin\brcc32.exe -32
%BRCC32% data\db.rc > ..\dcu\db.res-%SUFFIX%.log
erase /F/Q/ ..\res\images.res
%BRCC32% ..\res\images.rc > ..\dcu\images.res-%SUFFIX%.log