@echo off

rem ##############################################
rem ##  Backup Script for E drive and C:\Users  ##
rem ##############################################

rem Map Network Drive W: to NAS h8neta-nas
net use W: \\192.168.1.130\wstat01 /user:backup123 B@ckup1

rem Copy the D: Data Drive on h8netw-wstat01 to h8neta-nas
robocopy "d:" "w:\D_Data" /S /E /COPYALL /R:1 /W:0

rem Copy the C:\Users directory on h8net-wstat01 to h8neta-nas
robocopy "c:\Users" "W:\C_Users" /MIR /SEC /L /R:0 /W:0

rem Disconnect the W: Network Drive
net use W: /DELETE >NUL 2>NUL /Y

rem Closing down...
exit