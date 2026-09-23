@echo off

REM Warning message
echo ********************************************************************************
echo WARNING: Unauthorized access is prohibited!
echo WE KNOW WHO YOU ARE
echo ********************************************************************************

REM Type sync
rem net time

REM Delete previous drive mappings
echo Removing previous drive mappings...
NET USE G: /DELETE >NUL 2>NUL /Y
NET USE H: /DELETE >NUL 2>NUL /Y
NET USE I: /DELETE >NUL 2>NUL /Y
NET USE J: /DELETE >NUL 2>NUL /Y
NET USE K: /DELETE >NUL 2>NUL /Y
NET USE L: /DELETE >NUL 2>NUL /Y
NET USE M: /DELETE >NUL 2>NUL /Y
NET USE N: /DELETE >NUL 2>NUL /Y
NET USE O: /DELETE >NUL 2>NUL /Y
NET USE P: /DELETE >NUL 2>NUL /Y
NET USE Q: /DELETE >NUL 2>NUL /Y
NET USE R: /DELETE >NUL 2>NUL /Y
NET USE S: /DELETE >NUL 2>NUL /Y
NET USE T: /DELETE >NUL 2>NUL /Y
NET USE U: /DELETE >NUL 2>NUL /Y
NET USE V: /DELETE >NUL 2>NUL /Y
NET USE W: /DELETE >NUL 2>NUL /Y
NET USE X: /DELETE >NUL 2>NUL /Y
NET USE Y: /DELETE >NUL 2>NUL /Y
NET USE Z: /DELETE >NUL 2>NUL /Y

REM Map drivers
echo Mapping drives...
NET USE X: \\192.168.1.130\wstat01 /user:backup123 B@ckup1

REM Exit script
echo Closing down window...
exit