SET SUFFIX=%TIME:~0,-6%
SET SUFFIX=%SUFFIX::=%
SET SUFFIX=%SUFFIX: =0%
SET SUFFIX=%DATE:~-4%%DATE:~3,2%%DATE:~0,2%_%SUFFIX%
SET ZIP=c:\progra~1\7-zip\7z.exe
SET IMAGEPATH=D:\projects\php\davinci.co.ua\images\tmc540\
SET RESPATH=D:\projects\pascal\DaVinciAndroid\res
cd %RESPATH%
erase /F/Q/ imagestmc.zip
%ZIP% A -tzip %RESPATH%\imagestmc.zip %IMAGEPATH%\*.jpg