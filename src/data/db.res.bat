SET SUFFIX=%TIME:~0,-6%
SET SUFFIX=%SUFFIX::=%
SET SUFFIX=%SUFFIX: =0%
SET SUFFIX=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%_%SUFFIX%
SET RESPATH=D:\projects\pascal\DaVinciAndroid\src\data
SET LOGPATH=D:\projects\pascal\DaVinciAndroid\build
cd %RESPATH%
D:\appl\borland\delphi22\bin\brcc32.exe -32 %RESPATH%\db.rc > ..\..\dcu\db.res-%SUFFIX%.log
