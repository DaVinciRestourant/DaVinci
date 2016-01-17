SET SUFFIX=%TIME:~0,-6%
SET SUFFIX=%SUFFIX::=%
SET SUFFIX=%SUFFIX: =0%
SET SUFFIX=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%_%SUFFIX%
SET ZIP=c:\progra~1\7-zip\7z.exe
SET SRCPATH=D:\projects\pascal\DaVinciAndroid\src
SET RESPATH=D:\projects\pascal\DaVinciAndroid\res
cd %RESPATH%
erase /F/Q/ images.res
D:\appl\borland\delphi22\bin\brcc32.exe -32 %RESPATH%\images.rc > %RESPATH%\images.res-%SUFFIX%.log