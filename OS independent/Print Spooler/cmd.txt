net stop spooler

DEL /F /S /Q %systemroot%\System32\spool\PRINTERS\*

net start spooler