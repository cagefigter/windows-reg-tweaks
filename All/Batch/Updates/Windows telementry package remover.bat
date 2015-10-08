@echo off

echo[
echo Welcome To windows telementry package Remover
echo ----------------------------------------------
echo[

wusa /uninstall /KB:3075249 /quiet /norestart
wusa /uninstall /KB:3080149 /quiet /norestart
wusa /uninstall /KB:2505438 /quiet /norestart
wusa /uninstall /KB:2670838 /quiet /norestart
wusa /uninstall /KB:2952664 /quiet /norestart
wusa /uninstall /KB:2976978 /quiet /norestart
wusa /uninstall /KB:3021917 /quiet /norestart
wusa /uninstall /KB:3035583 /quiet /norestart
wusa /uninstall /KB:3075249 /quiet /norestart

echo[
echo Remove Upgrade offer KB's - GWX
echo ----------------------------------------------
echo[
wusa /uninstall /KB:2952664 /quiet /norestart
wusa /uninstall /KB:3021917 /quiet /norestart
wusa /uninstall /KB:3035583 /quiet /norestart
wusa /uninstall /KB:3075249 /quiet /norestart
wusa /uninstall /KB:3075851 /quiet /norestart
wusa /uninstall /KB:3035583 /quiet /norestart

Pause&Exit