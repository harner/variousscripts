ECHO OFF
rem This script will clear the d:\Temp folder every 24 hours at midnight. CMH 20170707
d:
FOR /D %%G IN (D:\Temp\*) DO rmdir "%%G" /s /q
FOR /R D:\Temp\ %%G IN (*.*) DO del "%%G"
COPY "D:\Tech\Scripts\Temp Folder Purge\Temp_READ_ME.txt" d:\Temp\Temp_READ_ME.txt
EXIT
